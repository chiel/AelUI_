local addon = select(2, ...)

local LSM = LibStub('LibSharedMedia-3.0')
local MT = LSM.MediaType
LSM:Register(MT.FONT, 'AelUI font', [[Interface\AddOns\AelUI\media\RobotoCondensed-Regular.ttf]])
LSM:Register(MT.FONT, 'AelUI pixel font', [[Interface\AddOns\AelUI\media\semplice.ttf]])
LSM:Register(MT.BACKGROUND, 'AelUI background', [[Interface\Buttons\WHITE8X8]])
LSM:Register(MT.BORDER, 'AelUI border', [[Interface\Buttons\WHITE8X8]])
LSM:Register(MT.STATUSBAR, 'AelUI bar', [[Interface\AddOns\AelUI\media\statusbar]])
LSM:Register(MT.STATUSBAR, 'AelUI pixelbar', [[Interface\AddOns\AelUI\media\pixelbar]])

addon.colors = setmetatable({
	power = setmetatable({
		['ENERGY'] = { 0.7372549019607844, 0.6862745098039216, 0.3764705882352941 },
		['MANA'] = { 0.2941176470588235, 0.6, 0.8980392156862745 },
		['RAGE'] = { 1, 0.3568627450980392, 0.3098039215686275 },
		['RUNIC_POWER'] = { 0, 0.7686274509803921, 0.9372549019607843 }
	}, {__index = oUF.colors.power}),
	reaction = {
		{ 1, 0.2509803921568627, 0.2196078431372549 },
		{ 1, 0.1882352941176471, 0.1882352941176471 },
		{ 0.7607843137254902, 0.203921568627451, 0.1764705882352941 },
		{ 0.8980392156862745, 0.7568627450980392, 0.2196078431372549 },
		{ 0.4941176470588236, 0.803921568627451, 0.2705882352941176 },
		{ 0.4941176470588236, 0.803921568627451, 0.2705882352941176 },
		{ 0.04705882352941176, 0.5254901960784314, 0.788235294117647 },
		{ 0.04705882352941176, 0.5254901960784314, 0.788235294117647 },
		["civilian"] = { 0.04705882352941176, 0.5254901960784314, 0.788235294117647 }
	},
}, {__index = oUF.colors})

addon.media = {
	border = [[Interface\Buttons\WHITE8X8]],
	font = [[Interface\AddOns\AelUI\media\RobotoCondensed-Regular.ttf]],
	fontPixel = [[Interface\AddOns\AelUI\media\semplice.ttf]],
	texture = [[Interface\AddOns\AelUI\media\statusbar]],
	textureBg = [[Interface\Buttons\WHITE8X8]],
	textureStriped = [[Interface\AddOns\Kui_Media\t\stippled-bar.tga]],
}

hooksecurefunc('GameTooltip_SetDefaultAnchor', function(self, parent)
	self:SetOwner(parent, 'ANCHOR_NONE')
	self:ClearAllPoints()
	self:SetPoint('BOTTOMRIGHT', UIParent, 'BOTTOMRIGHT', -456, 15)
end)

-- local f = CreateFrame('Frame')
-- f:RegisterEvent('PLAYER_ENTERING_WORLD')
-- f:SetScript('OnEvent', function()
-- 	print('DO THE THINGS')
-- 	PlayerFrame:ClearAllPoints()
-- 	PlayerFrame:SetPoint('BOTTOMRIGHT', UIParent, 'CENTER', -500, 200)
--
-- 	TargetFrame:ClearAllPoints()
-- 	TargetFrame:SetPoint('BOTTOMLEFT', UIParent, 'CENTER', -500, 200)
--
-- 	FocusFrame:ClearAllPoints()
-- 	FocusFrame:SetPoint('BOTTOMLEFT', UIParent, 'CENTER', -500, 0)
-- end)

-- SLASH_AELUI1 = '/aui'
-- SLASH_AELUI2 = '/aelui'
-- SlashCmdList.AELUI = function(msg)
-- 	local cmd, opts = string.match(msg, '(%S+)%s(.*)')
-- 	cmd = string.lower(cmd or '')
-- 	opts = string.gsub(opts or '', '^%s*(.-)%s*$', '%1')
--
-- 	if cmd == 'actionbars' or cmd == 'bars' then
-- 		addon.actionbars.HandleSlashCmd(opts)
-- 	end
--
-- 	print('CMD', cmd, opts)
-- end
