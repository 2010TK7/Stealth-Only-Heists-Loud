_G.SOHL = _G.SOHL or {}

if SystemInfo:language():key() == Idstring("schinese"):key() then
	SOHL.Lang = {
		warn = "【警告】即将进入强攻阶段",
		vault1 = "【提示】金库将在 ",
		vault2 = " 秒后开启",
		garbage1 = "【提示】已移除仓库门垃圾箱",
		garbage2 = "【提示】已移除西院墙垃圾箱",
		garbage3 = "【提示】已移除江边垃圾箱"
	}
else
	SOHL.Lang = {
		warn = "[System] Assault Wave: Anticipation",
		vault1 = "[System] Vault will open in ",
		vault2 = " seconds",
		garbage1 = "[System] Removed Warehouse Doors Garbage",
		garbage2 = "[System] Removed West Compound Wall Garbage",
		garbage3 = "[System] Removed Waterfront Garbage"
	}
end