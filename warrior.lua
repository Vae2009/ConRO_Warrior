ConRO.Warrior = {};
ConRO.Warrior.CheckTalents = function()
end
ConRO.Warrior.CheckPvPTalents = function()
end
local ConRO_Warrior, ids = ...;

function ConRO:EnableRotationModule(mode)
	mode = mode or 0;
	self.ModuleOnEnable = ConRO.Warrior.CheckTalents;
	self.ModuleOnEnable = ConRO.Warrior.CheckPvPTalents;
	if mode == 0 then
		self.Description = "Warrior [No Specialization Under 10]";
		self.NextSpell = ConRO.Warrior.Under10;
		self.ToggleHealer();
	end;
	if mode == 1 then
		self.Description = 'Warrior [Arms - Melee]';
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextSpell = ConRO.Warrior.Arms;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Warrior.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);
		end
	end;
	if mode == 2 then
		self.Description = 'Warrior [Fury - Melee]';
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextSpell = ConRO.Warrior.Fury;
			self.ToggleDamage();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Warrior.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);
		end
	end;
	if mode == 3 then
		self.Description = 'Warrior [Protection - Tank]';
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextSpell = ConRO.Warrior.Protection;
			self.ToggleDamage();
			self.BlockAoE();
			ConROWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
			ConRODefenseWindow:SetAlpha(ConRO.db.profile.transparencyWindow);
		else
			self.NextSpell = ConRO.Warrior.Disabled;
			self.ToggleHealer();
			ConROWindow:SetAlpha(0);
			ConRODefenseWindow:SetAlpha(0);
		end
	end;
	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self.lastSpellId = 0;
end

function ConRO:EnableDefenseModule(mode)
	mode = mode or 0;
	if mode == 0 then
		self.NextDef = ConRO.Warrior.Under10Def;
	end;
	if mode == 1 then
		if ConRO.db.profile._Spec_1_Enabled then
			self.NextDef = ConRO.Warrior.ArmsDef;
		else
			self.NextDef = ConRO.Warrior.Disabled;
		end
	end;
	if mode == 2 then
		if ConRO.db.profile._Spec_2_Enabled then
			self.NextDef = ConRO.Warrior.FuryDef;
		else
			self.NextDef = ConRO.Warrior.Disabled;
		end
	end;
	if mode == 3 then
		if ConRO.db.profile._Spec_3_Enabled then
			self.NextDef = ConRO.Warrior.ProtectionDef;
		else
			self.NextDef = ConRO.Warrior.Disabled;
		end
	end;
end

