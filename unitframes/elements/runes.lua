local addon = select(2, ...)

function addon.elements.Runes(self, unit)
	local runesFrame = CreateFrame('Frame', nil, UIParent)
	runesFrame:SetFrameStrata('LOW')

	local runes = {}
	for i = 1, 6 do
		local rune = CreateFrame('StatusBar', nil, runesFrame)
		rune:SetStatusBarTexture(addon.media.texture)
		rune:SetWidth(48)
		rune:SetPoint('TOPLEFT', runesFrame, 'TOPLEFT', (i - 1) * 50, 0)
		rune:SetPoint('BOTTOM', runesFrame, 'BOTTOM')
		addon.elements.Backdrop(rune)
		runes[i] = rune
	end

	runes.colorSpec = true
	runes.sortOrder = 'asc'

	self.Runes = runes
	self.runesFrame = runesFrame
end
