print("AelUI: unitframes/elements/castbar.lua")
local addon = select(2, ...)

addon.elements.Castbar = function(frame, unit)
	local Castbar = CreateFrame('StatusBar', nil, frame)
	Castbar:SetStatusBarTexture(addon.media.texture)
	Castbar:SetStatusBarColor(22 / 255, 142 / 255, 198 / 255)
	Castbar:SetHeight(4)

	addon.elements.CreateBg(Castbar)

	local Icon = Castbar:CreateTexture(nil, 'OVERLAY')
	Icon:SetSize(32, 32)
	Icon:SetPoint('BOTTOMRIGHT', Castbar, 'BOTTOMLEFT', -5, -1)

	local Text = Castbar:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
	Text:SetFont(addon.media.fontPixel, 8, 'MONOCHROME,OUTLINE')
	Text:SetTextColor(1, 1, 1)
	Text:SetPoint('TOPLEFT', Castbar, 'BOTTOMLEFT', 4, -6)

	local Time = Castbar:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
	Time:SetFont(addon.media.fontPixel, 8, 'MONOCHROME,OUTLINE')
	Time:SetTextColor(1, 1, 1)
	Time:SetPoint('TOPRIGHT', Castbar, 'BOTTOMRIGHT', -4, -6)

	Castbar.Icon = Icon
	Castbar.Text = Text
	Castbar.Time = Time

	frame.Castbar = Castbar
end