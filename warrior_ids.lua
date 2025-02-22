local ConRO_Warrior, ids = ...;

--General
	ids.Racial = {
		AncestralCall = {spellID = 274738},
		ArcanePulse = {spellID = 260364},
		ArcaneTorrent = {spellID = 50613},
		Berserking = {spellID = 26297},
		Cannibalize = {spellID = 20577},
		GiftoftheNaaru = {spellID = 59548},
		Shadowmeld = {spellID = 58984},
		SpatialRift = {spellID = 256948},
	}
	ids.HeroSpec = {
		Slayer = 60,
		MountainThane = 61,
		Colossus = 62,
	}

--Arms
	ids.Arms_Ability = {
	--Warrior Baseline
		BattleShout = {spellID = 6673},
		BerserkerRage = {spellID = 18499},
		Charge = {spellID = 100},
		Execute = {spellID = 163201},
		Hamstring = {spellID = 1715},
		HeroicThrow = {spellID = 57755},
		Pummel = {spellID = 6552},
		ShieldBlock = {spellID = 2565},
		ShieldSlam = {spellID = 23922},
		Slam = {spellID = 1464},
		Taunt = {spellID = 355},
		VictoryRush = {spellID = 34428},
		Whirlwind = {spellID = 1680},
	--Arms Baseline
		SweepingStrikes = {spellID = 260708},
		--Passive
		MasteryDeepWounds = {spellID = 262111},
		SeasonedSoldier = {spellID = 279423},
	--Warrior
		BattleStance = {spellID = 386164, talentID = 112184},
		DefensiveStance = {spellID = 386208, talentID = 114643},
		FastFootwork = {spellID = 382260, talentID = 112206},
		WarMachine = {spellID = 262231, talentID = 112185},
		LeechingStrikes = {spellID = 382258, talentID = 112238},
		Intervene = {spellID = 3411, talentID = 112186},
		ImpendingVictory = {spellID = 202168, talentID = 112183},
		HeroicLeap = {spellID = 6544, talentID = 112208},
		StormBolt = {spellID = 107570, talentID = 112198},
		IntimidatingShout = {spellID = 5246, talentID = 112252},
		SecondWind = {spellID = 29838, talentID = 112190},
		FrothingBerserker = {spellID = 392792, talentID = 112216},
		BoundingStride = {spellID = 202163, talentID = 112219},
		PainandGain = {spellID = 382549, talentID = 112217},
		ThunderClap = {spellID = 6343, talentID = 112205},
		CacophonousRoar = {spellID = 382954, talentID = 112251},
		Menace = {spellID = 275338, talentID = 112250},
		SpellReflection = {spellID = 23920, talentID = 112253},
		RallyingCry = {spellID = 97462, talentID = 112188},
		Shockwave = {spellID = 46968, talentID = 112242},
		CracklingThunder = {spellID = 203201, talentID = 118853},
		HonedReflexes = {spellID = 391271, talentID = 118850},
		CrushingForce = {spellID = 382764, talentID = 112209},
		BitterImmunity = {spellID = 383762, talentID = 112220},
		OverwhelmingRage = {spellID = 382767, talentID = 112245},
		RumblingEarth = {spellID = 275339, talentID = 112241},
		ReinforcedPlates = {spellID = 382939, talentID = 112235},
		WreckingThrow = {spellID = 384110, talentID = 112215},
		ShatteringThrow = {spellID = 64382, talentID = 112214},
		BarbaricTraining = {spellID = 383082, talentID = 112201},
		Sidearm = {spellID = 384404, talentID = 118845},
		DoubleTime = {spellID = 103827, talentID = 112249},
		SeismicReverberation = {spellID = 382956, talentID = 112218},
		ConcussiveBlows = {spellID = 383115, talentID = 118843},
		BerserkerShout = {spellID = 384100, talentID = 112211},
		PiercingHowl = {spellID = 12323, talentID = 112210},
		CruelStrikes = {spellID = 392777, talentID = 112248},
		WildStrikes = {spellID = 382946, talentID = 112224},
		TwoHandedWeaponSpecialization = {spellID = 382896, talentID = 112179},
		EnduranceTraining = {spellID = 382940, talentID = 112199},
		ArmoredtotheTeeth = {spellID = 384124, talentID = 112233},
		ThunderousRoar = {spellID = 384318, talentID = 112223},
		Avatar = {spellID = 107574, talentID = 112232},
		ChampionsSpear = {spellID = 376079, talentID = 112247},
		Uproar = {spellID = 391572, talentID = 112221},
		ThunderousWords = {spellID = 384969, talentID = 112222},
		BlademastersTorment = {spellID = 390138, talentID = 112229},
		WarlordsTorment = {spellID = 390140, talentID = 112228},
		PiercingChallenge = {spellID = 382948, talentID = 112246},
		ChampionsMight = {spellID = 386284, talentID = 112180},
	--Arms
		MortalStrike = {spellID = 12294, talentID = 112122},
		Overpower = {spellID = 7384, talentID = 112123},
		MartialProwess = {spellID = 316440, talentID = 112130},
		DiebytheSword = {spellID = 118038, talentID = 112128},
		ImprovedExecute = {spellID = 316405, talentID = 112125},
		ImprovedOverpower = {spellID = 385571, talentID = 112131},
		Bloodsurge = {spellID = 384361, talentID = 112129},
		FueledbyViolence = {spellID = 383103, talentID = 112127},
		StormWall = {spellID = 388807, talentID = 112121},
		IgnorePain = {spellID = 190456, talentID = 114738},
		SuddenDeath = {spellID = 29725, talentID = 112126},
		FervorofBattle = {spellID = 202316, talentID = 112124},
		Tactician = {spellID = 184783, talentID = 112134},
		ColossusSmash = {spellID = 167105, talentID = 112144},
		Impale = {spellID = 383430, talentID = 112146},
		Skullsplitter = {spellID = 260643, talentID = 112133},
		Rend = {spellID = 772, talentID = 112136},
		FinishingBlows = {spellID = 400205, talentID = 114733},
		AngerManagement = {spellID = 152278, talentID = 112143},
		SpitefulSerenity = {spellID = 400314, talentID = 114642},
		ExhilaratingBlows = {spellID = 383219, talentID = 112138},
		ImprovedSweepingStrikes = {spellID = 383155, talentID = 114641},
		CollateralDamage = {spellID = 334779, talentID = 114739},
		Cleave = {spellID = 845, talentID = 112147},
		Bloodborne = {spellID = 383287, talentID = 112135},
		Dreadnaught = {spellID = 262150, talentID = 112137},
		StrengthoofArms = {spellID = 400803, talentID = 119096},
		InForTheKill = {spellID = 248621, talentID = 112142},
		TestofMight = {spellID = 385008, talentID = 112141},
		BluntInstruments = {spellID = 383442, talentID = 112140},
		Warbreaker = {spellID = 262161, talentID = 112139},
		Massacre = {spellID = 281001, talentID = 112145},
			MassacreExecute = {spellID = 281000, talentID = 112145},
		StormofSwords = {spellID = 385512, talentID = 112119},
		DeftExperience = {spellID = 389308, talentID = 112309},
		ValorinVictory = {spellID = 383338, talentID = 112315},
		CriticalThinking = {spellID = 389306, talentID = 112317},
		Battlelord = {spellID = 386630, talentID = 114740},
		Bloodletting = {spellID = 383154, talentID = 112310},
		Bladestorm = {spellID = 227847, talentID = 112314},
		Ravager = {spellID = 228920, talentID = 119138},
		SharpenedBlades = {spellID = 383341, talentID = 112320},
		Juggernaut = {spellID = 383292, talentID = 112319},
		Fatality = {spellID = 383703, talentID = 112311},
		DanceofDeath = {spellID = 390713, talentID = 114639},
		Unhinged = {spellID = 386628, talentID = 112313},
		MercilessBonegrinder = {spellID = 383317, talentID = 112117},
		ExecutionersPrecision = {spellID = 386634, talentID = 112318},
	--Hero
	--Colossus
		Demolish = {spellID = 436358, talentID = 117415},
		MartialExpert = {spellID = 429638, talentID = 117409},
		ColossalMight = {spellID = 429634, talentID = 117416},
		Boneshaker = {spellID = 429639, talentID = 117386},
		Earthquaker = {spellID = 440992, talentID = 119858},
		OneAgainstMany = {spellID = 429637, talentID = 117396},
		ArterialBleed = {spellID = 440995, talentID = 119856},
		TideofBattle = {spellID = 429641, talentID = 117408},
		NoStrangertoPain = {spellID = 429644, talentID = 117412},
		VeteranVitality = {spellID = 440993, talentID = 119857},
		PracticedStrikes = {spellID = 429647, talentID = 117393},
		PreciseMight = {spellID = 431548, talentID = 117391},
		MountainofMuscleandScars = {spellID = 429642, talentID = 117403},
		DominanceoftheColossus = {spellID = 429636, talentID = 117390},
	--Slayer
		SlayersDominance = {spellID = 444767, talentID = 117411},
		ImminentDemise = {spellID = 444769, talentID = 117385},
		OverwhelmingBlades = {spellID = 444772, talentID = 117407},
		RelentlessPursuit = {spellID = 444776, talentID = 117392},
		ViciousAgility = {spellID = 444777, talentID = 123408},
		DeathDrive = {spellID = 444770, talentID = 117410},
		CullingCyclone = {spellID = 444778, talentID = 117383},
		BrutalFinish = {spellID = 446085, talentID = 123409},
		FierceFollowthrough = {spellID = 444773, talentID = 117384},
		Opportunist = {spellID = 444774, talentID = 123770},
		ShowNoMercy = {spellID = 444771, talentID = 117381},
		ReaptheStorm = {spellID = 444775, talentID = 117406},
		SlayersMalice = {spellID = 444779, talentID = 117398},
		UnrelentingOnslaught = {spellID = 444780, talentID = 117417},
			Bladestorm_UO = {spellID = 446035, talentID = 117417},
	}
	ids.Arms_Form = {
		DefensiveStance = 197690,
	}
	ids.Arms_Buff = {
		Avatar = 107574,
		BattleShout = 6673,
		DeadlyCalm = 262228,
		ExecutionersPrecision = 242188,
		IgnorePain = 190456,
		InForTheKill = 248622,
		Juggernaut = 383290,
		MercilessBonegrinder = 383316,
		Opportunist = 456120,
		Overpower = 7384,
		Ravager = 228920,
		SuddenDeath = 52437,
		SweepingStrikes = 260708,
		TestofMight = 385013,
		Victorious = 32216,
	}
	ids.Arms_Debuff = {
		ColossusSmash = 208086,
		DeepWounds = 262115,
		MarkedforExecution = 445584,
		MortalWounds = 115804,
		Rend = 388539,
	}
	ids.Arms_PetAbility = {

	}

