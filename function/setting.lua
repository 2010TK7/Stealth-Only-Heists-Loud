if Network:is_client() then
	return
end

_G.SOHL = _G.SOHL or {}

SOHL.Message2OtherPlayers = "This lobby is running 'Stealth Only Heists Loud Mod'"
SOHL.Message2WarnYou = "You're activating Stealth Only Heists Loud MOD. \n You should only play with your friends."

SOHL.Unit_Remove_When_Loud = {
	MS = {
		{
			key = "b025e83ed6d542b4",
			position = {
				Vector3(3041, 749.998, -700),
				Vector3(1041, 749.999, -700),
				Vector3(-158, 749.998, -700),
				Vector3(-2558, 750, -700),
				Vector3(-2500, 4400, -700),
				Vector3(-900, 4400, -700),
				Vector3(2200, 4400, -700),
				Vector3(2600, 4400, -700),
				Vector3(2641, 749.998, -700),
				Vector3(300, 4400, -700)
			}
		},
		{
			key = "23390d90d6ed7e76",
			position = {
				Vector3(0, 0, 0)
			}
		}
	}
}

SOHL.Time2FirstSpawn = {
	normal = 60,
	hard = 60,
	overkill = 40,
	overkill_145 = 40,
	easy_wish = 40,
	overkill_290 = 30,
	sm_wish = 30
}
SOHL.Time2RepeatSpawn = {
	normal = 20,
	hard = 20,
	overkill = 20,
	overkill_145 = 20,
	easy_wish = 20,
	overkill_290 = 20,
	sm_wish = 20
}
SOHL.Time2OpenVault = {
	normal = 120,
	hard = 160,
	overkill = 200,
	overkill_145 = 240,
	easy_wish = 240,
	overkill_290 = 300,
	sm_wish = 300
}
SOHL._Spawning = {
	normal = 2,
	hard = 2,
	overkill = 2,
	overkill_145 = 2,
	easy_wish = 2,
	overkill_290 = 2,
	sm_wish = 2
}
SOHL._Spawning_Total = {
	normal = 50,
	hard = 60,
	overkill = 60,
	overkill_145 = 70,
	easy_wish = 90,
	overkill_290 = 90,
	sm_wish = 90
}
SOHL._Spawning_Other_Total = {
	sniper = {
		normal = 5,
		hard = 5,
		overkill = 5,
		overkill_145 = 5,
		easy_wish = 5,
		overkill_290 = 5,
		sm_wish = 5
	},
	taser = {
		normal = 4,
		hard = 4,
		overkill = 4,
		overkill_145 = 6,
		easy_wish = 6,
		overkill_290 = 6,
		sm_wish = 6
	},
	shield = {
		easy = 10,
		normal = 20,
		hard = 20,
		overkill = 20,
		overkill_145 = 20,
		easy_wish = 20,
		overkill_290 = 20,
		sm_wish = 20
	},
	spooc = {
		normal = 2,
		hard = 2,
		overkill = 3,
		overkill_145 = 4,
		easy_wish = 4,
		overkill_290 = 5,
		sm_wish = 5
	},
	tank = {
		normal = 3,
		hard = 4,
		overkill = 5,
		overkill_145 = 6,
		easy_wish = 6,
		overkill_290 = 8,
		sm_wish = 8
	},
	medic = {
		normal = 3,
		hard = 4,
		overkill = 5,
		overkill_145 = 6,
		easy_wish = 6,
		overkill_290 = 8,
		sm_wish = 8
	}
}

SOHL.Difficulty = Global.game_settings and Global.game_settings.difficulty or "normal"

local _D = SOHL.Difficulty

SOHL.Time4Use = {
	FirstSpawn = SOHL.Time2FirstSpawn[_D],
	RepeatSpawn = SOHL.Time2RepeatSpawn[_D],
	OpenVault = SOHL.Time2OpenVault[_D]
}