function ConRO:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConRO.Warrior.Disabled(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	return nil;
end

--Info
local _Player_Level = UnitLevel("player");
local _Player_Percent_Health = ConRO:PercentHealth('player');
local _is_PvP = ConRO:IsPvP();
local _in_combat = UnitAffectingCombat('player');
local _party_size = GetNumGroupMembers();
local _is_PC = UnitPlayerControlled("target");
local _is_Enemy = ConRO:TarHostile();
local _Target_Health = UnitHealth('target');
local _Target_Percent_Health = ConRO:PercentHealth('target');

--Resources
local _Rage, _Rage_Max = ConRO:PlayerPower('Rage');

--Conditions
local _Queue = 0;
local _is_moving = ConRO:PlayerSpeed();
local _enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
local _enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");
local _enemies_in_25yrds, _target_in_25yrds = ConRO:Targets("25");
local _enemies_in_40yrds, _target_in_40yrds = ConRO:Targets("40");
local _can_Execute = _Target_Percent_Health < 20;

--Racials
local _AncestralCall, _AncestralCall_RDY = _, _;
local _ArcanePulse, _ArcanePulse_RDY = _, _;
local _Berserking, _Berserking_RDY = _, _;
local _ArcaneTorrent, _ArcaneTorrent_RDY = _, _;

local HeroSpec, Racial = ids.HeroSpec, ids.Racial;

function ConRO:Stats()
	_Player_Level = UnitLevel("player");
	_Player_Percent_Health = ConRO:PercentHealth('player');
	_is_PvP = ConRO:IsPvP();
	_in_combat = UnitAffectingCombat('player');
	_party_size = GetNumGroupMembers();
	_is_PC = UnitPlayerControlled("target");
	_is_Enemy = ConRO:TarHostile();
	_Target_Health = UnitHealth('target');
	_Target_Percent_Health = ConRO:PercentHealth('target');

	_Rage, _Rage_Max = ConRO:PlayerPower('Rage');

	_Queue = 0;
	_is_moving = ConRO:PlayerSpeed();
	_enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
	_enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");
	_enemies_in_25yrds, _target_in_25yrds = ConRO:Targets("25");
	_enemies_in_40yrds, _target_in_40yrds = ConRO:Targets("40");
	_can_Execute = _Target_Percent_Health < 20;

	_AncestralCall, _AncestralCall_RDY = ConRO:AbilityReady(Racial.AncestralCall, timeShift);
	_ArcanePulse, _ArcanePulse_RDY = ConRO:AbilityReady(Racial.ArcanePulse, timeShift);
	_Berserking, _Berserking_RDY = ConRO:AbilityReady(Racial.Berserking, timeShift);
	_ArcaneTorrent, _ArcaneTorrent_RDY = ConRO:AbilityReady(Racial.ArcaneTorrent, timeShift);
end

function ConRO.Warrior.Under10(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedSpells);
	ConRO:Stats();
	local Ability, Form, Buff, Debuff, PetAbility, PvPTalent = ids.Warrior_Ability, ids.Warrior_Form, ids.Warrior_Buff, ids.Warrior_Debuff, ids.Warrior_PetAbility, ids.Warrior_PvPTalent;

--Abilities

--Conditions

--Warnings

--Rotations	


	return nil;
end

function ConRO.Warrior.Under10Def(_, timeShift, currentSpell, gcd, tChosen, pvpChosen)
	wipe(ConRO.SuggestedDefSpells);
	ConRO:Stats();
	local Ability, Form, Buff, Debuff, PetAbility, PvPTalent = ids.Warrior_Ability, ids.Warrior_Form, ids.Warrior_Buff, ids.Warrior_Debuff, ids.Warrior_PetAbility, ids.Warrior_PvPTalent;

--Abilities

--Conditions

--Warnings

--Rotations	

	return nil;
end

function ConRO.Warrior.Arms(_, timeShift, currentSpell, gcd, tChosen)
	wipe(ConRO.SuggestedSpells);
	ConRO:Stats();
	local Ability, Form, Buff, Debuff, PetAbility, PvPTalent = ids.Arms_Ability, ids.Arms_Form, ids.Arms_Buff, ids.Arms_Debuff, ids.Arms_PetAbility, ids.Arms_PvPTalent;

--Abilities	
	local _Avatar, _Avatar_RDY = ConRO:AbilityReady(Ability.Avatar, timeShift);
	local _BattleShout, _BattleShout_RDY = ConRO:AbilityReady(Ability.BattleShout, timeShift);
	local _Bladestorm, _Bladestorm_RDY = ConRO:AbilityReady(Ability.Bladestorm, timeShift);
		local _MercilessBonegrinder_BUFF = ConRO:Aura(Buff.MercilessBonegrinder, timeShift);
		local _Hurricane_BUFF = ConRO:Aura(Buff.Hurricane, timeShift);
	local _Charge, _Charge_RDY = ConRO:AbilityReady(Ability.Charge, timeShift);
		local _Charge_RANGE = ConRO:Targets(Ability.Charge);
	local _Cleave, _Cleave_RDY = ConRO:AbilityReady(Ability.Cleave, timeShift);
	local _ColossusSmash, _ColossusSmash_RDY = ConRO:AbilityReady(Ability.ColossusSmash, timeShift);
		local _ColossusSmash_DEBUFF = ConRO:TargetAura(Debuff.ColossusSmash, timeShift);
		local _InForTheKill_BUFF = ConRO:Aura(Buff.InForTheKill, timeShift);
		local _TestofMight_BUFF = ConRO:Aura(Buff.TestofMight, timeShift);
	local _Demolish, _Demolish_RDY = ConRO:AbilityReady(Ability.Demolish, timeShift);
	local _Execute, _Execute_RDY = ConRO:AbilityReady(Ability.Execute, timeShift);
		local _Juggernaut_BUFF, _, _Juggernaut_DUR	= ConRO:Aura(Buff.Juggernaut, timeShift);
		local _SuddenDeath_BUFF, _SuddenDeath_COUNT	= ConRO:Aura(Buff.SuddenDeath, timeShift);
		local _MarkedforExecution_BUFF, _MarkedforExecution_COUNT = ConRO:TargetAura(Debuff.MarkedforExecution, timeShift);
		local _, _ExecutionersPrecision_COUNT = ConRO:Aura(Buff.ExecutionersPrecision, timeShift);
	local _HeroicThrow, _HeroicThrow_RDY = ConRO:AbilityReady(Ability.HeroicThrow, timeShift);
	local _MortalStrike, _MortalStrike_RDY = ConRO:AbilityReady(Ability.MortalStrike, timeShift);
		local _DeepWounds_DEBUFF = ConRO:TargetAura(Debuff.DeepWounds, timeShift);
	local _Overpower, _Overpower_RDY = ConRO:AbilityReady(Ability.Overpower, timeShift);
		local _Overpower_CHARGES = ConRO:SpellCharges(_Overpower);
		local _, _Overpower_COUNT = ConRO:Aura(Buff.Overpower, timeShift);
		local _Opportunist_BUFF = ConRO:Aura(Buff.Opportunist, timeShift);
	local _Pummel, _Pummel_RDY = ConRO:AbilityReady(Ability.Pummel, timeShift);
	local _Ravager, _Ravager_RDY = ConRO:AbilityReady(Ability.Ravager, timeShift);
		local _Ravager_BUFF = ConRO:Aura(Buff.Ravager, timeShift);
	local _Rend, _Rend_RDY = ConRO:AbilityReady(Ability.Rend, timeShift);
		local _Rend_DEBUFF, _, _Rend_DUR = ConRO:TargetAura(Debuff.Rend, timeShift);
	local _ShatteringThrow, _ShatteringThrow_RDY = ConRO:AbilityReady(Ability.ShatteringThrow, timeShift);
		local _IceBlock_BUFF = ConRO:UnitAura(45438, timeShift, 'target', 'HELPFUL');
		local _DivineShield_BUFF = ConRO:UnitAura(642, timeShift, 'target', 'HELPFUL');
	local _Skullsplitter, _Skullsplitter_RDY = ConRO:AbilityReady(Ability.Skullsplitter, timeShift);
	local _Slam, _Slam_RDY = ConRO:AbilityReady(Ability.Slam, timeShift);
	local _ChampionsSpear, _ChampionsSpear_RDY = ConRO:AbilityReady(Ability.ChampionsSpear, timeShift);
	local _StormBolt, _StormBolt_RDY = ConRO:AbilityReady(Ability.StormBolt, timeShift);
	local _SweepingStrikes, _SweepingStrikes_RDY = ConRO:AbilityReady(Ability.SweepingStrikes, timeShift);
		local _SweepingStrikes_BUFF = ConRO:Aura(Buff.SweepingStrikes, timeShift);
	local _ThunderClap, _ThunderClap_RDY = ConRO:AbilityReady(Ability.ThunderClap, timeShift);
	local _ThunderousRoar, _ThunderousRoar_RDY = ConRO:AbilityReady(Ability.ThunderousRoar, timeShift);
	local _Whirlwind, _Whirlwind_RDY = ConRO:AbilityReady(Ability.Whirlwind, timeShift);

--Conditions
	if tChosen[Ability.Massacre.talentID] then
		_can_Execute = _Target_Percent_Health <= 35;
		_Execute, _Execute_RDY = ConRO:AbilityReady(Ability.MassacreExecute, timeShift);
	end

	if tChosen[Ability.Warbreaker.talentID] then
		_ColossusSmash, _ColossusSmash_RDY = ConRO:AbilityReady(Ability.Warbreaker, timeShift);
	end

--Indicators		
	ConRO:AbilityInterrupt(_Pummel, _Pummel_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityPurge(_ShatteringThrow, _ShatteringThrow_RDY and (_IceBlock_BUFF or _DivineShield_BUFF));
	ConRO:AbilityRaidBuffs(_BattleShout, _BattleShout_RDY and not ConRO:RaidBuff(Buff.BattleShout));
	ConRO:AbilityMovement(_Charge, _Charge_RDY and _Charge_RANGE);

	ConRO:AbilityBurst(_Avatar, _Avatar_RDY and ConRO:BurstMode(_Avatar));
	ConRO:AbilityBurst(_Bladestorm, _Bladestorm_RDY and _ColossusSmash_DEBUFF and not _SweepingStrikes_BUFF and ConRO:BurstMode(_Bladestorm));
	ConRO:AbilityBurst(_ChampionsSpear, _ChampionsSpear_RDY and _ColossusSmash_DEBUFF and ConRO:BurstMode(_ChampionsSpear));
	ConRO:AbilityBurst(_ColossusSmash, _ColossusSmash_RDY and not _ColossusSmash_DEBUFF and ConRO:BurstMode(_ColossusSmash));
	ConRO:AbilityBurst(_Ravager, _Ravager_RDY and ConRO:BurstMode(_Ravager));
	ConRO:AbilityBurst(_ThunderousRoar, _ThunderousRoar_RDY and _target_in_10yrds and ConRO:BurstMode(_ThunderousRoar));

--Warnings

--Rotations
	for i = 1, 2, 1 do
		if _Cleave_RDY and _SweepingStrikes_BUFF and _MercilessBonegrinder_BUFF then
			tinsert(ConRO.SuggestedSpells, _Cleave);
			_Cleave_RDY = false;
		end

		if _ThunderClap_RDY and (not _Rend_DEBUFF or _Rend_DUR < 4) and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) and tChosen[Ability.Rend.talentID] then
			tinsert(ConRO.SuggestedSpells, _ThunderClap);
			_ThunderClap_RDY = false;
			_Rend_DEBUFF = true;
			_Rend_DUR = 10;
		end

		if _SweepingStrikes_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) and ConRO:HeroSpec(HeroSpec.Slayer) then
			tinsert(ConRO.SuggestedSpells, _SweepingStrikes);
			_SweepingStrikes_RDY = false;
		end

		if _Rend_RDY and (not _Rend_DEBUFF or _Rend_DUR < 4) then
			tinsert(ConRO.SuggestedSpells, _Rend);
			_Rend_DEBUFF = true;
			_Rend_RDY = false;
			_Rend_DUR = 10;
		end

		if _ThunderousRoar_RDY and _target_in_10yrds and ConRO:FullMode(_ThunderousRoar) then
			tinsert(ConRO.SuggestedSpells, _ThunderousRoar);
			_ThunderousRoar_RDY = false;
		end

		if _Ravager_RDY then
			tinsert(ConRO.SuggestedSpells, _Ravager);
			_Ravager_RDY = false;
		end

		if _Avatar_RDY and _ColossusSmash_RDY and ConRO:FullMode(_Avatar) then
			tinsert(ConRO.SuggestedSpells, _Avatar);
			_Avatar_RDY = false;
		end

		if _SweepingStrikes_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
			tinsert(ConRO.SuggestedSpells, _SweepingStrikes);
			_SweepingStrikes_RDY = false;
		end

		if _Skullsplitter_RDY and _SweepingStrikes_BUFF then
			tinsert(ConRO.SuggestedSpells, _Skullsplitter);
			_Skullsplitter_RDY = false;
		end

		if _ColossusSmash_RDY and not _ColossusSmash_DEBUFF	and ConRO:FullMode(_ColossusSmash) then
			tinsert(ConRO.SuggestedSpells, _ColossusSmash);
			_ColossusSmash_RDY = false;
		end

		if _ChampionsSpear_RDY and _ColossusSmash_DEBUFF and ConRO:FullMode(_ChampionsSpear) then
			tinsert(ConRO.SuggestedSpells, _ChampionsSpear);
			_ChampionsSpear_RDY = false;
		end

		if ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
			if _Cleave_RDY then
				tinsert(ConRO.SuggestedSpells, _Cleave);
				_Cleave_RDY = false;
			end

			if _Demolish_RDY and _SweepingStrikes_BUFF and ConRO:HeroSpec(HeroSpec.Colossus) then
				tinsert(ConRO.SuggestedSpells, _Demolish);
				_Demolish_RDY = false;
			end

			if _Overpower_RDY and _Overpower_CHARGES >= 1 and _SweepingStrikes_BUFF and ConRO:HeroSpec(HeroSpec.Slayer) then
				tinsert(ConRO.SuggestedSpells, _Overpower);
				_Overpower_CHARGES = _Overpower_CHARGES - 1;
			end

			if _Overpower_RDY and _Overpower_CHARGES >= 1 and ConRO:HeroSpec(HeroSpec.Colossus) then
				tinsert(ConRO.SuggestedSpells, _Overpower);
				_Overpower_CHARGES = _Overpower_CHARGES - 1;
			end

			if _MortalStrike_RDY and _SweepingStrikes_BUFF and ConRO:HeroSpec(HeroSpec.Colossus) then
				tinsert(ConRO.SuggestedSpells, _MortalStrike);
				_MortalStrike_RDY = false;
			end

			if _Execute_RDY and _SweepingStrikes_BUFF and _SuddenDeath_COUNT >= 1 and ConRO:HeroSpec(HeroSpec.Colossus) then
				tinsert(ConRO.SuggestedSpells, _Execute);
				_SuddenDeath_COUNT = _SuddenDeath_COUNT - 1;
			end

			if _Bladestorm_RDY and ConRO:FullMode(_Bladestorm) then
				tinsert(ConRO.SuggestedSpells, _Bladestorm);
				_Bladestorm_RDY = false;
			end

			if _Execute_RDY and (_SuddenDeath_COUNT >= 1 or _MarkedforExecution_BUFF or _Rage > 40) then
				tinsert(ConRO.SuggestedSpells, _Execute);
				_SuddenDeath_COUNT = _SuddenDeath_COUNT - 1;
			end

			if _MortalStrike_RDY and _SweepingStrikes_BUFF then
				tinsert(ConRO.SuggestedSpells, _MortalStrike);
				_MortalStrike_RDY = false;
			end

			if _Overpower_RDY and _Overpower_CHARGES >= 1 and ConRO:HeroSpec(HeroSpec.Slayer) then
				tinsert(ConRO.SuggestedSpells, _Overpower);
				_Overpower_CHARGES = _Overpower_CHARGES - 1;
			end

			if _ThunderClap_RDY then
				tinsert(ConRO.SuggestedSpells, _ThunderClap);
				_ThunderClap_RDY = false;
				_Rend_DEBUFF = true;
			end

			if _MortalStrike_RDY and ConRO:HeroSpec(HeroSpec.Slayer) then
				tinsert(ConRO.SuggestedSpells, _MortalStrike);
				_MortalStrike_RDY = false;
			end
		else
			if _can_Execute then
				if _Demolish_RDY and _ColossusSmash_DEBUFF and ConRO:HeroSpec(HeroSpec.Colossus) then
					tinsert(ConRO.SuggestedSpells, _Demolish);
					_Demolish_RDY = false;
				end
	
				if _MortalStrike_RDY and _ExecutionersPrecision_COUNT >= 2 and not _Ravager_BUFF and ConRO:HeroSpec(HeroSpec.Colossus) then
					tinsert(ConRO.SuggestedSpells, _MortalStrike);
					_MortalStrike_RDY = false;
				end
	
				if _Bladestorm_RDY and _ExecutionersPrecision_COUNT >= 2 and ConRO:FullMode(_Bladestorm) then
					tinsert(ConRO.SuggestedSpells, _Bladestorm);
					_Bladestorm_RDY = false;
				end
	
				if _Skullsplitter_RDY and _Rage < 85 then
					tinsert(ConRO.SuggestedSpells, _Skullsplitter);
					_Skullsplitter_RDY = false;
				end
	
				if _MortalStrike_RDY and (_ExecutionersPrecision_COUNT >= 2 or _Rend_DUR < 4) and ConRO:HeroSpec(HeroSpec.Slayer) then
					tinsert(ConRO.SuggestedSpells, _MortalStrike);
					_MortalStrike_RDY = false;
				end
	
				if _Overpower_RDY and _Overpower_CHARGES >= 1 and _Rage < 80 and _Opportunist_BUFF and _Overpower_COUNT < 2 then
					tinsert(ConRO.SuggestedSpells, _Overpower);
					_Overpower_CHARGES = _Overpower_CHARGES - 1;
				end
	
				if _Execute_RDY and _Rage >= 20 then
					tinsert(ConRO.SuggestedSpells, _Execute);
					_SuddenDeath_COUNT = _SuddenDeath_COUNT - 1;
				end
	
				if _Overpower_RDY and _Overpower_CHARGES >= 1 then
					tinsert(ConRO.SuggestedSpells, _Overpower);
					_Overpower_CHARGES = _Overpower_CHARGES - 1;
				end
			else
				if _MortalStrike_RDY and ConRO:HeroSpec(HeroSpec.Colossus) then
					tinsert(ConRO.SuggestedSpells, _MortalStrike);
					_MortalStrike_RDY = false;
				end

				if _Demolish_RDY and ConRO:HeroSpec(HeroSpec.Colossus) then
					tinsert(ConRO.SuggestedSpells, _Demolish);
					_Demolish_RDY = false;
				end

				if _Execute_RDY and _SuddenDeath_COUNT >= 2 or (_SuddenDeath_COUNT >= 1 and (_MarkedforExecution_COUNT >= 3 or _Juggernaut_DUR < 2)) then
					tinsert(ConRO.SuggestedSpells, _Execute);
					_SuddenDeath_COUNT = _SuddenDeath_COUNT - 1;
				end

				if _Bladestorm_RDY and _ColossusSmash_DEBUFF and ConRO:FullMode(_Bladestorm) then
					tinsert(ConRO.SuggestedSpells, _Bladestorm);
					_Bladestorm_RDY = false;
				end

				if _Overpower_RDY and _Overpower_CHARGES >= 1 and _Opportunist_BUFF then
					tinsert(ConRO.SuggestedSpells, _Overpower);
					_Overpower_CHARGES = _Overpower_CHARGES - 1;
				end

				if _MortalStrike_RDY then
					tinsert(ConRO.SuggestedSpells, _MortalStrike);
					_MortalStrike_RDY = false;
				end

				if _Skullsplitter_RDY then
					tinsert(ConRO.SuggestedSpells, _Skullsplitter);
					_Skullsplitter_RDY = false;
				end

				if _Execute_RDY and _SuddenDeath_COUNT >= 1 and ConRO:HeroSpec(HeroSpec.Colossus) then
					tinsert(ConRO.SuggestedSpells, _Execute);
					_SuddenDeath_COUNT = _SuddenDeath_COUNT - 1;
				end

				if _Overpower_RDY and _Overpower_CHARGES >= 1 then
					tinsert(ConRO.SuggestedSpells, _Overpower);
					_Overpower_CHARGES = _Overpower_CHARGES - 1;
				end

				if _Slam_RDY and _Rage >= 20 then
					tinsert(ConRO.SuggestedSpells, _Slam);
					_Rage = _Rage - 20;
				end
			end
		end
	end
	return nil;
