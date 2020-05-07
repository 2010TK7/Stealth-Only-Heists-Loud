core:module("CoreMissionScriptElement")
core:import("CoreXml")
core:import("CoreCode")
core:import("CoreClass")

_G.SOHL = _G.SOHL or {}
SOHL = _G.SOHL
SOHL.Run_Script_Data = SOHL.Run_Script_Data or {}

SOHL.OpenVault = SOHL.OpenVault or MissionScriptElement.on_executed
SOHL._skip_obj_table = SOHL._skip_obj_table or {}

function MissionScriptElement:on_executed(instigator, ...)
	local _id = "id_" .. tostring(self._id)
	if SOHL and SOHL.Enable and not Network:is_client() then
		if SOHL.Enable == "SR" then
			if _id == "id_100961" or _id == "id_100962" then
				if SOHL._skip_obj_table.vault then
					SOHL._skip_obj_table.vault = nil
				else
					SOHL._skip_obj_table.vault = {
						id = 100964,
						self = self,
						element = self:get_mission_element(100964),
						instigator = instigator,
						delay = SOHL.Time4Use.OpenVault,
						to = {"id_100961", "id_100962"},
						extra = {
							function()
								SOHL:Announce(SOHL.Lang.vault1 .. SOHL.Time4Use.OpenVault .. SOHL.Lang.vault2)
							end
						}
					}
				end
			elseif _id == "id_103454" then
				SOHL._skip_obj_table.garbage_1 = {
					id = 103789,
					self = self,
					element = self:get_mission_element(103789),
					instigator = instigator,
					extra = {
						function()
							SOHL:Announce(SOHL.Lang.garbage1)
							SOHL._skip_obj_table.garbage_1.element._values.enabled = true
						end
					}
				}
				SOHL._skip_obj_table.garbage_icon_1 = {
					id = 103788,
					self = self,
					element = self:get_mission_element(103788),
					instigator = instigator,
					extra = {
						function()
							SOHL._skip_obj_table.garbage_icon_1.element._values.enabled = true
						end
					}
				}
			elseif _id == "id_103455" then
				SOHL._skip_obj_table.garbage_2 = {
					id = 103794,
					self = self,
					element = self:get_mission_element(103794),
					instigator = instigator,
					extra = {
						function()
							SOHL:Announce(SOHL.Lang.garbage2)
							SOHL._skip_obj_table.garbage_2.element._values.enabled = true
						end
					}
				}
				SOHL._skip_obj_table.garbage_icon_2 = {
					id = 103793,
					self = self,
					element = self:get_mission_element(103793),
					instigator = instigator,
					extra = {
						function()
							SOHL._skip_obj_table.garbage_icon_2.element._values.enabled = true
						end
					}
				}
			elseif _id == "id_103456" then
				SOHL._skip_obj_table.garbage_3 = {
					id = 103779,
					self = self,
					element = self:get_mission_element(103779),
					instigator = instigator,
					extra = {
						function()
							SOHL:Announce(SOHL.Lang.garbage3)
							SOHL._skip_obj_table.garbage_3.element._values.enabled = true
						end
					}
				}
				SOHL._skip_obj_table.garbage_icon_3 = {
					id = 103781,
					self = self,
					element = self:get_mission_element(103781),
					instigator = instigator,
					extra = {
						function()
							SOHL._skip_obj_table.garbage_icon_3.element._values.enabled = true
						end
					}
				}
			end
		elseif SOHL.Enable == "CS" and _id == "id_105035" then
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
		elseif SOHL.Enable == "BF" then
			if _id == "id_100655" then
				SOHL._skip_obj_table.garrett = {
					id = 100654,
					self = self,
					element = self:get_mission_element(100654),
					instigator = instigator,
					to = {"id_100655"}
				}
			elseif _id == "id_100654" then
				SOHL._skip_obj_table.garrett = nil
			end
		end
	end
	SOHL.OpenVault(self, instigator, ...)
end