local addon = select(2, ...)

local function UpdateGroupPower(self, event, unit)
	if(unit ~= self.unit) then
		return
	end

	local element = self.Power
	local visibility = false

	if UnitIsConnected(unit) and not UnitHasVehicleUI(unit) then
		local role = UnitGroupRolesAssigned(unit)
		visibility = role == 'HEALER' and UnitPowerType(unit) == Enum.PowerType.Mana
	end

	if visibility then
		self.Health:SetPoint('BOTTOM', 0, 5)
		element:SetMinMaxValues(0, UnitPowerMax(unit, Enum.PowerType.Mana))
		element:SetValue(UnitPower(unit, Enum.PowerType.Mana))
	else
		self.Health:SetPoint('BOTTOM', 0, 0)
	end

	element:SetShown(visibility)
end

addon.units.party = {
	spawn = function(self)
		local party = self:SpawnHeader(
			'aelUI_party', nil, 'party',
			'showParty', true,
			'showPlayer', true,
			'yOffset', -24,
			'groupBy', 'ASSIGNEDROLE',
			'groupingOrder', 'TANK,HEALER,DAMAGER',
			'oUF-initialConfigFunction', [[
				self:SetWidth(250)
				self:SetHeight(30)
			]]
		)

		party:SetPoint('TOPRIGHT', UIParent, 'CENTER', -596, 90)
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
		self.Power.Override = UpdateGroupPower

		local name = addon.elements.Text(self.Health)
		self:Tag(name, '[AelUI:name]')
		name:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 4, -6)

		self.Range = {
			insideAlpha = 1,
			outsideAlpha = .6,
		}
	end,
}
