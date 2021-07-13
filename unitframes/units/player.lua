local addon = select(2, ...)

local playerClass = select(2, UnitClass('player'))

local classResourceMap = {
	DEATHKNIGHT = { BLOOD = true, FROST = true, UNHOLY = true },
	DEMONHUNTER = { VENGEANCE = true },
	MAGE = { ARCANE = true,  },
	MONK = { WINDWALKER = true },
	PALADIN = { HOLY = true, PROTECTION = true, RETRIBUTION = true },
	ROGUE = { ASSASSINATION = true, OUTLAW = true, SUBTLETY = true },
	WARLOCK = { AFFLICTION = true, DEMONOLOGY = true, DESTRUCTION = true },
}

local updateClassResources = function(self, unit)
	local playerSpec = addon.utils.GetSpecName()
	local hasClassResources = (classResourceMap[playerClass] and classResourceMap[playerClass][playerSpec])
		or (classResourceMap[playerClass] and playerSpec == '')

	if playerClass == 'DRUID' and GetShapeshiftForm() == 2 then
		hasClassResources = true
	end

	if hasClassResources then
		-- self.Power:SetPoint('TOP', UIParent, 'CENTER', 0, -306)
		self.Power:SetHeight(8)
	else
		-- self.Power:SetPoint('TOP', UIParent, 'CENTER', 0, -300)
		self.Power:SetHeight(16)
	end
end

table.insert(addon.units, {
	unit = 'player',

	spawn = function(self)
		local f = self:Spawn('player', 'AelUIPlayerFrame')
		f:SetSize(300, 42)
		f:SetPoint('TOPRIGHT', UIParent, 'CENTER', -187, -163)

		local ff = CreateFrame('Frame')
		ff:RegisterEvent('PLAYER_ENTERING_WORLD')
		ff:SetScript('OnEvent', function()
			local waRegion = WeakAuras.GetRegion('Class - '..playerClass..' - Primary')
			if not waRegion then
				return
			end

			f:ClearAllPoints()
			f:SetPoint('TOPRIGHT', waRegion, 'TOPLEFT', -21, -1)
		end)
	end,

	style = function(self, unit)
		self:RegisterForClicks('AnyUp')
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = addon.colors

		addon.elements.Health(self, unit)
		self.Health:SetAllPoints()

		local tx = self.Health:CreateTexture()
		tx:SetTexture(addon.media.textureStriped, "REPEAT")
		local absorbBar = CreateFrame('StatusBar', nil, self.Health)
		absorbBar:SetStatusBarTexture(tx)
		absorbBar:SetAllPoints()

		self.HealthPrediction = {
			absorbBar = absorbBar,
			maxOverflow = 2,
		}
		-- absorbBar:SetPoint('TOP')
		-- absorbBar:SetPoint('BOTTOM')
		-- absorbBar:SetPoint('LEFT')

		addon.elements.Power(self, unit, 'AelUIPlayerPowerBar')
		self.Power:SetSize(298, 12)
		-- self.Power:SetPoint('TOP', UIParent, 'CENTER', 0, -200)

		local ff = CreateFrame('Frame')
		ff:RegisterEvent('PLAYER_ENTERING_WORLD')
		ff:SetScript('OnEvent', function()
			local waRegion = WeakAuras.GetRegion('Class - '..playerClass..' - Primary')
			if not waRegion then return end

			self.Power:ClearAllPoints()
			self.Power:SetPoint('BOTTOMLEFT', waRegion, 'TOPLEFT', 1, 3)
			self.Power:SetPoint('BOTTOMRIGHT', waRegion, 'TOPRIGHT', -1, 3)
		end)

		-- addon.elements.Castbar(self, unit)
		-- self.Castbar:SetPoint('TOP', UIParent, 'CENTER', 0, -318)
		-- self.Castbar:SetSize(298, 12)

		local name = addon.elements.Text(self.Health)
		self:Tag(name, '[AelUI:name]')
		name:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 4, -6)

		addon.elements.Leader(self, unit)
		self.LeaderIndicator:SetParent(self.Health)
		self.LeaderIndicator:SetPoint('LEFT', name, 'RIGHT', 4, -2)

		local healthPercent = addon.elements.Text(self.Health, { size = 18 })
		self:Tag(healthPercent, '[AelUI:healthpercent]')
		healthPercent:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -2, -4)

		local healthText = addon.elements.Text(self.Health, { size = 14 })
		self:Tag(healthText, '[AelUI:health]')
		healthText:SetPoint('BOTTOMRIGHT', healthPercent, 'TOPRIGHT', 0, 0)

		local powerText = addon.elements.Text(self.Power, { size = 18 })
		self:Tag(powerText, '[AelUI:power]')
		powerText:SetJustifyH('CENTER')
		powerText:SetPoint('BOTTOM', self.Power, 'BOTTOM', 0, -1)

		local powerTextShown = true
		local _, powerType = UnitPowerType('player')
		if powerType == 'MANA' then
			powerText:Hide()
			powerTextShown = false
		end

		self.Power.PostUpdate = function()
			local _, powerType = UnitPowerType('player')
			if powerType == 'MANA' then
				if powerTextShown then
					powerText:Hide()
					powerTextShown = false
				end
				return
			end

			if not powerTextShown then
				powerText:Show()
				powerTextShown = true
			end
		end

		addon.elements.ClassPower(self, unit)
		-- self.ClassPower.container:SetSize(298, 5)
		-- self.ClassPower.container:SetPoint('TOP', UIParent, 'CENTER', 0, -300)
		self.ClassPower.container:ClearAllPoints()
		self.ClassPower.container:SetHeight(7)
		self.ClassPower.container:SetPoint('BOTTOMLEFT', self.Power, 'TOPLEFT', 0, 1)
		self.ClassPower.container:SetPoint('BOTTOMRIGHT', self.Power, 'TOPRIGHT', 0, 1)

		if playerClass == 'DEATHKNIGHT' then
			addon.elements.Runes(self, unit)
			self.Runes.container:ClearAllPoints()
			self.Runes.container:SetHeight(7)
			self.Runes.container:SetPoint('BOTTOMLEFT', self.Power, 'TOPLEFT', 0, 1)
			self.Runes.container:SetPoint('BOTTOMRIGHT', self.Power, 'TOPRIGHT', 0, 1)
			-- self.runesFrame:SetPoint('TOP', UIParent, 'CENTER', 0, -300)
			-- self.runesFrame:SetSize(298, 5)
		end

		updateClassResources(self, unit)

		local f = CreateFrame('Frame')
		f:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED')
		f:RegisterEvent('UPDATE_SHAPESHIFT_FORM')
		f:SetScript('OnEvent', function(_, event, u, ...)
			if event == 'UPDATE_SHAPESHIFT_FORM' or (event == 'PLAYER_SPECIALIZATION_CHANGED' and u == 'player') then
				updateClassResources(self, unit)
			end
		end)

		-- self.Power:HookScript('OnSizeChanged', function()
		-- 	print('SIZE CHANGED')
		-- end)
	end,
})
