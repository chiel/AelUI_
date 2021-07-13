local addon = select(2, ...)

table.insert(addon.units, {
	unit = 'focus',

	spawn = function(self)
		local f = self:Spawn('focus', 'AelUIFocusFrame')
		f:SetSize(200, 30)
		f:SetPoint('BOTTOMRIGHT', AelUIPlayerFrame, 'TOPRIGHT', -50, 162)
	end,

	style = function(self, unit)
		self:RegisterForClicks('AnyUp')
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = addon.colors

		addon.elements.Health(self, unit)
		self.Health:SetAllPoints()

		local name = addon.elements.Text(self.Health)
		self:Tag(name, '[AelUI:name]')
		name:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 4, -6)

		addon.elements.RaidTarget(self, unit)
		self.RaidTargetIndicator:SetParent(self.Health)
		self.RaidTargetIndicator:SetPoint('CENTER', self.Health)
	end,
})
