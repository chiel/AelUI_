local addon = select(2, ...)

addon.units.boss = {
	spawn = function(self)
		local boss = {}
		for i = 1, MAX_BOSS_FRAMES or 5 do
			boss[i] = self:Spawn('boss' .. i)
			boss[i]:SetSize(250, 30)

			if i == 1 then
				boss[i]:SetPoint('TOPLEFT', UIParent, 'CENTER', 596, 200)
			else
				boss[i]:SetPoint('TOPLEFT', boss[i - 1], 'BOTTOMLEFT', 0, -48)
			end
		end
	end,

	style = function(self, unit)
		self:RegisterForClicks('AnyUp')
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = addon.colors

		addon.elements.Health(self, unit)
		self.Health:SetAllPoints()
		self.Health:SetPoint('BOTTOM', 0, 5)

		addon.elements.Power(self, unit)
		self.Power:SetPoint('BOTTOMLEFT')
		self.Power:SetPoint('BOTTOMRIGHT')
		self.Power:SetHeight(4)

		addon.elements.Castbar(self, unit)
		self.Castbar:SetPoint('TOPLEFT', self.Power, 'BOTTOMLEFT', 0, -4)
		self.Castbar:SetPoint('TOPRIGHT', self.Power, 'BOTTOMRIGHT', 0, -4)
		self.Castbar:SetHeight(4)
		self.Castbar.Icon:SetSize(40, 40)
		self.Castbar.Icon:ClearAllPoints()
		self.Castbar.Icon:SetPoint('BOTTOMLEFT', self.Castbar, 'BOTTOMRIGHT', 5, -1)

		local nameText = addon.elements.Text(self.Health)
		self:Tag(nameText, '[AelUI:name]')
		nameText:SetJustifyH('RIGHT')
		nameText:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -4, -6)

		local healthText = addon.elements.Text(self.Health, { size = 16 })
		self:Tag(healthText, '[AelUI:healthpercent]')
		healthText:SetJustifyH('LEFT')
		healthText:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 4, -6)
	end,
}
