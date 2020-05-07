if Network:is_client() then
	return
end

_G.SOHL = _G.SOHL or {}

local _mission_init_orig = MissionManager.init
function MissionManager:init(...)
	_mission_init_orig(self, ...)
	if Network:is_client() then
		return
	end
	if Global.game_settings and SOHL then
		if Global.game_settings.level_id == "kosugi" then
			SOHL.Enable = "SR"
		elseif Global.game_settings.level_id == "dark" then
			SOHL.Enable = "MS"
		elseif Global.game_settings.level_id == "cage" then
			SOHL.Enable = "CS"
		elseif Global.game_settings.level_id == "fish" then
			SOHL.Enable = "TY"
		elseif Global.game_settings.level_id == "tag" then
			SOHL.Enable = "BF"
		else
			SOHL.Enable = nil
		end
	end
end