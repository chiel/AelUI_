local addon = select(2, ...)

local function UpdateHealthColor(health, unit, cur, max)
	local r, g, b, t
	if health.disconnected and health.colorDisconnected or UnitIsDeadOrGhost(unit) then
		health:SetValue(max)
		t = colors.disconnected
	elseif health.colorTapping and not UnitPlayerControlled(unit) and UnitIsTapDenied(unit) then
		t = colors.tapped
	else
		t = {.15, .15, .15}
	end

	if t then
		r, g, b = t[1], t[2], t[3]
	end

	if b then
		health:SetStatusBarColor(r, g, b)

		local _, class = UnitClass(unit)
		health.bd:SetBackdropColor(unpack(addon.colors.class[class]))
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
