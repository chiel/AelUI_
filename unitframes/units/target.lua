local addon = select(2, ...)

addon.units.target = {
	spawn = function(self)
		local frame = self:Spawn('target')
		frame:SetSize(300, 30)
		frame:SetPoint('TOPLEFT', UIParent, 'CENTER', 191, -300)
	end,

	style = function(frame, unit)
		addon.elements.Base(frame, unit)

		addon.elements.Health(frame, unit)
		frame.Health:SetAllPoints()

		local name = addon.elements.Text(frame.Health)
		frame:Tag(name, '[AelUI:name]')
		name:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', -4, -6)
	end,
}
