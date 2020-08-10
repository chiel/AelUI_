local addon = select(2, ...)

addon.units.targettarget = {
	spawn = function(self)
		local frame = self:Spawn('targettarget')
		frame:SetSize(150, 20)
		frame:SetPoint('TOPLEFT', UIParent, 'CENTER', 497, -310)
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
