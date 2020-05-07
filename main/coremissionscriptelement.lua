core:module("CoreMissionScriptElement")
core:import("CoreXml")
core:import("CoreCode")
core:import("CoreClass")

_G.SOHL = _G.SOHL or {}
SOHL = _G.SOHL
SOHL.Run_Script_Data = SOHL.Run_Script_Data or {}
SOHL.Run_Extra_Func = SOHL.Run_Extra_Func or {}

SOHL.OpenVault = SOHL.OpenVault or MissionScriptElement.on_executed

function MissionScriptElement:on_executed(instigator, ...)
	local _id = "id_" .. tostring(self._id)
	if SOHL and SOHL.Enable and not Network:is_client() then
		if SOHL.Enable == "SR" then
			if _id == "id_100961" or _id == "id_100962" then
				if SOHL.Run_Script_Data["id_100964"] then
					SOHL.Run_Extra_Func["id_100964"] = nil
					SOHL.Run_Script_Data["id_100964"] = nil
				else
					SOHL:Run_Extra("id_100964", function()
						SOHL:Announce(SOHL.Lang.vault1 .. SOHL.Time4Use.OpenVault .. SOHL.Lang.vault2)
					end)
					SOHL:Run_Script("id_100964", self, 100964, self:get_mission_element(100964), instigator, SOHL.Time4Use.OpenVault)
				end
			elseif _id == "id_103454" then
				local element
				SOHL:Run_Extra("id_103789", function()
					SOHL:Announce(SOHL.Lang.garbage1)
				end)
				element = self:get_mission_element(103789)
				element._values.enabled = true
				SOHL:Run_Script("id_103789", self, 103789, element, instigator, 0)
				element = self:get_mission_element(103788)
				element._values.enabled = true
				SOHL:Run_Script("id_103788", self, 103788, element, instigator, 0)
			elseif _id == "id_103455" then
				local element
				SOHL:Run_Extra("id_103794", function()
					SOHL:Announce(SOHL.Lang.garbage2)
				end)
				element = self:get_mission_element(103794)
				element._values.enabled = true
				SOHL:Run_Script("id_103794", self, 103794, element, instigator, 0)
				element = self:get_mission_element(103793)
				element._values.enabled = true
				SOHL:Run_Script("id_103793", self, 103793, element, instigator, 0)
			elseif _id == "id_103456" then
				local element
				SOHL:Run_Extra("id_103779", function()
					SOHL:Announce(SOHL.Lang.garbage3)
				end)
				element = self:get_mission_element(103779)
				element._values.enabled = true
				SOHL:Run_Script("id_103779", self, 103779, element, instigator, 0)
				element = self:get_mission_element(103781)
				element._values.enabled = true
				SOHL:Run_Script("id_103781", self, 103781, element, instigator, 0)
			end
		elseif SOHL.Enable == "CS" then
			if _id == "id_105035" then
				if not SOHL.Timer_Enable then
					SOHL.Enable = nil
					SOHL.Checker = true
				else
					table.insert(SOHL.Spawn_Settings_List.CS, "Plus")
					for _, v in pairs(SOHL.Spawn_Settings.CS.Plus.position) do
						table.insert(SOHL.Spawning_Other.sniper.CS, v)
						table.insert(SOHL.Spawning_Other.pos_default.CS, v)
					end
				end
			end
		elseif SOHL.Enable == "BF" then
			if _id == "id_100655" then
				SOHL:Run_Script("id_100654", self, 100654, self:get_mission_element(100654), instigator, 0)
			elseif _id == "id_100654" then
				SOHL.Run_Script_Data["id_100654"] = nil
			elseif _id == "id_100911" and not SOHL.Timer_Enable then
				SOHL.Enable = nil
				SOHL.Checker = true
			end
		end
	end
	SOHL.OpenVault(self, instigator, ...)
end