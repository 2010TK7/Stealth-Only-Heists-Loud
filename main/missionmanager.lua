if Network:is_client() then
	return
end

_G.SOHL = _G.SOHL or {}

local _heist_ID = {
	kosugi = "SR",
	dark = "MS",
	cage = "CS",
	fish = "TY"
	--,tag = "BF"
}

local _mission_init_orig = MissionManager.init
function MissionManager:init(...)
	_mission_init_orig(self, ...)
	if Network:is_client() then
		return
	end
	if SOHL then
		if Global.game_settings and _heist_ID[Global.game_settings.level_id] and not SOHL.Checker then
			SOHL.Enable = _heist_ID[Global.game_settings.level_id]
		else
			SOHL.Enable = nil
			SOHL.Checker = nil
		end
	end
end