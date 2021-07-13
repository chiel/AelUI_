local addon = select(2, ...)

function addon.elements.Power(self, unit, name)
	local power = CreateFrame('StatusBar', name or nil, self)
	power:SetStatusBarTexture(addon.media.texture)
	power.colorPower = true
	power.frequentUpdates = true
	addon.elements.Backdrop(power)

	self.Power = power
end
