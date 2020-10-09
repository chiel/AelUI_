local addon = select(2, ...)

local function PostUpdate(self, cur, max, maxChanged, powerType)
	if not self.isEnabled then
		self.container:Hide()
		return
	end

	self.container:Show()
	if not maxChanged then return end

	local width = (math.floor(self.container:GetWidth() + .5) + 2) / max
	for i = 1, 10 do
		local bar = self[i]
		local bd = bar.backdrop

		if i <= max then
			bd:SetWidth(width - 2)
			bd:SetPoint('LEFT', (i - 1) * width, 0)
			bd:Show()
		else
			bd:Hide()
		end
	end
end

function addon.elements.ClassPower(self, unit)
	local container = CreateFrame('Frame', nil, UIParent)
	container:SetFrameStrata('LOW')

	local classPower = {}
	for i = 1, 10 do
		local bd = CreateFrame('Frame', nil, container)
		bd:SetPoint('TOP')
		bd:SetPoint('BOTTOM')
		addon.elements.Backdrop(bd)

		local bar = CreateFrame('StatusBar', nil, bd)
		bar:SetStatusBarTexture(addon.media.texture)
		bar:SetAllPoints()

		bar.backdrop = bd
		classPower[i] = bar
	end

	classPower.PostUpdate = PostUpdate

	classPower.container = container
	self.ClassPower = classPower
end
