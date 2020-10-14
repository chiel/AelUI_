local addon = select(2, ...)

local function UpdateHealthColor(self, event, unit)
	local element = self.Health
	if element.disconnected or UnitIsDeadOrGhost(unit) then
		element:SetValue(0)
	end

	local color = addon.utils.UnitColor(unit)
	if color then
		element.bd:SetVertexColor(unpack(color))
	end
end

function addon.elements.Health(self, unit)
	local health = CreateFrame('StatusBar', nil, self, 'BackdropTemplate')
	health:SetStatusBarTexture(addon.media.texture)
	health.colorTapping = unit ~= 'raid'
	health.colorDisconnected = true
	health:SetStatusBarColor(.15, .15, .15)
	health.UpdateColor = UpdateHealthColor
	health.bd = addon.elements.Backdrop(health)

	self.Health = health
end
