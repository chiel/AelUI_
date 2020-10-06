local addon = select(2, ...)

local function UpdateGroupPower(frame, event, unit)
	if(unit ~= frame.unit) then
		return
	end

	local element = frame.Power
	local visibility = false

	if UnitIsConnected(unit) and not UnitHasVehicleUI(unit) then
		local role = UnitGroupRolesAssigned(unit)
		visibility = role == 'HEALER' and UnitPowerType(unit) == Enum.PowerType.Mana
	end

	if visibility then
		frame.Health:SetPoint('BOTTOM', 0, 5)
		element:SetMinMaxValues(0, UnitPowerMax(unit, Enum.PowerType.Mana))
		element:SetValue(UnitPower(unit, Enum.PowerType.Mana))
	else
		frame.Health:SetPoint('BOTTOM', 0, 0)
	end

	element:SetShown(visibility)
end

addon.units.party = {
	spawn = function(self)
		local party = self:SpawnHeader(
			'aelUI_party', nil, 'solo,party',
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

	style = function(frame, unit)
		addon.elements.Base(frame, unit)

		addon.elements.Health(frame, unit)
		frame.Health:SetAllPoints()

		addon.elements.Power(frame, unit)
		frame.Power:SetPoint('BOTTOMLEFT')
		frame.Power:SetPoint('BOTTOMRIGHT')
		frame.Power:SetHeight(4)
		frame.Power:SetStatusBarColor(unpack(frame.colors.power.MANA))
		frame.Power.Override = UpdateGroupPower

		local name = addon.elements.Text(frame.Health)
		frame:Tag(name, '[AelUI:name]')
		name:SetPoint('BOTTOMLEFT', frame, 'TOPLEFT', 4, -6)

		frame.Range = {
			insideAlpha = 1,
			outsideAlpha = .6,
		}
	end,
}
