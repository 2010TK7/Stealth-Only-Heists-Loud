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
	if SOHL and SOHL.Enable and SOHL.Enable == "SR" and not Network:is_client() then
		if (_id == "id_100961" or _id == "id_100962") and not SOHL.Run_Script_Data[_id] then
			local element = self:get_mission_element(100964)
			if element then				
				local msg = "[System] Vault will open in ".. SOHL.Time4Use.OpenVault .." seconds"
				SOHL:Announce(msg)
				local _tmp = SOHL:Run_Script("id_100964", self, 100964, element, instigator, SOHL.Time4Use.OpenVault)
				SOHL.Run_Script_Data["id_100961"] = _tmp
				SOHL.Run_Script_Data["id_100962"] = _tmp
			end
		end
	end
	SOHL.OpenVault(self, instigator, ...)
end