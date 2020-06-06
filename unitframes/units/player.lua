local addon = select(2, ...)

addon.units.player = {
	spawn = function(self)
		local frame = self:Spawn('player')
		frame:SetSize(300, 30)
		frame:SetPoint('TOPRIGHT', UIParent, 'CENTER', -192, -300)
	end,

	style = function(frame, unit)
		addon.elements.Base(frame, unit)

		addon.elements.Health(frame, unit)
		frame.Health:SetAllPoints()

		addon.elements.Power(frame, unit)
		frame.Power:SetPoint('TOP', UIParent, 'CENTER', 0, -300)
		frame.Power:SetSize(300, 12)

		addon.elements.Castbar(frame, unit)
		frame.Castbar:SetPoint('TOPLEFT', frame.Power, 'BOTTOMLEFT', 0, -6)
		frame.Castbar:SetPoint('TOPRIGHT', frame.Power, 'BOTTOMRIGHT', 0, -6)
		frame.Castbar:SetHeight(12)
	end,
}