end

function ConRO.Warrior.ArmsDef(_, timeShift, currentSpell, gcd, tChosen)
	wipe(ConRO.SuggestedDefSpells);
	ConRO:Stats();
	local Ability, Form, Buff, Debuff, PetAbility, PvPTalent = ids.Arms_Ability, ids.Arms_Form, ids.Arms_Buff, ids.Arms_Debuff, ids.Arms_PetAbility, ids.Arms_PvPTalent;

--Abilities	
	local _RallyingCry, _RallyingCry_RDY = ConRO:AbilityReady(Ability.RallyingCry, timeShift);
	local _DiebytheSword, _DiebytheSword_RDY = ConRO:AbilityReady(Ability.DiebytheSword, timeShift);
	local _IgnorePain, _IgnorePain_RDY = ConRO:AbilityReady(Ability.IgnorePain, timeShift);
		local _IgnorePain_BUFF = ConRO:Aura(Buff.IgnorePain, timeShift);
	local _VictoryRush, _VictoryRush_RDY = ConRO:AbilityReady(Ability.VictoryRush, timeShift);
		local _Victorious_BUFF = ConRO:Aura(Buff.Victorious, timeShift);

	local _DefensiveStance, _DefensiveStance_RDY = ConRO:AbilityReady(Ability.DefensiveStance, timeShift);
		local _DefensiveStance_FORM = ConRO:Form(Form.DefensiveStance);
	local _ImpendingVictory, _ImpendingVictory_RDY = ConRO:AbilityReady(Ability.ImpendingVictory, timeShift);

