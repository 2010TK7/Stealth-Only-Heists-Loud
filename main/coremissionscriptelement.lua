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
			if managers.groupai:state():whisper_mode() then
				SOHL.Enable = nil
				SOHL.Checker = true
			else
				local pos = {
					Vector3(-13737.5, 20035, -754), Vector3(-16656, 22542, -767), Vector3(-18606, 31793, -774),
					Vector3(-8613, 38628, -264), Vector3(1719, 43850, -276)
				}
				for _, v in pairs(pos) do
					table.insert(SOHL.Spawn_Settings.CS.TK7.position, v)
					table.insert(SOHL.Spawning_Other.pos_default.CS, v)
					table.insert(SOHL.Spawning_Other.sniper.CS, v)
				end
			end
		elseif SOHL.Enable == "BF" and not managers.groupai:state():whisper_mode() then
			if _id == "id_100655" then
				local element = self:get_mission_element(100654)
				if element then
					SOHL.Run_Script_Data["id_100655"] = SOHL:Run_Script("id_100654", self, 100654, element, instigator, 1)
				end
			elseif _id == "id_101968" then
				self._values.enabled = false
			end
		end
	end
	SOHL.OpenVault(self, instigator, ...)
end