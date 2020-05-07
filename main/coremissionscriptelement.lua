core:module("CoreMissionScriptElement")
core:import("CoreXml")
core:import("CoreCode")
core:import("CoreClass")

_G.SOHL = _G.SOHL or {}
SOHL = _G.SOHL
SOHL.Run_Script_Data = SOHL.Run_Script_Data or {}

SOHL.OpenVault = SOHL.OpenVault or MissionScriptElement.on_executed

function MissionScriptElement:on_executed(instigator, ...)
	local _id = "id_" .. tostring(self._id)
	if SOHL and SOHL.Enable and not Network:is_client() then
		if SOHL.Enable == "SR" and (_id == "id_100961" or _id == "id_100962") and not SOHL.Run_Script_Data[_id] then
			local element = self:get_mission_element(100964)
			if element then				
				local msg = "[System] Vault will open in ".. SOHL.Time4Use.OpenVault .." seconds"
				SOHL:Announce(msg)
				local _tmp = SOHL:Run_Script("id_100964", self, 100964, element, instigator, SOHL.Time4Use.OpenVault)
				SOHL.Run_Script_Data["id_100961"] = _tmp
				SOHL.Run_Script_Data["id_100962"] = _tmp
			end
		elseif SOHL.Enable == "CS" and _id == "id_105035" then
			if not SOHL.Timer_Enable then
				SOHL.Enable = nil
				SOHL.Checker = true
			else
				table.insert(SOHL.Spawn_Settings_List.CS, "Plus")
				for _, v in pairs(SOHL.Spawn_Settings_List.CS.Plus.position) do
					table.insert(SOHL.Spawning_Other.sniper.CS, v)
					table.insert(SOHL.Spawning_Other.pos_default.CS, v)
				end
			end
		elseif SOHL.Enable == "BF" then
			if _id == "id_100655" then
				local element = self:get_mission_element(100654)
				if element then
					SOHL._skip_obj_table = {
						self = self,
						element = element,
						instigator = instigator
					}
					SOHL._skip_obj_func()
				end
			elseif _id == "id_100654" then
				SOHL._skip_obj_table = nil
			end
		end
	end
	SOHL.OpenVault(self, instigator, ...)
end