--Conditions

--Rotations	
	if _IgnorePain_RDY and _Rage >= _Rage_Max - 25 then
		tinsert(ConRO.SuggestedDefSpells, _IgnorePain);
	end

	if tChosen[Ability.ImpendingVictory.talentID] then
		if _ImpendingVictory_RDY and _Player_Percent_Health <= 70 then
			tinsert(ConRO.SuggestedDefSpells, _ImpendingVictory);
		end
	else
		if _VictoryRush_RDY and _Victorious_BUFF and _Player_Percent_Health <= 80 then
			tinsert(ConRO.SuggestedDefSpells, _VictoryRush);
		end
	end

	if _DiebytheSword_RDY then
		tinsert(ConRO.SuggestedDefSpells, _DiebytheSword);
	end

	if _RallyingCry_RDY then
		tinsert(ConRO.SuggestedDefSpells, _RallyingCry);
	end

	if _DefensiveStance_RDY and not _DefensiveStance_FORM then
		tinsert(ConRO.SuggestedDefSpells, _DefensiveStance);
	end
	return nil;
end

function ConRO.Warrior.Fury(_, timeShift, currentSpell, gcd, tChosen)
	wipe(ConRO.SuggestedSpells);
	ConRO:Stats();
	local Ability, Form, Buff, Debuff, PetAbility, PvPTalent = ids.Fury_Ability, ids.Fury_Form, ids.Fury_Buff, ids.Fury_Debuff, ids.Fury_PetAbility, ids.Fury_PvPTalent;