--Fury
	ids.Fury_Ability = {
	--Warrior Baseline
		BattleShout = {spellID = 6673},
		BerserkerRage = {spellID = 18499},
		Charge = {spellID = 100},
		Execute = {spellID = 5308},
		Hamstring = {spellID = 1715},
		HeroicThrow = {spellID = 57755},
		Pummel = {spellID = 6552},
		ShieldBlock = {spellID = 2565},
		ShieldSlam = {spellID = 23922},
		Slam = {spellID = 1464},
		Taunt = {spellID = 355},
		VictoryRush = {spellID = 34428},
		Whirlwind = {spellID = 190411},
	--Fury Baseline
		--Passive
		DualWield = {spellID = 231842},
		Enrage = {spellID = 184361},
		MasteryUnshackledFury = {spellID = 76856},
		TitansGrip = {spellID = 46917},
	--Warrior
		BerserkerStance = {spellID = 386196, talentID = 112182},
		DefensiveStance = {spellID = 386208, talentID = 114643},
		FastFootwork = {spellID = 382260, talentID = 112206},
		WarMachine = {spellID = 346002, talentID = 112254},
		LeechingStrikes = {spellID = 382258, talentID = 112238},
		Intervene = {spellID = 3411, talentID = 112186},
		ImpendingVictory = {spellID = 202168, talentID = 112183},
		HeroicLeap = {spellID = 6544, talentID = 112208},
		StormBolt = {spellID = 107570, talentID = 112198},
		IntimidatingShout = {spellID = 5246, talentID = 112252},
		SecondWind = {spellID = 29838, talentID = 112190},
		FrothingBerserker = {spellID = 215571, talentID = 112213},
		BoundingStride = {spellID = 202163, talentID = 112219},
		PainandGain = {spellID = 382549, talentID = 112217},
		ThunderClap = {spellID = 6343, talentID = 112205},
		CacophonousRoar = {spellID = 382954, talentID = 112251},
		Menace = {spellID = 275338, talentID = 112250},
		SpellReflection = {spellID = 23920, talentID = 112253},
		RallyingCry = {spellID = 97462, talentID = 112188},
		Shockwave = {spellID = 46968, talentID = 112242},
		CracklingThunder = {spellID = 203201, talentID = 118853},
		HonedReflexes = {spellID = 391271, talentID = 118850},
		CrushingForce = {spellID = 382764, talentID = 112212},
		BitterImmunity = {spellID = 383762, talentID = 112220},
		OverwhelmingRage = {spellID = 382767, talentID = 112245},
		RumblingEarth = {spellID = 275339, talentID = 112241},
		ReinforcedPlates = {spellID = 382939, talentID = 112235},
		WreckingThrow = {spellID = 384110, talentID = 112215},
		ShatteringThrow = {spellID = 64382, talentID = 112214},
		BarbaricTraining = {spellID = 390674, talentID = 118849},
		Sidearm = {spellID = 384404, talentID = 118848},
		DoubleTime = {spellID = 103827, talentID = 112249},
		SeismicReverberation = {spellID = 382956, talentID = 112218},
		ConcussiveBlows = {spellID = 383115, talentID = 118843},
		BerserkerShout = {spellID = 384100, talentID = 112211},
		PiercingHowl = {spellID = 12323, talentID = 112210},
		CruelStrikes = {spellID = 392777, talentID = 112248},
		WildStrikes = {spellID = 382946, talentID = 112224},
		DualWieldSpecialization = {spellID = 382900, talentID = 112240},
		EnduranceTraining = {spellID = 391997, talentID = 112243},
		ArmoredtotheTeeth = {spellID = 384124, talentID = 112108},
		ThunderousRoar = {spellID = 384318, talentID = 112223},
		Avatar = {spellID = 107574, talentID = 114770},
		ChampionsSpear = {spellID = 376079, talentID = 112247},
		Uproar = {spellID = 391572, talentID = 112221},
		ThunderousWords = {spellID = 384969, talentID = 112222},
		BerserkersTorment = {spellID = 390123, talentID = 112227},
		TitansTorment = {spellID = 390135, talentID = 112226},
		PiercingChallenge = {spellID = 382948, talentID = 112246},
		ChampionsMight = {spellID = 386284, talentID = 112180},
	--Fury
		Bloodthirst = {spellID = 23881, talentID = 112261},
		RagingBlow = {spellID = 85288, talentID = 112265},
		FrenziedEnrage = {spellID = 383848, talentID = 112267},
		PowerfulEnrage = {spellID = 440277, talentID = 119112},
		EnragedRegeneration = {spellID = 184364, talentID = 112264},
		ImprovedExecute = {spellID = 316402, talentID = 112301},
		ImprovedBloodthirst = {spellID = 383852, talentID = 112266},
		FreshMeat = {spellID = 215568, talentID = 112268},
		Warpaint = {spellID = 208154, talentID = 112263},
		InvigoratingFury = {spellID = 383468, talentID = 112262},
		SuddenDeath = {spellID = 280721, talentID = 112300},
		Cruelty = {spellID = 392931, talentID = 112299},
		FocusinChaos = {spellID = 383486, talentID = 112272},
		Rampage = {spellID = 184367, talentID = 112277},
		ImprovedRagingBlow = {spellID = 383854, talentID = 112259},
		SingleMindedFury = {spellID = 81099, talentID = 112269},
		ColdSteelHotBlood = {spellID = 383959, talentID = 112271},
		ViciousContempt = {spellID = 383885, talentID = 112273},
		Frenzy = {spellID = 335077, talentID = 112275},
		HackandSlash = {spellID = 383877, talentID = 112276},
		SlaughteringStrikes = {spellID = 388004, talentID = 112280},
		AshenJuggernaut = {spellID = 392536, talentID = 112278},
		ImprovedWhirlwind = {spellID = 12950, talentID = 112298},
		Bloodborne = {spellID = 385703, talentID = 112270},
		Bloodcraze = {spellID = 393950, talentID = 112274},
		Recklessness = {spellID = 1719, talentID = 112281},
		Massacre = {spellID = 206315, talentID = 112279},
			MassacreExecute = {spellID = 280735, talentID = 112279},
		WrathandFury = {spellID = 392936, talentID = 112255},
		MeatCleaver = {spellID = 280392, talentID = 112260},
		DeftExperience = {spellID = 383295, talentID = 112292},
		SwiftStrikes = {spellID = 383459, talentID = 112286},
		CriticalThinking = {spellID = 383297, talentID = 112296},
		Onslaught = {spellID = 315720, talentID = 112295},
		Ravager = {spellID = 228920, talentID = 112256},
		Bladestorm = {spellID = 227847, talentID = 119139},
		AngerManagement = {spellID = 152278, talentID = 112285},
		RecklessAbandon = {spellID = 396749, talentID = 112284},
			Bloodbath = {spellID = 335096, talentID = 112284},
			CrushingBlow = {spellID = 335097, talentID = 112284},
		OdynsFury = {spellID = 385059, talentID = 112289},
		Tenderize = {spellID = 388933, talentID = 112294},
		StormofSteel = {spellID = 382953, talentID = 112258},
		Unhinged = {spellID = 386628, talentID = 112257},
		UnbridledFerocity = {spellID = 389603, talentID = 112283},
		DepthsofInsanity = {spellID = 383922, talentID = 112282},
		DancingBlades = {spellID = 391683, talentID = 112288},
		TitanicRage = {spellID = 394329, talentID = 112287},
	--Hero
	--Mountain Thane
		LightningStrikes = {spellID = 434969, talentID = 117400},
		CrashingThunder = {spellID = 436707, talentID = 117413},
		GroundCurrent = {spellID = 436148, talentID = 117397},
		StrengthoftheMountain = {spellID = 437068, talentID = 117405},
		ThunderBlastPassive = {spellID = 435607, talentID = 117382},
			ThunderBlast = {spellID = 435222, talentID = 117382},
		StormBolts = {spellID = 436162, talentID = 117414},
		StormShield = {spellID = 438597, talentID = 118835},
		KeepYourFeetontheGround = {spellID = 438590, talentID = 117395},
		SteadfastasthePeaks = {spellID = 434970, talentID = 118836},
		FlashingSkies = {spellID = 437079, talentID = 117394},
		SnapInduction = {spellID = 456270, talentID = 118833},
		GatheringClouds = {spellID = 436201, talentID = 117389},
		ThorimsMight = {spellID = 436152, talentID = 118834},
		BurstofPower = {spellID = 437118, talentID = 117404},
		AvataroftheStorm = {spellID = 437134, talentID = 117402},
	--Slayer
		SlayersDominance = {spellID = 444767, talentID = 117411},
		ImminentDemise = {spellID = 444769, talentID = 117385},
		OverwhelmingBlades = {spellID = 444772, talentID = 117407},
		RelentlessPursuit = {spellID = 444776, talentID = 117392},
		ViciousAgility = {spellID = 444777, talentID = 123408},
		DeathDrive = {spellID = 444770, talentID = 117410},
		CullingCyclone = {spellID = 444778, talentID = 117383},
		BrutalFinish = {spellID = 446085, talentID = 123409},
		FierceFollowthrough = {spellID = 444773, talentID = 117384},
		Opportunist = {spellID = 444774, talentID = 123770},
		ShowNoMercy = {spellID = 444771, talentID = 117381},
		ReaptheStorm = {spellID = 444775, talentID = 117406},
		SlayersMalice = {spellID = 444779, talentID = 117398},
		UnrelentingOnslaught = {spellID = 444780, talentID = 117417},
			Bladestorm_UO = {spellID = 446035, talentID = 117417},
	}
	ids.Fury_Form = {

	}
	ids.Fury_Buff = {
		AshenJuggernaut = 392537,
		Avatar = 107574,
		BattleShout = 6673,
		ColossalMight = 440989,
		Enrage = 184362,
		FuriousSlash = 202539,
		IgnorePain = 190456,
		Opportunist = 456120,
		RecklessAbandon = 396752,
		Recklessness = 1719,
		SuddenDeath = 280776,
		ThunderBlast = 435615,
		Victorious = 32216,
		Whirlwind = 85739,
	}
	ids.Fury_Debuff = {
		MarkedforExecution = 445584,
		Siegebreaker = 280773,
	}
	ids.Fury_PetAbility = {

	}

