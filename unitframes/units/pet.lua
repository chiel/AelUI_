local addon = select(2, ...)

addon.units.pet = {
	spawn = function(self)
		local f = self:Spawn('pet')
		f:SetSize(156, 30)
		f:SetPoint('TOPRIGHT', UIParent, 'CENTER', -335, -336)
	end,

	style = function(self, unit)
		self:RegisterForClicks('AnyUp')
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = addon.colors

		addon.elements.Health(self, unit)
		self.Health:SetAllPoints()
	end,
}