--Abilities	
	local _Avatar, _Avatar_RDY = ConRO:AbilityReady(Ability.Avatar, timeShift);
		local _Avatar_BUFF = ConRO:Aura(Buff.Avatar, timeShift);
	local _BattleShout, _BattleShout_RDY = ConRO:AbilityReady(Ability.BattleShout, timeShift);
	local _Bladestorm, _Bladestorm_RDY = ConRO:AbilityReady(Ability.Bladestorm, timeShift);
	local _Bloodbath, _Bloodbath_RDY = ConRO:AbilityReady(Ability.Bloodbath, timeShift);
	local _Bloodthirst, _Bloodthirst_RDY = ConRO:AbilityReady(Ability.Bloodthirst, timeShift + 0.5);
		local _Enrage_BUFF = ConRO:Aura(Buff.Enrage, timeShift);
	local _Charge, _Charge_RDY = ConRO:AbilityReady(Ability.Charge, timeShift);
		local _Charge_RANGE = ConRO:IsSpellInRange(Ability.Charge, 'target');
	local _CrushingBlow, _CrushingBlow_RDY = ConRO:AbilityReady(Ability.CrushingBlow, timeShift);
	local _Execute, _Execute_RDY = ConRO:AbilityReady(Ability.Execute, timeShift);
		local _, _, _AshenJuggernaut_DUR = ConRO:Aura(Buff.AshenJuggernaut, timeShift);
		local _SuddenDeath_BUFF	= ConRO:Aura(Buff.SuddenDeath, timeShift);
		local _MarkedforExecution_BUFF, _MarkedforExecution_COUNT = ConRO:TargetAura(Debuff.MarkedforExecution, timeShift);
	local _OdynsFury, _OdynsFury_RDY = ConRO:AbilityReady(Ability.OdynsFury, timeShift);
	local _Onslaught, _Onslaught_RDY = ConRO:AbilityReady(Ability.Onslaught, timeShift);
	local _Pummel, _Pummel_RDY = ConRO:AbilityReady(Ability.Pummel, timeShift);
	local _Rampage, _Rampage_RDY = ConRO:AbilityReady(Ability.Rampage, timeShift);
		local _RecklessAbandon_BUFF = ConRO:Aura(Buff.RecklessAbandon, timeShift);
	local _RagingBlow, _RagingBlow_RDY = ConRO:AbilityReady(Ability.RagingBlow, timeShift);
		local _Opportunist_BUFF = ConRO:Aura(Buff.Opportunist, timeShift);
		local _RagingBlow_CHARGES = ConRO:SpellCharges(_RagingBlow);
	local _Ravager, _Ravager_RDY = ConRO:AbilityReady(Ability.Ravager, timeShift);
	local _Recklessness, _Recklessness_RDY = ConRO:AbilityReady(Ability.Recklessness, timeShift);
		local _Recklessness_BUFF = ConRO:Aura(Buff.Recklessness, timeShift);
	local _Slam, _Slam_RDY = ConRO:AbilityReady(Ability.Slam, timeShift);
	local _ShatteringThrow, _ShatteringThrow_RDY = ConRO:AbilityReady(Ability.ShatteringThrow, timeShift);
		local _IceBlock_BUFF = ConRO:UnitAura(45438, timeShift, 'target', 'HELPFUL');
		local _DivineShield_BUFF = ConRO:UnitAura(642, timeShift, 'target', 'HELPFUL');
	local _ChampionsSpear, _ChampionsSpear_RDY = ConRO:AbilityReady(Ability.ChampionsSpear, timeShift);
	local _ThunderClap, _ThunderClap_RDY = ConRO:AbilityReady(Ability.ThunderClap, timeShift);
	local _ThunderBlast, _ThunderBlast_RDY = ConRO:AbilityReady(Ability.ThunderBlast, timeShift);
		local _ThunderBlast_BUFF = ConRO:Aura(Buff.ThunderBlast, timeShift);
	local _ThunderousRoar, _ThunderousRoar_RDY = ConRO:AbilityReady(Ability.ThunderousRoar, timeShift);
	local _Whirlwind, _Whirlwind_RDY = ConRO:AbilityReady(Ability.Whirlwind, timeShift);
		local _Whirlwind_BUFF = ConRO:Aura(Buff.Whirlwind, timeShift);

--Conditions
	if tChosen[Ability.Massacre.talentID] then
		_can_Execute = _Target_Percent_Health <= 35;
		_Execute, _Execute_RDY = ConRO:AbilityReady(Ability.MassacreExecute, timeShift);
	end

--Indicators	
	ConRO:AbilityInterrupt(_Pummel, _Pummel_RDY and ConRO:Interrupt());
	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityPurge(_ShatteringThrow, _ShatteringThrow_RDY and (_IceBlock_BUFF or _DivineShield_BUFF));
	ConRO:AbilityRaidBuffs(_BattleShout, _BattleShout_RDY and not ConRO:RaidBuff(Buff.BattleShout));
	ConRO:AbilityMovement(_Charge, _Charge_RDY and _Charge_RANGE);

	ConRO:AbilityBurst(_Avatar, _Avatar_RDY and _Recklessness_BUFF and ConRO:BurstMode(_Avatar));
	ConRO:AbilityBurst(_Bladestorm, _Bladestorm_RDY and _Enrage_BUFF and _Avatar_BUFF and ConRO:BurstMode(_Bladestorm));
	ConRO:AbilityBurst(_ChampionsSpear, _ChampionsSpear_RDY and _Enrage_BUFF and _Avatar_BUFF and ConRO:BurstMode(_ChampionsSpear));
	ConRO:AbilityBurst(_Ravager, _Ravager_RDY and _Enrage_BUFF and _Avatar_BUFF and ConRO:BurstMode(_Ravager));
	ConRO:AbilityBurst(_Recklessness, _Recklessness_RDY and ConRO:BurstMode(_Recklessness));
	ConRO:AbilityBurst(_ThunderousRoar, _ThunderousRoar_RDY and _Enrage_BUFF and _Avatar_BUFF and ConRO:BurstMode(_ThunderousRoar));

--Warnings


