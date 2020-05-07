if Network:is_client() then
	return
end

_G.SOHL = _G.SOHL or {}

local _f_GroupAIStateBase_update_point_of_no_return = GroupAIStateBase._update_point_of_no_return

function GroupAIStateBase:_update_point_of_no_return(...)
	if SOHL and SOHL.Enable and SOHL.Timer_Enable then
		local garrett = false
		if SOHL.Enable == "BF" then
			for _, data in pairs(managers.enemy:all_enemies()) do
				if data.unit:name() == Idstring("units/pd2_dlc_tag/characters/ene_male_commissioner/ene_male_commissioner") then
					data.unit:set_slot(0)
					managers.network:session():send_to_peers_synched( "remove_unit", data.unit )
					garrett = true
					SOHL:Announce(SOHL.Lang.warn)
				end
			end
		end
		if SOHL.Enable ~= "BF" or garrett then
			managers.hud:hide_point_of_no_return_timer()
			managers.hud:remove_updator("point_of_no_return")
			self._point_of_no_return_timer = 0
			managers.network.matchmake:set_server_joinable(true)
			return
		else
			self._point_of_no_return_timer = -1
		end
	end
	_f_GroupAIStateBase_update_point_of_no_return(self, ...)
end