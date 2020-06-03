print("AelUI: unitframes/elements/power.lua")
local addon = select(2, ...)

addon.elements.Power = function(self, unit)
	local Power = CreateFrame('StatusBar', nil, self)
	Power:SetStatusBarTexture(addon.media.textureBg)
	Power.frequentUpdates = true
	Power.colorPower = true

	addon.elements.CreateBg(Power)

	self.Power = Power
end