--Rotations
	repeat
		while(true) do
			if _ThunderBlast_RDY and ConRO:IsOverride(_ThunderClap) == _ThunderBlast and _ThunderBlast_BUFF and _Avatar_RDY then
				tinsert(ConRO.SuggestedSpells, _ThunderBlast);
				_ThunderBlast_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _Recklessness_RDY and ConRO:FullMode(_Recklessness) then
				tinsert(ConRO.SuggestedSpells, _Recklessness);
				_Recklessness_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _Avatar_RDY and ConRO:FullMode(_Avatar) then
				tinsert(ConRO.SuggestedSpells, _Avatar);
				_Avatar_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _Rampage_RDY and not _Enrage_BUFF then
				tinsert(ConRO.SuggestedSpells, _Rampage);
				_Rampage_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _ThunderBlast_RDY and ConRO:IsOverride(_ThunderClap) == _ThunderBlast and _ThunderBlast_BUFF and _Enrage_BUFF then
				tinsert(ConRO.SuggestedSpells, _ThunderBlast);
				_ThunderBlast_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _ThunderClap_RDY and tChosen[Ability.ImprovedWhirlwind.talentID] and not _Whirlwind_BUFF and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) and ConRO:HeroSpec(HeroSpec.MountainThane) and tChosen[Ability.CrashingThunder.talentID] then
				tinsert(ConRO.SuggestedSpells, _ThunderClap);
				_ThunderClap_BUFF = true;
				_Queue = _Queue + 1;
				break;
			end

			if _ThunderousRoar_RDY and _Enrage_BUFF and ConRO:FullMode(_ChampionsSpear) then
				tinsert(ConRO.SuggestedSpells, _ThunderousRoar);
				_ThunderousRoar_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _Ravager_RDY and ConRO:FullMode(_Ravager) then
				tinsert(ConRO.SuggestedSpells, _Ravager);
				_Ravager_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _ChampionsSpear_RDY and _Enrage_BUFF and ConRO:FullMode(_ChampionsSpear) then
				tinsert(ConRO.SuggestedSpells, _ChampionsSpear);
				_ChampionsSpear_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _Bladestorm_RDY and _Avatar_BUFF and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 3) or ConRO_AoEButton:IsVisible()) and ConRO:FullMode(_Bladestorm) then
				tinsert(ConRO.SuggestedSpells, _Bladestorm);
				_Bladestorm_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _OdynsFury_RDY and (_Enrage_BUFF or tChosen[Ability.TitanicRage.talentID]) then
				tinsert(ConRO.SuggestedSpells, _OdynsFury);
				_OdynsFury_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _Whirlwind_RDY and tChosen[Ability.ImprovedWhirlwind.talentID] and not _Whirlwind_BUFF and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) then
				tinsert(ConRO.SuggestedSpells, _Whirlwind);
				_Whirlwind_BUFF = true;
				_Queue = _Queue + 1;
				break;
			end

			if _Execute_RDY and (_can_Execute or _SuddenDeath_BUFF) and (_MarkedforExecution_COUNT >= 3 or _AshenJuggernaut_DUR < 2) then
				tinsert(ConRO.SuggestedSpells, _Execute);
				_Execute_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _Bladestorm_RDY and _Enrage_BUFF and ConRO:FullMode(_Bladestorm) then
				tinsert(ConRO.SuggestedSpells, _Bladestorm);
				_Bladestorm_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _Rampage_RDY and tChosen[Ability.AngerManagement.talentID] then
				tinsert(ConRO.SuggestedSpells, _Rampage);
				_Rampage_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _CrushingBlow_RDY and ConRO:IsOverride(_RagingBlow) == _CrushingBlow and _RagingBlow_CHARGES >= 1 then
				tinsert(ConRO.SuggestedSpells, _CrushingBlow);
				_RagingBlow_CHARGES = _RagingBlow_CHARGES - 1;
				_Queue = _Queue + 1;
				break;
			end

			if _Onslaught_RDY then
				tinsert(ConRO.SuggestedSpells, _Onslaught);
				_Onslaught_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _Bloodbath_RDY and ConRO:IsOverride(_Bloodthirst) == _Bloodbath and (_Rage < 100 or (tChosen[Ability.ViciousContempt.talentID] and _Target_Percent_Health < 35)) then
				tinsert(ConRO.SuggestedSpells, _Bloodbath);
				_Bloodbath_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _RagingBlow_RDY and _RagingBlow_CHARGES >= 1 and _Rage < 100 and not _Opportunist_BUFF and ConRO:HeroSpec(HeroSpec.Slayer) then
				tinsert(ConRO.SuggestedSpells, _RagingBlow);
				_RagingBlow_CHARGES = _RagingBlow_CHARGES - 1;
				_Queue = _Queue + 1;
				break;
			end

			if _RagingBlow_RDY and _RagingBlow_CHARGES >= 1 and _Rage < 100 and ConRO:HeroSpec(HeroSpec.MountainThane) then
				tinsert(ConRO.SuggestedSpells, _RagingBlow);
				_RagingBlow_CHARGES = _RagingBlow_CHARGES - 1;
				_Queue = _Queue + 1;
				break;
			end

			if _Rampage_RDY and tChosen[Ability.RecklessAbandon.talentID] and not _RecklessAbandon_BUFF then
				tinsert(ConRO.SuggestedSpells, _Rampage);
				_Rampage_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _Execute_RDY and (_can_Execute or _SuddenDeath_BUFF) and _MarkedforExecution_BUFF then
				tinsert(ConRO.SuggestedSpells, _Execute);
				_Execute_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _RagingBlow_RDY and _RagingBlow_CHARGES >= 1 and not tChosen[Ability.RecklessAbandon.talentID] then
				tinsert(ConRO.SuggestedSpells, _RagingBlow);
				_RagingBlow_CHARGES = _RagingBlow_CHARGES - 1;
				_Queue = _Queue + 1;
				break;
			end

			if _Execute_RDY and (_can_Execute or _SuddenDeath_BUFF) and ConRO:HeroSpec(HeroSpec.MountainThane) then
				tinsert(ConRO.SuggestedSpells, _Execute);
				_Execute_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _Bloodthirst_RDY then
				tinsert(ConRO.SuggestedSpells, _Bloodthirst);
				_Bloodthirst_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _ThunderClap_RDY and ConRO:HeroSpec(HeroSpec.MountainThane) then
				tinsert(ConRO.SuggestedSpells, _ThunderClap);
				_ThunderClap_RDY = false;
				_Queue = _Queue + 1;
				break;
			end

			if _Whirlwind_RDY and ((ConRO_AutoButton:IsVisible() and _enemies_in_melee >= 2) or ConRO_AoEButton:IsVisible()) and not ConRO:HeroSpec(HeroSpec.MountainThane) then
				tinsert(ConRO.SuggestedSpells, _Whirlwind);
				_Whirlwind_BUFF = true;
				_Queue = _Queue + 1;
				break;
			end

			if _Slam_RDY and not ConRO:HeroSpec(HeroSpec.MountainThane) then
				tinsert(ConRO.SuggestedSpells, _Slam);
				_Queue = _Queue + 1;
				break;
			end

			_Queue = _Queue + 1;
			break;
		end
	until _Queue > 3;
return nil;
end

function ConRO.Warrior.FuryDef(_, timeShift, currentSpell, gcd, tChosen)
	wipe(ConRO.SuggestedDefSpells);
	ConRO:Stats();
	local Ability, Form, Buff, Debuff, PetAbility, PvPTalent = ids.Fury_Ability, ids.Fury_Form, ids.Fury_Buff, ids.Fury_Debuff, ids.Fury_PetAbility, ids.Fury_PvPTalent;

--Abilities	
	local _RallyingCry, _RallyingCry_RDY = ConRO:AbilityReady(Ability.RallyingCry, timeShift);
	local _EnragedRegeneration, _EnragedRegeneration_RDY = ConRO:AbilityReady(Ability.EnragedRegeneration, timeShift);
	local _VictoryRush, _VictoryRush_RDY = ConRO:AbilityReady(Ability.VictoryRush, timeShift);
		local _Victorious_BUFF = ConRO:Aura(Buff.Victorious, timeShift);
	local _ImpendingVictory, _ImpendingVictory_RDY = ConRO:AbilityReady(Ability.ImpendingVictory, timeShift);

