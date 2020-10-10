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

addon.units.raid = {
	spawn = function(self)
		local y = ((56 + 8) * 5)
		local raid = {}
		for i = 1, NUM_RAID_GROUPS do
			raid[i] = self:SpawnHeader(
				nil, nil, 'raid',
				'showSolo', true,
				'showParty', true,
				'showPlayer', true,
				'showRaid', true,
				'maxColumns', 1,
				'unitsPerColumn', 5,
				'yOffset', -8,
				'groupFilter', i,
				'oUF-initialConfigFunction', [[
					self:SetWidth(68)
					self:SetHeight(56)
				]]
			)

			if (i == 1) then
				raid[i]:SetPoint('TOPLEFT', UIParent, 'BOTTOMLEFT', 620, y)
			else
				raid[i]:SetPoint('TOPLEFT', raid[i - 1], 'TOPRIGHT', 8, 0)
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
		self.Power:SetStatusBarColor(unpack(self.colors.power.MANA))
		self.Power.Override = UpdatePower

		local text = addon.elements.Text(self.Health, { size = 16 })
		self:Tag(text, '[AelUI:raidtext]')
		text:SetPoint('BOTTOM', self, 'BOTTOM', 0, 12)

		self.Range = {
			insideAlpha = 1,
			outsideAlpha = .5,
		}
	end,
}
