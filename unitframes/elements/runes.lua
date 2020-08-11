local addon = select(2, ...)

addon.elements.Runes = function(frame, unit)
	local runesFrame = CreateFrame('Frame', nil, UIParent)

	local Runes = {}
	for i = 1, 6 do
		local Rune = CreateFrame('StatusBar', nil, runesFrame)
		Rune:SetStatusBarTexture(addon.media.texture)
		Rune:SetWidth(48)
		Rune:SetPoint('TOPLEFT', runesFrame, 'TOPLEFT', (i - 1) * 50, 0)
		Rune:SetPoint('BOTTOM', runesFrame, 'BOTTOM')
		addon.elements.CreateBg(Rune)
		Runes[i] = Rune
	end

	Runes.colorSpec = true
	Runes.sortOrder = 'asc'

	frame.Runes = Runes
	frame.runesFrame = runesFrame
end
