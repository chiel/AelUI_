local addon = select(2, ...)

function addon.elements.Power(self, unit)
	local power = CreateFrame('StatusBar', nil, self)
	power:SetStatusBarTexture(addon.media.texture)
	power.colorPower = true
	power.frequentUpdates = true
	power.bd = addon.elements.Backdrop(power)

	self.Power = power
end
