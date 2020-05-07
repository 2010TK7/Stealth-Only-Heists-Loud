if Network:is_client() then
	return
end

_G.SOHL = _G.SOHL or {}

local _f_GroupAIStateBase_update_point_of_no_return = GroupAIStateBase._update_point_of_no_return

function GroupAIStateBase:_update_point_of_no_return(...)
	if SOHL and SOHL.Enable and SOHL.Timer_Enable then
		managers.hud:hide_point_of_no_return_timer()
		managers.hud:remove_updator("point_of_no_return")
		self._point_of_no_return_timer = 0
		managers.network.matchmake:set_server_joinable(true)
		return
	end
	_f_GroupAIStateBase_update_point_of_no_return(self, ...)
end