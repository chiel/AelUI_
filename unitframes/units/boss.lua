local addon = select(2, ...)

table.insert(addon.units, {
	unit = 'boss',

	spawn = function(self)
		local width = 250
		local height = 30
		-- local height = 42
		local spacing = 32
		local x = 81
		local y = (height * 5) + (spacing * 6)

		local boss = {}
		for i = 1, MAX_BOSS_FRAMES or 5 do
			-- boss[i] = self:Spawn('player')
			-- boss[i] = self:Spawn('target')
			boss[i] = self:Spawn('boss' .. i)
			boss[i]:SetSize(width, height)

			if i == 1 then
				boss[i]:SetPoint('TOPLEFT', AelUITargetFrame, 'TOPRIGHT', x, y)
			else
				boss[i]:SetPoint('TOPLEFT', boss[i - 1], 'BOTTOMLEFT', 0, -spacing)
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

		local nameText = addon.elements.Text(self.Health)
		self:Tag(nameText, '[AelUI:name]')
		nameText:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -4, -6)

		local healthPercent = addon.elements.Text(self.Health, { size = 18 })
		self:Tag(healthPercent, '[AelUI:healthpercent]')
		healthPercent:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', 3, -4)

		-- local healthText = addon.elements.Text(self.Health, { size = 14 })
		-- self:Tag(healthText, '[AelUI:health]')
		-- healthText:SetPoint('BOTTOMLEFT', healthPercent, 'TOPLEFT', 0, 0)

		local debuffs = CreateFrame('Frame', nil, self)
		debuffs:SetPoint('TOPRIGHT', self, 'TOPLEFT', -5, 1)
		debuffs:SetSize(32 * 10, 32)
		debuffs.size = 32
		-- debuffs:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', -1, -5)
		-- debuffs:SetSize((20 + 4) * 10, 20)
		-- debuffs.size = 20
		debuffs.spacing = 2
		debuffs.initialAnchor = 'TOPRIGHT'
		debuffs['growth-x'] = 'LEFT'
		debuffs.onlyShowPlayer = true

		self.Debuffs = debuffs
	end,
})
