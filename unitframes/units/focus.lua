local addon = select(2, ...)

addon.units.focus = {
	spawn = function(self)
		local frame = self:Spawn('focus')
		frame:SetSize(150, 20)
		frame:SetPoint('TOPRIGHT', UIParent, 'CENTER', -497, -310)
	end,

	style = function(frame, unit)
		addon.elements.Base(frame, unit)

		addon.elements.Health(frame, unit)
		frame.Health:SetAllPoints()

		local name = addon.elements.Text(frame.Health)
		frame:Tag(name, '[AelUI:name]')
		name:SetPoint('BOTTOMLEFT', frame, 'TOPLEFT', 4, -6)
	end,
}
