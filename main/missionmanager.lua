if Network:is_client() then
	return
end

_G.SOHL = _G.SOHL or {}

local _heist_ID = {
	kosugi = "SR",
	dark = "MS",
	cage = "CS",
	fish = "TY"
	,tag = "BF"
}

local _mission_init_orig = MissionManager.init
function MissionManager:init(...)
	_mission_init_orig(self, ...)
	if Network:is_client() or not SOHL then
		return
	end
	if SOHL.Checker then
		SOHL.Checker = nil
	elseif Global.game_settings then
		SOHL.Enable = _heist_ID[Global.game_settings.level_id]
		if not SOHL.Enable then
			SOHL.Checker = true
		end
	else
		SOHL.Enable = nil
	end
end