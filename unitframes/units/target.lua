local addon = select(2, ...)

addon.units.target = {
	spawn = function(self)
		local f = self:Spawn('target')
		f:SetSize(300, 30)
		f:SetPoint('TOPLEFT', UIParent, 'CENTER', 191, -300)
	end,

	style = function(self, unit)
		self:RegisterForClicks('AnyUp')
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = addon.colors

		addon.elements.Health(self, unit)
		self.Health:SetAllPoints()

		addon.elements.Castbar(self, unit)
		self.Castbar:SetPoint('TOP', UIParent, 'CENTER', 0, -140)
		self.Castbar:SetSize(298, 12)
		self.Castbar.Icon:ClearAllPoints()
		self.Castbar.Icon:SetPoint('TOPRIGHT', self.Castbar, 'TOPLEFT', -5, 1)

		local buffs = CreateFrame('Frame', nil, self)
		buffs.size = 24
		buffs.spacing = 4
		buffs:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', -1, 5)
		buffs:SetSize(32 * 4, 32 * 4)
		self.Buffs = buffs

		local name = addon.elements.Text(self.Health)
		self:Tag(name, '[AelUI:name]')
		name:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -4, -6)
	end,
}
