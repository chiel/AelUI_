local addon = select(2, ...)

local function UpdatePositions(self)
	local totalWidth = math.floor(self.container:GetWidth() + .5) + 1
	local width = math.floor(totalWidth / 6)
	local rest = totalWidth - (width * 6)

	for i = 1, 6 do
		local w = width - 1
		if rest > 0 then
			w = w + 1
			rest = rest - 1
		end

		self[i]:SetWidth(w)
	end
end

function addon.elements.Runes(self, unit)
	local container = CreateFrame('Frame', nil, UIParent)
	container:SetFrameStrata('LOW')

	local runes = {}
	for i = 1, 6 do
		local rune = CreateFrame('StatusBar', nil, container)
		rune:SetStatusBarTexture(addon.media.texture)
		rune:SetPoint('TOP')
		rune:SetPoint('BOTTOM')
		rune:SetPoint('LEFT')

		if i > 1 then
			rune:SetPoint('LEFT', runes[i - 1], 'RIGHT', 1, 0)
		end

		addon.elements.Backdrop(rune)
		runes[i] = rune
	end

	runes.colorSpec = true
	runes.sortOrder = 'asc'

	runes.container = container
	self.Runes = runes

	container:HookScript('OnSizeChanged', function()
		UpdatePositions(runes)
	end)
end
