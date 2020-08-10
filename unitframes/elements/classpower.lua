local addon = select(2, ...)

addon.elements.ClassPower = function(frame, unit)
	local classPowerFrame = CreateFrame('Frame', nil, UIParent)

	local ClassPower = {}
	for i = 1, 10 do
		local bg = addon.elements.CreateBg(classPowerFrame)
		bg:ClearAllPoints()
		bg:SetPoint('BOTTOM', classPowerFrame, 'BOTTOM', 0, -1)

		local Bar = CreateFrame('StatusBar', nil, bg)
		Bar:SetStatusBarTexture(addon.media.texture)

		Bar.bgFrame = bg
		ClassPower[i] = Bar
	end

	ClassPower.PostUpdate = function(self, cur, max, maxChanged, powerType)
		if not ClassPower.isEnabled then
			classPowerFrame:Hide()
			return
		end

		classPowerFrame:Show()

		if not maxChanged then return end

		local width = 300 / max
		for i = 1, 10 do
			local Bar = ClassPower[i]
			local bg = Bar.bgFrame

			if i <= max then
				bg:SetWidth(width)
				bg:SetPoint('TOPLEFT', classPowerFrame, 'TOPLEFT', ((i - 1) * width) - 1, 1)
				Bar:SetPoint('TOPLEFT', bg, 'TOPLEFT', 1, -1)
				Bar:SetPoint('BOTTOMRIGHT', bg, 'BOTTOMRIGHT', -1, 1)
				bg:Show()
			else
				bg:Hide()
			end
		end
	end

	frame.ClassPower = ClassPower
	frame.classPowerFrame = classPowerFrame
end
