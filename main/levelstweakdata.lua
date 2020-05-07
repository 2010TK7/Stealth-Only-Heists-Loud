local _f_init = LevelsTweakData.init

function LevelsTweakData:init()
	_f_init(self)
	self.kosugi.music = self.shoutout_raid.music
	self.dark.music = self.shoutout_raid.music
	self.fish.music = self.shoutout_raid.music
	--self.tag.music = self.shoutout_raid.music
end