--Spawn_Settings
	local _default_enemy = {
		normal = {
			"units/payday2/characters/ene_swat_1/ene_swat_1",
			"units/payday2/characters/ene_swat_2/ene_swat_2",
			"units/payday2/characters/ene_swat_heavy_1/ene_swat_heavy_1",
			"units/payday2/characters/ene_swat_heavy_r870/ene_swat_heavy_r870"
		},
		overkill = {
			"units/payday2/characters/ene_fbi_swat_1/ene_fbi_swat_1",
			"units/payday2/characters/ene_fbi_swat_2/ene_fbi_swat_2",
			"units/payday2/characters/ene_fbi_heavy_1/ene_fbi_heavy_1",
			"units/payday2/characters/ene_fbi_heavy_r870/ene_fbi_heavy_r870"
		},
		easy_wish = {
			"units/payday2/characters/ene_city_swat_1/ene_city_swat_1",
			"units/payday2/characters/ene_city_swat_r870/ene_city_swat_r870",
			"units/payday2/characters/ene_city_heavy_g36/ene_city_heavy_g36",
			"units/payday2/characters/ene_city_heavy_r870/ene_city_heavy_r870"
		},
		sm_wish = {
			"units/pd2_dlc_gitgud/characters/ene_zeal_swat/ene_zeal_swat",
			"units/pd2_dlc_gitgud/characters/ene_zeal_swat_heavy/ene_zeal_swat_heavy"
		},
		amount = 7
	}
	_default_enemy.hard = _default_enemy.normal
	_default_enemy.overkill_145 = _default_enemy.overkill
	_default_enemy.overkill_290 = _default_enemy.easy_wish

	SOHL.Spawn_Settings = {}
	local Spawn_Settings = {}
	local Spawn_Settings_List = {}

	Spawn_Settings.SR = {}
	Spawn_Settings_List.SR = {}
	Spawn_Settings.SR.front_right_side_group = {
		group_id = 1,
		position = {Vector3(3872, 2750, 978), Vector3(3872, 2850, 978), Vector3(3872, 2950, 978), Vector3(3872, 3050, 978), Vector3(3872, 3150, 978)},
		rotation = {Rotation(0, 0, 1)},
		enemy = _default_enemy
	}
	table.insert(Spawn_Settings_List.SR, "front_right_side_group")

	Spawn_Settings.SR.warehouse_top = deep_clone(Spawn_Settings.SR.front_right_side_group)
	Spawn_Settings.SR.warehouse_top.group_id = 2
	Spawn_Settings.SR.warehouse_top.position = {
		Vector3(-2200, -4950, 1775), Vector3(-2100, -4950, 1775), Vector3(-2000, -4950, 1775), Vector3(-1900, -4950, 1775), Vector3(-1800, -4950, 1775)
	}
	table.insert(Spawn_Settings_List.SR, "warehouse_top")
	
	Spawn_Settings.SR.front_left_side_group = deep_clone(Spawn_Settings.SR.front_right_side_group)
	Spawn_Settings.SR.front_left_side_group.group_id = 3
	Spawn_Settings.SR.front_left_side_group.position = {Vector3(2150, -3900, 975), Vector3(2000, -3900, 975), Vector3(1850, -3900, 975), Vector3(1700, -3900, 975)}
	table.insert(Spawn_Settings_List.SR, "front_left_side_group")
	
	Spawn_Settings.SR.warehouse_back = deep_clone(Spawn_Settings.SR.front_right_side_group)
	Spawn_Settings.SR.warehouse_back.group_id = 4
	Spawn_Settings.SR.warehouse_back.position = {
		Vector3(-2844, -5328, 1377.29), Vector3(-2850, -5500, 1377.29), Vector3(-2850, -5414, 1377.29), Vector3(-2850, -5550, 1377.29)
	}
	table.insert(Spawn_Settings_List.SR, "warehouse_back")
	
	Spawn_Settings.SR.front_front_group = deep_clone(Spawn_Settings.SR.front_right_side_group)
	Spawn_Settings.SR.front_front_group.group_id = 5
	Spawn_Settings.SR.front_front_group.position = {
		Vector3(4692, -3000, 975.941), Vector3(4692, -2900, 975.941), Vector3(4692, -2800, 975.941), Vector3(4692, -2700, 975.941), Vector3(4692, -2600, 975.941)
	}
	table.insert(Spawn_Settings_List.SR, "front_front_group")
	
	Spawn_Settings.SR.warehouse_roof_001 = deep_clone(Spawn_Settings.SR.front_right_side_group)
	Spawn_Settings.SR.warehouse_roof_001.group_id = 6
	Spawn_Settings.SR.warehouse_roof_001.position = {Vector3(-2900, -1800, 1776), Vector3(-2825, -1800, 1776), Vector3(-2750, -1800, 1776), Vector3(-2675, -1800, 1776)}
	table.insert(Spawn_Settings_List.SR, "warehouse_roof_001")
	
	Spawn_Settings.SR.back_yard = deep_clone(Spawn_Settings.SR.front_right_side_group)
	Spawn_Settings.SR.back_yard.group_id = 7
	Spawn_Settings.SR.back_yard.position = {Vector3(-4900, -1800, 975), Vector3(-4900, -1650, 975), Vector3(-4900, -1500, 975), Vector3(-4900, -1350, 975)}
	table.insert(Spawn_Settings_List.SR, "back_yard")
	
	Spawn_Settings.SR.warehouse_roof_002 = deep_clone(Spawn_Settings.SR.front_right_side_group)
	Spawn_Settings.SR.warehouse_roof_002.group_id = 8
	Spawn_Settings.SR.warehouse_roof_002.position = {Vector3(-725, -2075, 1776), Vector3(-625, -2075, 1776), Vector3(-550, -2075, 1776), Vector3(-475, -2075, 1776)}
	table.insert(Spawn_Settings_List.SR, "warehouse_roof_002")
	
	Spawn_Settings.SR.back_left_escape_001 = deep_clone(Spawn_Settings.SR.front_right_side_group)
	Spawn_Settings.SR.back_left_escape_001.group_id = 14
	Spawn_Settings.SR.back_left_escape_001.position = {Vector3(2018, -6732, 577), Vector3(2018, -6496, 577), Vector3(1755, -6496, 578)}
	table.insert(Spawn_Settings_List.SR, "back_left_escape_001")
	
	Spawn_Settings.SR.back_left_escape_002 = deep_clone(Spawn_Settings.SR.front_right_side_group)
	Spawn_Settings.SR.back_left_escape_002.group_id = 15
	Spawn_Settings.SR.back_left_escape_002.position = {Vector3(-3983, -5732, 577), Vector3(-3679, -5975, 577), Vector3(-3436, -6099, 577)}
	table.insert(Spawn_Settings_List.SR, "back_left_escape_002")
	
	Spawn_Settings.SR.back_left_escape_003 = deep_clone(Spawn_Settings.SR.front_right_side_group)
	Spawn_Settings.SR.back_left_escape_003.group_id = 16
	Spawn_Settings.SR.back_left_escape_003.position = {Vector3(-4752, -2868, 977), Vector3(-4199, -4485, 577), Vector3(-5131, -5299, 577)}
	table.insert(Spawn_Settings_List.SR, "back_left_escape_003")
	
	local _other_position = {}
	_other_position.SR = {
		Vector3(6080, 3402, 959), Vector3(-4940, 2365, 977), Vector3(-4941, -1474, 977),
		Vector3(-2756, -7415, 586.768), Vector3(-3693, -1303, 1391), Vector3(1453, 2365, 977),
		Vector3(-3745, -3499, 1791), Vector3(-1057, -4406, 1791), Vector3(-5328, -5730, 592)
	}

	Spawn_Settings.SR.other_001 = deep_clone(Spawn_Settings.SR.front_right_side_group)
	Spawn_Settings.SR.other_001.group_id = 9
	Spawn_Settings.SR.other_001.position = _other_position.SR
	Spawn_Settings.SR.other_001.POSNOADD = true
	table.insert(Spawn_Settings_List.SR, "other_001")
	
	Spawn_Settings.SR.other_002 = deep_clone(Spawn_Settings.SR.front_right_side_group)
	Spawn_Settings.SR.other_002.group_id = 10
	Spawn_Settings.SR.other_002.position = _other_position.SR
	Spawn_Settings.SR.other_002.POSNOADD = true
	table.insert(Spawn_Settings_List.SR, "other_002")
	
	Spawn_Settings.SR.other_003 = deep_clone(Spawn_Settings.SR.front_right_side_group)
	Spawn_Settings.SR.other_003.group_id = 11
	Spawn_Settings.SR.other_003.position = _other_position.SR
	Spawn_Settings.SR.other_003.POSNOADD = true
	table.insert(Spawn_Settings_List.SR, "other_003")
	
	Spawn_Settings.SR.other_004 = deep_clone(Spawn_Settings.SR.front_right_side_group)
	Spawn_Settings.SR.other_004.group_id = 12
	Spawn_Settings.SR.other_004.position = _other_position.SR
	Spawn_Settings.SR.other_004.POSNOADD = true
	table.insert(Spawn_Settings_List.SR, "other_004")
	
	Spawn_Settings.SR.other_005 = deep_clone(Spawn_Settings.SR.front_right_side_group)
	Spawn_Settings.SR.other_005.group_id = 13
	Spawn_Settings.SR.other_005.position = _other_position.SR
	Spawn_Settings.SR.other_005.POSNOADD = true
	table.insert(Spawn_Settings_List.SR, "other_005")

	Spawn_Settings.MS = {}
	Spawn_Settings_List.MS = {}
	Spawn_Settings.MS.palce_1 = {
		group_id = 1,
		position = {Vector3(3202.7, 586.491, -700.008), Vector3(3098.97, 515.575, -700.007), Vector3(3105.69, 664.135, -700.009)},
		rotation = {Rotation(0, 0, 1)},
		enemy = _default_enemy
	}
	table.insert(Spawn_Settings_List.MS, "palce_1")

	Spawn_Settings.MS.palce_2 = deep_clone(Spawn_Settings.MS.palce_1)
	Spawn_Settings.MS.palce_2.group_id = 2
	Spawn_Settings.MS.palce_2.position = {Vector3(-4113.92, 442.69, 0), Vector3(-3981.77, 486.164, 0), Vector3(-3805.37, 508.707, 0)}
	table.insert(Spawn_Settings_List.MS, "palce_2")
	
	Spawn_Settings.MS.palce_3 = deep_clone(Spawn_Settings.MS.palce_1)
	Spawn_Settings.MS.palce_3.group_id = 3
	Spawn_Settings.MS.palce_3.position = {Vector3(-311.881, -575.421, 0), Vector3(-442.423, -723.203, 0), Vector3(-589.216, -862.885, 5)}
	table.insert(Spawn_Settings_List.MS, "palce_3")
	
	Spawn_Settings.MS.palce_4 = deep_clone(Spawn_Settings.MS.palce_1)
	Spawn_Settings.MS.palce_4.group_id = 4
	Spawn_Settings.MS.palce_4.position = {Vector3(1991.58, 1224.7, -261.564), Vector3(1109.55, 1219.53, -226.491), Vector3(517.633, 1199.83, -231.08)}
	table.insert(Spawn_Settings_List.MS, "palce_4")
	
	Spawn_Settings.MS.palce_5 = deep_clone(Spawn_Settings.MS.palce_1)
	Spawn_Settings.MS.palce_5.group_id = 5
	Spawn_Settings.MS.palce_5.position = {Vector3(4712.76, 1405.89, -700.002), Vector3(4462.91, 1753.63, -700.005), Vector3(4575.32, 1906.78, -700.004)}
	table.insert(Spawn_Settings_List.MS, "palce_5")
	
	Spawn_Settings.MS.palce_6 = deep_clone(Spawn_Settings.MS.palce_1)
	Spawn_Settings.MS.palce_6.group_id = 6
	Spawn_Settings.MS.palce_6.position = {Vector3(4584.74, 3485.85, -700.005), Vector3(4724.86, 3245.02, -700.003), Vector3(4630.55, 2880.39, -700.004)}
	table.insert(Spawn_Settings_List.MS, "palce_6")
	
	Spawn_Settings.MS.palce_7 = deep_clone(Spawn_Settings.MS.palce_1)
	Spawn_Settings.MS.palce_7.group_id = 7
	Spawn_Settings.MS.palce_7.position = {Vector3(-2379.85, 4527.01, -700), Vector3(-2203.35, 4706.74, -700), Vector3(-2041.36, 4785.12, -700)}
	table.insert(Spawn_Settings_List.MS, "palce_7")
	
	Spawn_Settings.MS.palce_8 = deep_clone(Spawn_Settings.MS.palce_1)
	Spawn_Settings.MS.palce_8.group_id = 8
	Spawn_Settings.MS.palce_8.position = {Vector3(3554.01, 4781.07, -700),  Vector3(3646.41, 4672.44, -700.001), Vector3(3631.84, 4518.62, -700.003)}
	table.insert(Spawn_Settings_List.MS, "palce_8")
	
	Spawn_Settings.MS.palce_9 = deep_clone(Spawn_Settings.MS.palce_1)
	Spawn_Settings.MS.palce_9.group_id = 9
	Spawn_Settings.MS.palce_9.position = {Vector3(965.158, 4853.61, -1100.01), Vector3(952.189, 4922.49, -1100.01), Vector3(1026.23, 5001.7, -1100.01)}
	table.insert(Spawn_Settings_List.MS, "palce_9")

	Spawn_Settings.MS.palce_10 = deep_clone(Spawn_Settings.MS.palce_1)
	Spawn_Settings.MS.palce_10.group_id = 10
	Spawn_Settings.MS.palce_10.position = {Vector3(816.521, 2706.69, -1200), Vector3(886.387, 2548.19, -1200), Vector3(734.469, 2419.99, -1200)}
	table.insert(Spawn_Settings_List.MS, "palce_10")
	
	Spawn_Settings.MS.palce_11 = deep_clone(Spawn_Settings.MS.palce_1)
	Spawn_Settings.MS.palce_11.group_id = 11
	Spawn_Settings.MS.palce_11.position = {Vector3(163.087, 648.535, -1207.99), Vector3(-33.7929, 496.34, -1207.99), Vector3(-278.425, 546.047, -1200)}
	table.insert(Spawn_Settings_List.MS, "palce_11")
	
	Spawn_Settings.MS.palce_12 = deep_clone(Spawn_Settings.MS.palce_1)
	Spawn_Settings.MS.palce_12.group_id = 12
	Spawn_Settings.MS.palce_12.position = {Vector3(-2120.24, -510.893, -800), Vector3(-2614.47, -681.511, -1000), Vector3(-2659.98, -528.267, -600)}
	table.insert(Spawn_Settings_List.MS, "palce_12")
	
	Spawn_Settings.MS.palce_13 = deep_clone(Spawn_Settings.MS.palce_1)
	Spawn_Settings.MS.palce_13.group_id = 13
	Spawn_Settings.MS.palce_13.position = {Vector3(-2756.3, -13.3883, -580), Vector3(-2555.04, -23.5455, -580), Vector3(-2301.34, -29.0375, -580)}
	table.insert(Spawn_Settings_List.MS, "palce_13")
	
	_other_position.MS = {Vector3(-4177, 401, 1), Vector3(-2864, 417, -673), Vector3(-4772, 1951, -698), Vector3(-4697, 4597, -698), Vector3(1625.06, 2986.7, -381)}

	Spawn_Settings.MS.other_001 = deep_clone(Spawn_Settings.MS.palce_1)
	Spawn_Settings.MS.other_001.group_id = 14
	Spawn_Settings.MS.other_001.position = _other_position.MS
	Spawn_Settings.MS.other_001.POSNOADD = true
	table.insert(Spawn_Settings_List.MS, "other_001")
	
	Spawn_Settings.MS.other_002 = deep_clone(Spawn_Settings.MS.palce_1)
	Spawn_Settings.MS.other_002.group_id = 15
	Spawn_Settings.MS.other_002.position = _other_position.MS
	Spawn_Settings.MS.other_002.POSNOADD = true
	table.insert(Spawn_Settings_List.MS, "other_002")
	
	Spawn_Settings.MS.other_003 = deep_clone(Spawn_Settings.MS.palce_1)
	Spawn_Settings.MS.other_003.group_id = 16
	Spawn_Settings.MS.other_003.position = _other_position.MS
	Spawn_Settings.MS.other_003.POSNOADD = true
	table.insert(Spawn_Settings_List.MS, "other_003")

	Spawn_Settings.CS = {}
	Spawn_Settings_List.CS = {}
	_other_position.CS = {
		Vector3(-4475, 4903, -175), Vector3(-4475, -5298, -175), Vector3(2521, -1708, 574),
		Vector3(2846, -1300, -225), Vector3(2450, -1136, 575), Vector3(2275, 1400, -225),
		Vector3(197, -3870, -178), Vector3(-616, 2000, -175)
	}
	Spawn_Settings.CS.TK7 = {
		group_id = 1,
		position = _other_position.CS,
		rotation = {Rotation(0, 0, 1)},
		enemy = _default_enemy
	}
	table.insert(Spawn_Settings_List.CS, "TK7")

	Spawn_Settings.TY = {}
	Spawn_Settings_List.TY = {}
	_other_position.TY = {
		Vector3(-1118, 1550, -798), Vector3(0, 700, -1013), Vector3(6, 2361, 0),
		Vector3(677, -1233, 0), Vector3(-2, -2535, 2.6), Vector3(4, 1483, 400),
		Vector3(-505, -5620, -729), Vector3(505, -5620, -729), Vector3(0, 4975, -400)
	}
	Spawn_Settings.TY.TK7 = deep_clone(Spawn_Settings.CS.TK7)
	Spawn_Settings.TY.TK7.position = _other_position.TY
	table.insert(Spawn_Settings_List.TY, "TK7")
	
	SOHL.Spawn_Settings = deep_clone(Spawn_Settings)
	SOHL.Spawn_Settings_List = Spawn_Settings_List
	
	Spawn_Settings = {}
	Spawn_Settings_List = {}
	_default_enemy = {}

