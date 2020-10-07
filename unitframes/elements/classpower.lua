local addon = select(2, ...)

function addon.elements.ClassPower(self, unit)
	local classPowerFrame = CreateFrame('Frame', nil, UIParent)
	classPowerFrame:SetFrameStrata('LOW')

	local classPower = {}
	for i = 1, 10 do
		local bd = addon.elements.Backdrop(classPowerFrame)
		bd:ClearAllPoints()
		bd:SetPoint('BOTTOM', classPowerFrame, 'BOTTOM', 0, -1)

		local bar = CreateFrame('StatusBar', nil, bd)
		bar:SetStatusBarTexture(addon.media.texture)

		bar.bd = bd
		classPower[i] = bar
	end

	classPower.PostUpdate = function(self, cur, max, maxChanged, powerType)
		if not classPower.isEnabled then
			classPowerFrame:Hide()
			return
		end

		classPowerFrame:Show()

		if not maxChanged then return end

		local width = 300 / max
		for i = 1, 10 do
			local bar = classPower[i]
			local bd = bar.bd

			if i <= max then
				bd:SetWidth(width)
				bd:SetPoint('TOPLEFT', classPowerFrame, 'TOPLEFT', ((i - 1) * width) - 1, 1)
				bar:SetPoint('TOPLEFT', bd, 'TOPLEFT', 1, -1)
				bar:SetPoint('BOTTOMRIGHT', bd, 'BOTTOMRIGHT', -1, 1)
				bd:Show()
			else
				bd:Hide()
			end
		end
	end

	self.ClassPower = classPower
	self.classPowerFrame = classPowerFrame
end