--Conditions

--Rotations	
	if tChosen[Ability.ImpendingVictory.talentID] then
		if _ImpendingVictory_RDY and _Player_Percent_Health <= 70 then
			tinsert(ConRO.SuggestedDefSpells, _ImpendingVictory);
		end
	else
		if _VictoryRush_RDY and _Victorious_BUFF and _Player_Percent_Health <= 80 then
			tinsert(ConRO.SuggestedDefSpells, _VictoryRush);
		end
	end

	if _EnragedRegeneration_RDY then
		tinsert(ConRO.SuggestedDefSpells, _EnragedRegeneration);
	end

	if _RallyingCry_RDY then
		tinsert(ConRO.SuggestedDefSpells, _RallyingCry);
	end
	return nil;
end

function ConRO.Warrior.Protection(_, timeShift, currentSpell, gcd, tChosen)
	wipe(ConRO.SuggestedSpells);
	ConRO:Stats();
	local Ability, Form, Buff, Debuff, PetAbility, PvPTalent = ids.Prot_Ability, ids.Prot_Form, ids.Prot_Buff, ids.Prot_Debuff, ids.Prot_PetAbility, ids.Prot_PvPTalent;

--Abilities	
	local _Avatar, _Avatar_RDY = ConRO:AbilityReady(Ability.Avatar, timeShift);
		local _Avatar_BUFF = ConRO:Aura(Buff.Avatar, timeShift);
	local _BattleShout, _BattleShout_RDY = ConRO:AbilityReady(Ability.BattleShout, timeShift);
	local _Charge, _Charge_RDY = ConRO:AbilityReady(Ability.Charge, timeShift);
		local _Charge_RANGE = ConRO:IsSpellInRange(Ability.Charge, 'target');
	local _Demolish, _Demolish_RDY = ConRO:AbilityReady(Ability.Demolish, timeShift);
		local _, _ColossalMight_COUNT = ConRO:Aura(Buff.ColossalMight, timeShift);
	local _DemoralizingShout, _DemoralizingShout_RDY = ConRO:AbilityReady(Ability.DemoralizingShout, timeShift);
	local _Devastate, _Devastate_RDY = ConRO:AbilityReady(Ability.Devastate, timeShift);
	local _Execute, _Execute_RDY = ConRO:AbilityReady(Ability.Execute, timeShift);
	local _Pummel, _Pummel_RDY = ConRO:AbilityReady(Ability.Pummel, timeShift);
	local _Ravager, _Ravager_RDY = ConRO:AbilityReady(Ability.Ravager, timeShift);
	local _Revenge, _Revenge_RDY = ConRO:AbilityReady(Ability.Revenge, timeShift);
		local _Revenge_BUFF = ConRO:Aura(Buff.Revenge, timeShift);
	local _ShatteringThrow, _ShatteringThrow_RDY = ConRO:AbilityReady(Ability.ShatteringThrow, timeShift);
		local _IceBlock_BUFF = ConRO:UnitAura(45438, timeShift, 'target', 'HELPFUL');
		local _DivineShield_BUFF = ConRO:UnitAura(642, timeShift, 'target', 'HELPFUL');
	local _ShieldBlock, _ShieldBlock_RDY = ConRO:AbilityReady(Ability.ShieldBlock, timeShift);
		local _ShieldBlock_CHARGES = ConRO:SpellCharges(_ShieldBlock);
		local _ShieldBlock_BUFF = ConRO:Aura(Buff.ShieldBlock, timeShift);
	local _ShieldCharge, _ShieldCharge_RDY = ConRO:AbilityReady(Ability.ShieldCharge, timeShift);
	local _ShieldSlam, _ShieldSlam_RDY, _ShieldSlam_CD = ConRO:AbilityReady(Ability.ShieldSlam, timeShift);
		local _ViolentOutburst_BUFF = ConRO:Aura(Buff.ViolentOutburst, timeShift);
	local _Shockwave, _Shockwave_RDY = ConRO:AbilityReady(Ability.Shockwave, timeShift);
	local _ChampionsSpear, _ChampionsSpear_RDY = ConRO:AbilityReady(Ability.ChampionsSpear, timeShift);
	local _StormBolt, _StormBolt_RDY = ConRO:AbilityReady(Ability.StormBolt, timeShift);
	local _Taunt, _Taunt_RDY = ConRO:AbilityReady(Ability.Taunt, timeShift);
	local _ThunderClap, _ThunderClap_RDY = ConRO:AbilityReady(Ability.ThunderClap, timeShift);
	local _ThunderBlast, _ThunderBlast_RDY = ConRO:AbilityReady(Ability.ThunderBlast, timeShift);
		local _ThunderBlast_BUFF = ConRO:Aura(Buff.ThunderBlast, timeShift);
	local _ThunderousRoar, _ThunderousRoar_RDY = ConRO:AbilityReady(Ability.ThunderousRoar, timeShift);

--Conditions

--Indicators		
	ConRO:AbilityInterrupt(_Pummel, _Pummel_RDY and ConRO:Interrupt());

	ConRO:AbilityPurge(_ArcaneTorrent, _ArcaneTorrent_RDY and _target_in_melee and ConRO:Purgable());
	ConRO:AbilityPurge(_ShatteringThrow, _ShatteringThrow_RDY and (_IceBlock_BUFF or _DivineShield_BUFF));
	ConRO:AbilityRaidBuffs(_BattleShout, _BattleShout_RDY and not ConRO:RaidBuff(Buff.BattleShout));
	ConRO:AbilityTaunt(_Taunt, _Taunt_RDY and (not ConRO:InRaid() or (ConRO:InRaid() and ConRO:TarYou())));
	ConRO:AbilityMovement(_Charge, _Charge_RDY and _Charge_RANGE);

	ConRO:AbilityBurst(_Avatar, _Avatar_RDY and _is_Enemy and ConRO:BurstMode(_Avatar));
	ConRO:AbilityBurst(_DemoralizingShout, _DemoralizingShout_RDY and tChosen[Ability.BoomingVoice.talentID] and _is_Enemy and ConRO:BurstMode(_DemoralizingShout));
	ConRO:AbilityBurst(_Ravager, _Ravager_RDY and _is_Enemy and ConRO:BurstMode(_Ravager));
	ConRO:AbilityBurst(_ShieldCharge, _ShieldCharge_RDY and ConRO:BurstMode(_ShieldCharge));
	ConRO:AbilityBurst(_ChampionsSpear, _ChampionsSpear_RDY and _in_combat and ConRO:BurstMode(_ChampionsSpear));

--Warnings

