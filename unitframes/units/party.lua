local addon = select(2, ...)

local function UpdatePower(self, event, unit)
	if(unit ~= self.unit) then return end

	local visible = addon.utils.UnitIsHealer(unit)

	if visible then
		self.Power:SetMinMaxValues(0, UnitPowerMax(unit, Enum.PowerType.Mana))
		self.Power:SetValue(UnitPower(unit, Enum.PowerType.Mana))
	end

	self.Health:SetPoint('BOTTOM', 0, visible and 5 or 0)
	self.Power:SetShown(visible)
end

addon.units.party = {
	spawn = function(self)
		local party = self:SpawnHeader(
			'aelUI_party', nil, 'party',
			'showParty', true,
			'showPlayer', true,
			'yOffset', -48,
			'groupBy', 'ASSIGNEDROLE',
			'groupingOrder', 'TANK,HEALER,DAMAGER',
			'oUF-initialConfigFunction', [[
				self:SetWidth(250)
				self:SetHeight(30)
			]]
		)

		party:SetPoint('TOPRIGHT', UIParent, 'CENTER', -596, 200)
	end,

	style = function(self, unit)
		self:RegisterForClicks('AnyUp')
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = addon.colors

		addon.elements.Health(self, unit)
		self.Health:SetAllPoints()

		addon.elements.Power(self, unit)
		self.Power:SetPoint('BOTTOMLEFT')
		self.Power:SetPoint('BOTTOMRIGHT')
		self.Power:SetHeight(4)
		self.Power:SetStatusBarColor(unpack(self.colors.power.MANA))
		self.Power.Override = UpdatePower

		local name = addon.elements.Text(self.Health)
		self:Tag(name, '[AelUI:name]')
		name:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 4, -6)

		addon.elements.Leader(self, unit)
		self.LeaderIndicator:SetParent(self.Health)
		self.LeaderIndicator:SetPoint('LEFT', name, 'RIGHT', 4, -2)

		self.Range = {
			insideAlpha = 1,
			outsideAlpha = .5,
		}
	end,
}
