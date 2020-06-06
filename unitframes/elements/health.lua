print("AelUI: unitframes/elements/health.lua")
local addon = select(2, ...)

addon.elements.Health = function(frame, unit)
	local Health = CreateFrame('StatusBar', nil, frame)
	Health:SetStatusBarTexture(addon.media.textureBg)
	Health.frequentUpdates = true
	Health.colorTapping = true
	Health.colorClass = true
	Health.colorReaction = true
	Health:SetReverseFill(true)
	Health.PostUpdate = function(Health, unit, min, max)
		Health:SetValue(max - Health:GetValue())
	end

	addon.elements.CreateFg(Health)

	frame.Health = Health
end
