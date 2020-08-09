local addon = select(2, ...)

addon.units.player = {
	spawn = function(self)
		local frame = self:Spawn('player')
		frame:SetSize(300, 30)
		frame:SetPoint('TOPRIGHT', UIParent, 'CENTER', -191, -300)
	end,

	style = function(frame, unit)
		addon.elements.Base(frame, unit)

		addon.elements.Health(frame, unit)
		frame.Health:SetAllPoints()

		addon.elements.Power(frame, unit)
		frame.Power:SetPoint('TOP', UIParent, 'CENTER', 0, -310)
		frame.Power:SetSize(298, 10)

		addon.elements.Castbar(frame, unit)
		frame.Castbar:SetPoint('TOP', UIParent, 'CENTER', 0, -326)
		frame.Castbar:SetWidth(298)
	end,
}