--Rotations
	for i = 1, 2, 1 do
		if _Ravager_RDY and ConRO:FullMode(_Ravager) then
			tinsert(ConRO.SuggestedSpells, _Ravager);
			_Ravager_RDY = false;
		end

		if _Avatar_RDY and ConRO:FullMode(_Avatar) then
			tinsert(ConRO.SuggestedSpells, _Avatar);
			_Avatar_RDY = false;
		end

		if _ShieldBlock_RDY and not _ShieldBlock_BUFF and _ShieldBlock_CHARGES >= 1 then
			tinsert(ConRO.SuggestedDefSpells, _ShieldBlock);
			_ShieldBlock_BUFF = true;
			_ShieldBlock_CHARGES = _ShieldBlock_CHARGES - 1;
		end

		if _DemoralizingShout_RDY and tChosen[Ability.BoomingVoice.talentID] and _target_in_10yrds and ConRO:FullMode(_DemoralizingShout) then
			tinsert(ConRO.SuggestedSpells, _DemoralizingShout);
			_DemoralizingShout_RDY = false;
		end

		if _Demolish_RDY and _ColossalMight_COUNT > 3 and ConRO:HeroSpec(HeroSpec.Colossus) then
			tinsert(ConRO.SuggestedSpells, _Demolish);
			_Demolish_RDY = false;
		end

		if _ThunderousRoar_RDY and ConRO:FullMode(_ThunderousRoar) then
			tinsert(ConRO.SuggestedSpells, _ThunderousRoar);
			_ThunderousRoar_RDY = false;
		end

		if _ChampionsSpear_RDY and ConRO:FullMode(_ChampionsSpear) then
			tinsert(ConRO.SuggestedSpells, _ChampionsSpear);
			_ChampionsSpear_RDY = false;
		end

		if _ThunderBlast_RDY and ConRO:IsOverride(_ThunderClap) == _ThunderBlast and _ThunderBlast_BUFF and _enemies_in_melee >= 2 then
			tinsert(ConRO.SuggestedSpells, _ThunderBlast);
			_ThunderBlast_RDY = false;
		end

		if _ViolentOutburst_BUFF then
			if _ThunderClap_RDY and _enemies_in_10yrds >= 4 then
				tinsert(ConRO.SuggestedSpells, _ThunderClap);
				_ThunderClap_RDY = false;
			elseif _ShieldSlam_RDY then
				tinsert(ConRO.SuggestedSpells, _ShieldSlam);
				_ShieldSlam_RDY = false;
			end
		end

		if _ShieldCharge_RDY and ConRO:FullMode(_ShieldCharge) then
			tinsert(ConRO.SuggestedSpells, _ShieldCharge);
			_ShieldCharge_RDY = false;
		end

		if _ShieldSlam_RDY then
			tinsert(ConRO.SuggestedSpells, _ShieldSlam);
			_ShieldSlam_RDY = false;
		end

		if _ThunderClap_RDY then
			tinsert(ConRO.SuggestedSpells, _ThunderClap);
			_ThunderClap_RDY = false;
		end

		if _Execute_RDY and _Rage >= 70 and _can_Execute and _enemies_in_10yrds < 4 then
			tinsert(ConRO.SuggestedSpells, _Execute);
			_Rage = _Rage - 40;
		end

		if _Revenge_RDY and (_Rage >= 50 or _Revenge_BUFF) then
			tinsert(ConRO.SuggestedSpells, _Revenge);
			_Revenge_BUFF = false;
		end

		if _Devastate_RDY and not tChosen[Ability.Devastator.talentID] then
			tinsert(ConRO.SuggestedSpells, _Devastate);
		end
	end
	return nil;
end

function ConRO.Warrior.ProtectionDef(_, timeShift, currentSpell, gcd, tChosen)
	wipe(ConRO.SuggestedDefSpells);
	ConRO:Stats();
	local Ability, Form, Buff, Debuff, PetAbility, PvPTalent = ids.Prot_Ability, ids.Prot_Form, ids.Prot_Buff, ids.Prot_Debuff, ids.Prot_PetAbility, ids.Prot_PvPTalent;

--Abilities	
	local _ShieldWall, _ShieldWall_RDY = ConRO:AbilityReady(Ability.ShieldWall, timeShift);
	local _ShieldBlock, _ShieldBlock_RDY = ConRO:AbilityReady(Ability.ShieldBlock, timeShift);
		local _ShieldBlock_CHARGES = ConRO:SpellCharges(_ShieldBlock);
		local _ShieldBlock_BUFF = ConRO:Aura(Buff.ShieldBlock, timeShift);
	local _LastStand, _LastStand_RDY = ConRO:AbilityReady(Ability.LastStand, timeShift);
	local _DemoralizingShout, _DemoralizingShout_RDY = ConRO:AbilityReady(Ability.DemoralizingShout, timeShift);
	local _VictoryRush, _VictoryRush_RDY = ConRO:AbilityReady(Ability.VictoryRush, timeShift);
		local _Victorious_BUFF = ConRO:Aura(Buff.Victorious, timeShift);
	local _ImpendingVictory, _ImpendingVictory_RDY = ConRO:AbilityReady(Ability.ImpendingVictory, timeShift);
	local _IgnorePain, _IgnorePain_RDY = ConRO:AbilityReady(Ability.IgnorePain, timeShift);
		local _IgnorePain_BUFF = ConRO:Aura(Buff.IgnorePain, timeShift);
	local _SpellReflection, _SpellReflection_RDY = ConRO:AbilityReady(Ability.SpellReflection, timeShift);

--Conditions

--Rotations	
	if _SpellReflection_RDY and (ConRO:BossCast() or ConRO:Interrupt()) and ConRO:TarYou() then
		tinsert(ConRO.SuggestedDefSpells, _SpellReflection);
	end

	if _ShieldBlock_RDY and not _ShieldBlock_BUFF and _ShieldBlock_CHARGES >= 1 and ConRO:TarYou() then
		tinsert(ConRO.SuggestedDefSpells, _ShieldBlock);
	end

	if tChosen[Ability.ImpendingVictory.talentID] then
		if _ImpendingVictory_RDY and _Player_Percent_Health <= 70 then
			tinsert(ConRO.SuggestedDefSpells, _ImpendingVictory);
		end
	else
		if _VictoryRush_RDY and _Victorious_BUFF and _Player_Percent_Health <= 80 then
			tinsert(ConRO.SuggestedDefSpells, _VictoryRush);
		end
	end

	if _LastStand_RDY and _Player_Percent_Health <= 40 then
		tinsert(ConRO.SuggestedDefSpells, _LastStand);
	end

	if _IgnorePain_RDY and not _IgnorePain_BUFF and _Rage >= 70 then
		tinsert(ConRO.SuggestedDefSpells, _IgnorePain);
	end

	if _DemoralizingShout_RDY then
		tinsert(ConRO.SuggestedDefSpells, _DemoralizingShout);
	end

	if _ShieldWall_RDY then
		tinsert(ConRO.SuggestedDefSpells, _ShieldWall);
	end
	return nil;
end