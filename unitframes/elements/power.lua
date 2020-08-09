print("AelUI: unitframes/elements/power.lua")
local addon = select(2, ...)

addon.elements.Power = function(frame, unit)
	local Power = CreateFrame('StatusBar', nil, frame)
	Power:SetStatusBarTexture(addon.media.texture)
	Power.frequentUpdates = true
	Power.colorPower = true

	addon.elements.CreateBg(Power)

	frame.Power = Power
end
