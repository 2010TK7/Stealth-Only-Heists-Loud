function ElementSpawnEnemyDummy:init(...)
	ElementSpawnEnemyDummy.super.init(self, ...)

	if self._values.enemy == "units/pd2_dlc_tag/characters/ene_male_commissioner/ene_male_commissioner" then
		self._enemy_name = Idstring("units/pd2_dlc_vip/characters/ene_vip_1/ene_vip_1")
	else
		self._enemy_name = self._values.enemy and Idstring(self._values.enemy) or Idstring("units/payday2/characters/ene_swat_1/ene_swat_1")
	end
	self._values.enemy = nil
	self._units = {}
	self._events = {}

	self:_finalize_values()
end