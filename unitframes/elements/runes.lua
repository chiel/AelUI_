print("AelUI: unitframes/elements/runes.lua")
local addon = select(2, ...)

addon.elements.Runes = function(frame, unit)
	local runeFrame = CreateFrame('Frame', nil, UIParent)

	local Runes = {}
	for i = 1, 6 do
		local Rune = CreateFrame('StatusBar', nil, frame)
		Rune:SetStatusBarTexture(addon.media.texture)
		Rune:SetParent(runeFrame)
		Rune:SetWidth(48)
		Rune:SetPoint('TOPLEFT', runeFrame, 'TOPLEFT', (i - 1) * 50, 0)
		Rune:SetPoint('BOTTOM', runeFrame, 'BOTTOM')
		addon.elements.CreateBg(Rune)
		Runes[i] = Rune
	end

	Runes.colorSpec = true
	Runes.sortOrder = 'asc'

	frame.Runes = Runes

	return runeFrame
end
