local addon = select(2, ...)

table.insert(addon.units, {
	unit = 'pet',

	spawn = function(self)
		local f = self:Spawn('pet', 'AelUIPetFrame')
		f:SetHeight(20)
		-- f:SetSize(156, 30)
		f:SetPoint('TOPLEFT', AelUIPlayerFrame, 'BOTTOMLEFT', 0, -4)
		f:SetPoint('TOPRIGHT', AelUIPlayerFrame, 'BOTTOMRIGHT', 0, -4)
	end,

	style = function(self, unit)
		self:RegisterForClicks('AnyUp')
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = addon.colors

		addon.elements.Health(self, unit)
		self.Health:SetAllPoints()
	end,
})