--Protection
	ids.Prot_Ability = {
	--Warrior Baseline
		BattleShout = {spellID = 6673},
		BerserkerRage = {spellID = 18499},
		Charge = {spellID = 100},
		Execute = {spellID = 163201},
		Hamstring = {spellID = 1715},
		HeroicThrow = {spellID = 57755},
		Pummel = {spellID = 6552},
		ShieldBlock = {spellID = 2565},
		ShieldSlam = {spellID = 23922},
		Slam = {spellID = 1464},
		Taunt = {spellID = 355},
		VictoryRush = {spellID = 34428},
		Whirlwind = {spellID = 1680},
	--Protection Baseline
		Devastate = {spellID = 20243},
		--Passive
		MasteryCriticalBlock = {spellID = 76857},
		Riposte = {spellID = 161798},
		Vanguard = {spellID = 71},
	--Warrior
		BattleStance = {spellID = 386164, talentID = 112112},
		DefensiveStance = {spellID = 386208, talentID = 112187},
		FastFootwork = {spellID = 382260, talentID = 112206},
		WarMachine = {spellID = 316733, talentID = 112207},
		LeechingStrikes = {spellID = 382258, talentID = 112238},
		Intervene = {spellID = 3411, talentID = 112186},
		ImpendingVictory = {spellID = 202168, talentID = 112183},
		HeroicLeap = {spellID = 6544, talentID = 112208},
		StormBolt = {spellID = 107570, talentID = 112198},
		IntimidatingShout = {spellID = 5246, talentID = 112252},
		SecondWind = {spellID = 29838, talentID = 112190},
		FrothingBerserker = {spellID = 392790, talentID = 112237},
		BoundingStride = {spellID = 202163, talentID = 112219},
		PainandGain = {spellID = 382549, talentID = 112217},
		ThunderClap = {spellID = 6343, talentID = 112205},
		CacophonousRoar = {spellID = 382954, talentID = 112251},
		Menace = {spellID = 275338, talentID = 112250},
		SpellReflection = {spellID = 23920, talentID = 112253},
		RallyingCry = {spellID = 97462, talentID = 112188},
		Shockwave = {spellID = 46968, talentID = 112242},
		CracklingThunder = {spellID = 203201, talentID = 118853},
		HonedReflexes = {spellID = 391271, talentID = 118850},
		CrushingForce = {spellID = 390642, talentID = 112236},
		BitterImmunity = {spellID = 383762, talentID = 112220},
		OverwhelmingRage = {spellID = 382767, talentID = 112245},
		RumblingEarth = {spellID = 275339, talentID = 112241},
		ReinforcedPlates = {spellID = 382939, talentID = 112235},
		WreckingThrow = {spellID = 384110, talentID = 112215},
		ShatteringThrow = {spellID = 64382, talentID = 112214},
		BarbaricTraining = {spellID = 390675, talentID = 118847},
		Sidearm = {spellID = 384404, talentID = 118846},
		DoubleTime = {spellID = 103827, talentID = 112249},
		SeismicReverberation = {spellID = 382956, talentID = 112218},
		ConcussiveBlows = {spellID = 383115, talentID = 118843},
		BerserkerShout = {spellID = 384100, talentID = 112211},
		PiercingHowl = {spellID = 12323, talentID = 112210},
		CruelStrikes = {spellID = 392777, talentID = 112248},
		WildStrikes = {spellID = 382946, talentID = 112224},
		OneHandedWeaponSpecialization = {spellID = 382895, talentID = 112181},
		EnduranceTraining = {spellID = 382940, talentID = 112200},
		ArmoredtotheTeeth = {spellID = 394855, talentID = 112109},
		ThunderousRoar = {spellID = 384318, talentID = 112223},
		Avatar = {spellID = 401150, talentID = 114769},
		ChampionsSpear = {spellID = 376079, talentID = 112247},
		Uproar = {spellID = 391572, talentID = 112221},
		ThunderousWords = {spellID = 384969, talentID = 112222},
		ImmovableObject = {spellID = 394307, talentID = 112231},
		UnstoppableForce = {spellID = 275336, talentID = 112230},
		PiercingChallenge = {spellID = 382948, talentID = 112246},
		ChampionsMight = {spellID = 386284, talentID = 112180},
	--Protection
		IgnorePain = {spellID = 190456, talentID = 112149},
		Revenge = {spellID = 6572, talentID = 112152},
		DemoralizingShout = {spellID = 1160, talentID = 112159},
		Devastator = {spellID = 236279, talentID = 112153},
		LastStand = {spellID = 12975, talentID = 112151},
		FightThroughtheFlames = {spellID = 452494, talentID = 112160},
		BestServedCold = {spellID = 202560, talentID = 112158},
		Strategist = {spellID = 384041, talentID = 112157},
		BraceForImpact = {spellID = 386030, talentID = 112150},
		UnnervingFocus = {spellID = 384042, talentID = 112327},
		ChallengingShout = {spellID = 1161, talentID = 112163},
		Instigate = {spellID = 394311, talentID = 112155},
		Rend = {spellID = 394062, talentID = 112156},
		Bloodsurge = {spellID = 384361, talentID = 112154},
		FueledbyViolence = {spellID = 383103, talentID = 112326},
		BrutalVitality = {spellID = 384036, talentID = 112325},
		DisruptingShout = {spellID = 386071, talentID = 112161},
		ShowofForce = {spellID = 385843, talentID = 112177},
		SuddenDeath = {spellID = 29725, talentID = 112111},
		Thunderlord = {spellID = 385840, talentID = 112162},
		ShieldWall = {spellID = 871, talentID = 112167},
		Bolster = {spellID = 280001, talentID = 112115},
		ToughasNails = {spellID = 385888, talentID = 112324},
		SpellBlock = {spellID = 392966, talentID = 112110},
		Bloodborne = {spellID = 385704, talentID = 112321},
		HeavyRepercussions = {spellID = 203177, talentID = 112176},
		IntotheFray = {spellID = 202603, talentID = 112175},
		EnduringDefenses = {spellID = 386027, talentID = 112169},
		Massacre = {spellID = 281001, talentID = 112168},
			MassacreExecute = {spellID = 281000, talentID = 112168},
		AngerManagement = {spellID = 152278, talentID = 112166},
		DefendersAegis = {spellID = 397103, talentID = 112165},
		ImpenetrableWall = {spellID = 384072, talentID = 112164},
		Punish = {spellID = 275334, talentID = 112323},
		Juggernaut = {spellID = 393967, talentID = 112322},
		FocusedVigor = {spellID = 384067, talentID = 112174},
		ShieldSpecialization = {spellID = 386011, talentID = 112171},
		EnduringAlacrity = {spellID = 384063, talentID = 112305},
		ShieldCharge = {spellID = 385952, talentID = 112173},
		BoomingVoice = {spellID = 202743, talentID = 112170},
		Indomitable = {spellID = 202095, talentID = 112306},
		ViolentOutburst = {spellID = 386477, talentID = 112116},
		Ravager = {spellID = 228920, talentID = 112304},
		BatteringRam = {spellID = 394312, talentID = 112113},
		ChampionsBulwark = {spellID = 386328, talentID = 112172},
		BattleScarredVeteran = {spellID = 386394, talentID = 112307},
		DanceofDeath = {spellID = 390713, talentID = 112302},
		StormofSteel = {spellID = 382953, talentID = 112306},
	--Hero
	--Colossus
		Demolish = {spellID = 436358, talentID = 117415},
		MartialExpert = {spellID = 429638, talentID = 117409},
		ColossalMight = {spellID = 429634, talentID = 117416},
		Boneshaker = {spellID = 429639, talentID = 117386},
		Earthquaker = {spellID = 440992, talentID = 119858},
		OneAgainstMany = {spellID = 429637, talentID = 117396},
		ArterialBleed = {spellID = 440995, talentID = 119856},
		TideofBattle = {spellID = 429641, talentID = 117408},
		NoStrangertoPain = {spellID = 429644, talentID = 117412},
		VeteranVitality = {spellID = 440993, talentID = 119857},
		PracticedStrikes = {spellID = 429647, talentID = 117393},
		PreciseMight = {spellID = 431548, talentID = 117391},
		MountainofMuscleandScars = {spellID = 429642, talentID = 117403},
		DominanceoftheColossus = {spellID = 429636, talentID = 117390},
	--Mountain Thane
		LightningStrikes = {spellID = 434969, talentID = 117400},
		CrashingThunder = {spellID = 436707, talentID = 117413},
		GroundCurrent = {spellID = 436148, talentID = 117397},
		StrengthoftheMountain = {spellID = 437068, talentID = 117405},
		ThunderBlastPassive = {spellID = 435607, talentID = 117382},
			ThunderBlast = {spellID = 435222, talentID = 117382},
		StormBolts = {spellID = 436162, talentID = 117414},
		StormShield = {spellID = 438597, talentID = 118835},
		KeepYourFeetontheGround = {spellID = 438590, talentID = 117395},
		SteadfastasthePeaks = {spellID = 434970, talentID = 118836},
		FlashingSkies = {spellID = 437079, talentID = 117394},
		SnapInduction = {spellID = 456270, talentID = 118833},
		GatheringClouds = {spellID = 436201, talentID = 117389},
		ThorimsMight = {spellID = 436152, talentID = 118834},
		BurstofPower = {spellID = 437118, talentID = 117404},
		AvataroftheStorm = {spellID = 437134, talentID = 117402},
	}
	ids.Prot_Form = {

	}
	ids.Prot_Buff = {
		Avatar = 107574,
		BattleShout = 6673,
		IgnorePain = 190456,
		Revenge = 5302,
		ShieldBlock = 132404,
		ThunderBlast = 435615,
		Victorious = 32216,
		ViolentOutburst = 386478,
 	}
	ids.Prot_Debuff = {
		DeepWounds = 115767,
		DemoralizingShout = 1160,
	}
	ids.Prot_PetAbility = {

	}