--Spawning_Other
	SOHL.Spawning_Other = {
		sniper = {
			SR = {
				Vector3(-1650, -5375, 1775),
				Vector3(-1650, -5275, 1775),
				Vector3(-23175, 7200, 1100),
				Vector3(-6700, -300, 2196),
				Vector3(4250, -5775, 2001),
				Vector3(-2950, 5825, 1800),
				Vector3(-13550, 12200, 1125),
				Vector3(7222, 1491, 1803),
				Vector3(2550, 3725, 2100),
				Vector3(475, 3825, 2100)
			},
			MS = {
				Vector3(-3108, 3658, 608),
				Vector3(-3125, 3430, 608),
				Vector3(-3149, 3087, 607),
				Vector3(-3177, 2682, 606),
				Vector3(-3208, 2248, 605),
				Vector3(-3230, 1937, 604)
			},
			CS = {},
			TY = {}
		},
		taser = {amount = 1, name = {Idstring("units/payday2/characters/ene_tazer_1/ene_tazer_1")}},
		shield = {amount = 3, name = {Idstring("units/payday2/characters/ene_shield_2/ene_shield_2")}},
		spooc = {amount = 1, name = {Idstring("units/payday2/characters/ene_spook_1/ene_spook_1")}},
		tank = {amount = 1, name = {Idstring("units/payday2/characters/ene_bulldozer_1/ene_bulldozer_1")}},
		medic = {amount = 2, name = {
			Idstring("units/payday2/characters/ene_medic_r870/ene_medic_r870"),
			Idstring("units/payday2/characters/ene_medic_m4/ene_medic_m4")
		}},
		
		pos_default = {}
	}
	if _D == "sm_wish" then
		SOHL.Spawning_Other.taser.name = {Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_tazer/ene_zeal_tazer")}
		SOHL.Spawning_Other.shield.name = {Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat_shield/ene_zeal_swat_shield")}
		SOHL.Spawning_Other.spooc.name = {Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_cloaker/ene_zeal_cloaker")}
		SOHL.Spawning_Other.tank.name = {
			Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer_2/ene_zeal_bulldozer_2"),
			Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer_3/ene_zeal_bulldozer_3"),
			Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer/ene_zeal_bulldozer"),
			Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_minigun/ene_bulldozer_minigun"),
			Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_medic/ene_bulldozer_medic")
		}
	else
		if _D == "easy_wish" or _D == "overkill_290" then
			SOHL.Spawning_Other.shield.name = {Idstring("units/payday2/characters/ene_city_shield/ene_city_shield")}
		elseif _D == "overkill" or _D == "overkill_145" then
			SOHL.Spawning_Other.shield.name = {Idstring("units/payday2/characters/ene_shield_1/ene_shield_1")}
		end
		if _D == "overkill_145" or _D == "easy_wish" or _D == "overkill_290" then
			table.insert(SOHL.Spawning_Other.tank.name, Idstring("units/payday2/characters/ene_bulldozer_2/ene_bulldozer_2"))
			if _D == "overkill_290" then
				table.insert(SOHL.Spawning_Other.tank.name,
					Idstring("units/payday2/characters/ene_bulldozer_3/ene_bulldozer_3")
				)
				table.insert(SOHL.Spawning_Other.tank.name,
					Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_minigun_classic/ene_bulldozer_minigun_classic")
				)
			end
		end
	end

	SOHL.Spawning_Other.pos_default.SR = {}
	SOHL.Spawning_Other.pos_default.MS = {}
	SOHL.Spawning_Other.pos_default.CS = {}
	SOHL.Spawning_Other.pos_default.TY = {}
	for k, _ in pairs(SOHL.Spawn_Settings) do
		for _, v in pairs(SOHL.Spawn_Settings[k]) do
			if not v.POSNOADD then
				for _, pos in pairs(v.position) do
					table.insert(SOHL.Spawning_Other.pos_default[k], pos)
					table.insert(SOHL.Spawning_Other.sniper[k], pos)
				end
			end
		end

		for _, v in pairs(_other_position[k]) do
			table.insert(SOHL.Spawning_Other.sniper[k], v)
			table.insert(SOHL.Spawning_Other.pos_default[k], v)
		end
	end
	
	_other_position = {}
	
function SOHL:Announce(msg)
	managers.chat:send_message(ChatManager.GAME, "" , msg or "")
end

function set_team(unit)
	local team = unit:base():char_tweak().access == "gangster" and "gangster" or "combatant"
	local AIState = managers.groupai:state()
	local team_id = tweak_data.levels:get_default_team_ID(team)
	unit:movement():set_team(AIState:team_data(team_id))
end

function SOHL:_full_function_spawn(name, pos, rot, delay, stance)
	delay = delay or 1
	local _nowslot = math.random(1, 100)
	DelayedCalls:Add("DelayedCalls_SOHL_full_function_spawn_" .. _nowslot, delay, function()
		local _player_unit = {}
		for _, data in pairs(managers.groupai:state():all_criminals() or {}) do
			table.insert(_player_unit, data.unit)
		end
		local _final_unit_to_use = _player_unit[math.random(table.size(_player_unit))] or {}
		local new_objective = {
				type = "follow",
				follow_unit = _final_unit_to_use,
				scan = true,
				is_default = true
			}
		pos = pos + Vector3(0, 0, 10)
		local _u = World:spawn_unit(name, pos, rot)
		set_team(_u)
		_u:brain():set_spawn_ai( { init_state = "idle", params = { scan = true }, objective = new_objective } )
		_u:brain():action_request( { type = "act", body_part = 1, variant = "idle", align_sync = true } )
		_u:brain():on_reload()
		_u:movement():set_character_anim_variables()
	end)
end

SOHL.Run_Script_Data = SOHL.Run_Script_Data or {}

function SOHL:Run_Script(id_strings, them, id, element, instigator, delay)
	self.Run_Script_Data[id_strings] = {
		them = them,
		id = id,
		element = element,
		instigator = instigator,
		delay = delay + 0.1 + self.Now_Time
	}
	return self.Run_Script_Data[id_strings]
end

function SOHL:_heist_pos()
	if self.Spawn_Settings[self.Enable] then
		return self.Enable
	else
		return "SR"
	end
end