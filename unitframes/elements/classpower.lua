local addon = select(2, ...)

local function UpdatePositions(self)
	local totalWidth = math.floor(self.container:GetWidth() + .5) + 2
	local max = self.__max
	local width = math.floor(totalWidth / max)
	local rest = totalWidth - (width * max) - 1

	for i = 1, max do
		local w = width - 1
		if rest > 0 then
			w = w + 1
			rest = rest - 1
		end

		self[i].backdrop:SetWidth(w)
	end
end

local function PostUpdate(self, cur, max, maxChanged, powerType)
	if not self.__isEnabled then
		self.container:Hide()
		return
	end

	self.container:Show()
	if not maxChanged then return end

	for i = 1, 10 do
		if i <= max then
			self[i].backdrop:Show()
		else
			self[i].backdrop:Hide()
		end
	end

	UpdatePositions(self)
end

function addon.elements.ClassPower(self, unit)
	local container = CreateFrame('Frame', nil, UIParent)
	container:SetFrameStrata('LOW')

	local classPower = {}
	for i = 1, 10 do
		local bd = CreateFrame('Frame', nil, container)
		addon.elements.Backdrop(bd)
		bd:SetPoint('TOP')
		bd:SetPoint('BOTTOM')
		bd:SetPoint('LEFT')

		if i > 1 then
			bd:SetPoint('LEFT', classPower[i - 1].backdrop, 'RIGHT', 1, 0)
		end

		local bar = CreateFrame('StatusBar', nil, bd)
		bar:SetStatusBarTexture(addon.media.texture)
		bar:SetAllPoints()

		bar.backdrop = bd
		classPower[i] = bar
	end

	classPower.PostUpdate = PostUpdate

	classPower.container = container
	self.ClassPower = classPower

	container:HookScript('OnSizeChanged', function()
		UpdatePositions(classPower)
	end)
end
