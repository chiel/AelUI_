local addon = select(2, ...)

local function UpdateHealthColor(health, unit, cur, max)
	if health.disconnected or UnitIsDeadOrGhost(unit) then
		health:SetValue(0)
	end

	local color = addon.utils.UnitColor(unit)
	if color then
		health:SetStatusBarColor(.15, .15, .15)
		health.bd:SetBackdropColor(unpack(color))
	end
end

function addon.elements.Health(self, unit)
	local health = CreateFrame('StatusBar', nil, self)
	health:SetStatusBarTexture(addon.media.texture)
	health.colorTapping = unit ~= 'raid'
	health.colorDisconnected = true
	health.frequentUpdates = true
	health.UpdateColor = UpdateHealthColor
	health.bd = addon.elements.Backdrop(health)

	self.Health = health
end
