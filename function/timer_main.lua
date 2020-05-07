if Network:is_client() then
	return
end

_G.SOHL = _G.SOHL or {}

local _D = SOHL.Difficulty

local _AFTER_GROUP_TOTAL_DELAY = 0

SOHL.GameSetup_Timer_Enable = false
SOHL.Timer_Enable = false
SOHL.Delay_Timer = 0
SOHL.Go_Loud_Stage = 0
SOHL.ForcedAssault = false

local _post_init_orig = MissionBriefingGui.flash_ready
function MissionBriefingGui:flash_ready()
	if not SOHL.GameSetup_Timer_Enable then
		SOHL.GameSetup_Timer_Enable = true
		math.randomseed(os.time())
		SOHL:Timer_Main()
	end
	_post_init_orig(self)
end

function SOHL:Timer_Main()
	local _nowtime = math.floor(TimerManager:game():time())
	local _start_time = self.Start_Time or 0
	self.Now_Time = _nowtime
	--Mission start
	if isPlaying() and self and self.Enable then
		--Init
		if not self.Timer_Enable and (not managers.groupai:state():whisper_mode() or managers.groupai:state()._point_of_no_return_timer) then
			if managers.groupai:state():whisper_mode() then
				managers.groupai:state():on_police_called("empty")
			end
			self.Timer_Enable = true
			self.Start_Time = _nowtime
			self.Delay_Timer = _nowtime + self.Time4Use.FirstSpawn
			self.Go_Loud_Stage = 1
		end
		--Go loud
		if self.Timer_Enable and self.Delay_Timer < _nowtime and self.Go_Loud_Stage == 1 then
			self.Delay_Timer = self.Time4Use.RepeatSpawn + _nowtime
			if not self.ForcedAssault and _nowtime - self.Start_Time > 10 then
				managers.groupai:state():special_assault_function()
				self.ForcedAssault = true
			end
			_AFTER_GROUP_TOTAL_DELAY = 0
			local _all_enemies = managers.enemy:all_enemies() or {}
			local _Spawning = self._Spawning or {}
			local _Spawning_Total = self._Spawning_Total or {}
			local _Spawn_Settings_List = self.Spawn_Settings_List[self:_heist_pos()]
			local _T = table.size(_Spawn_Settings_List)
			local _C = _Spawning[_D]
			local _total_enemies = table.size(_all_enemies)
			local _enemy_type_amount = {}
			for _, data in pairs(_all_enemies) do
				local enemyType = tostring(data.unit:base()._tweak_table)
				if not _enemy_type_amount[enemyType] then
					_enemy_type_amount[enemyType] = 1
				else
					_enemy_type_amount[enemyType] = _enemy_type_amount[enemyType] + 1
				end
			end
			if _total_enemies < _Spawning_Total[_D] then
				local _Last_R
				for i = 1, _C do
					local _R = _Spawn_Settings_List[math.random(_T)]
					if _Last_R ~= _R then
						_Last_R = _R
						self:Spawn_Group(_R)
					else
						_C = _C + 1
					end
				end
			end
			if not _enemy_type_amount["sniper"] then
				_enemy_type_amount["sniper"] = 0
			end
			if _enemy_type_amount["sniper"] < self._Spawning_Other_Total["sniper"][_D] then

				local _pos_sniper = self.Spawning_Other.sniper[self:_heist_pos()]
				self:_full_function_spawn(
					Idstring("units/pd2_dlc_drm/characters/ene_zeal_swat_heavy_sniper/ene_zeal_swat_heavy_sniper"),
					_pos_sniper[math.random(#_pos_sniper)], Rotation(0, 0, 1)
				)
				if _D == "sm_wish" then
					self:_full_function_spawn(
						Idstring("units/pd2_dlc_drm/characters/ene_zeal_swat_heavy_sniper/ene_zeal_swat_heavy_sniper"),
						_pos_sniper[math.random(#_pos_sniper)], Rotation(0, 0, 1)
					)
				end
			end
			local _other = {
				taser = self.Spawning_Other.taser,
				shield = self.Spawning_Other.shield,
				spooc = self.Spawning_Other.spooc,
				tank = self.Spawning_Other.tank,
				medic = self.Spawning_Other.medic
			}						
			local _list
			local _pos_other = self.Spawning_Other.pos_default[self:_heist_pos()]
			for _type, _data in pairs(_other) do
				_type = tostring(_type)
				_list = _data.name
				if not _enemy_type_amount[_type] then
					_enemy_type_amount[_type] = 0
				end
				if _enemy_type_amount[_type] < self._Spawning_Other_Total[_type][_D] then
					for i = 1, _data.amount do
						self:_full_function_spawn(
							_list[math.random(#_list)],
							_pos_other[math.random(#_pos_other)], Rotation(0, 0, 1), _AFTER_GROUP_TOTAL_DELAY + i
						)
					end
				end
			end
			math.randomseed(tostring(os.time()):reverse():sub(1, 6))
		end
	end
	--Repeat
	DelayedCalls:Add("DelayedCalls_SOHL_Timer_Main", 1, function()
		if self and not self.Checker then
			self:Timer_Main()
		end
	end)
	if self.Run_Script_Data then
		for k, v in pairs(self.Run_Script_Data or {}) do
			if v and type(v.delay) == "number" and _nowtime > v.delay then
				local them = v.them
				local id = v.id
				local element = v.element
				local instigator = v.instigator
				managers.network:session():send_to_peers_synched("run_mission_element_no_instigator", id, 0.1)
				them._mission_script:add(callback(element, element, "on_executed", instigator), 0.1, 1)
				self.Run_Script_Data[k] = {}
			end
		end
	end
end

function SOHL:Spawn_Group(_R)
	local _S = {}
	local _Spawn_Settings = self.Spawn_Settings[self:_heist_pos()]
	_S = _Spawn_Settings[_R] or {}
	if _S and _S.enemy then
		local _enemy = _S.enemy[_D] or {}
		if _enemy then
			local _pos = _S.position or nil
			local _rot = _S.rotation or nil
			local _id = _S.group_id or nil
			if _pos and _rot and _id then
				local k = 1
				for j = 1, (_S.enemy.amount and #_pos and math.max(_S.enemy.amount, #_pos) or _S.enemy.amount or #_pos or 0) do
					if k > #_pos then k = 1 end
					self:_full_function_spawn(Idstring(_S.enemy[_D][math.random(#_S.enemy[_D])]), _pos[k], rot, j*2)
					if j <= 3 then
						_AFTER_GROUP_TOTAL_DELAY = _AFTER_GROUP_TOTAL_DELAY + j*2
					end
					k = k + 1
				end
			end
		end
	end
end

function isPlaying()
	if not BaseNetworkHandler then return false end
	return BaseNetworkHandler._gamestate_filter.any_ingame_playing[ game_state_machine:last_queued_state_name() ]
end