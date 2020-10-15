local addon = select(2, ...)

local playerClass = select(2, UnitClass('player'))

local classResourceMap = {
	DEATHKNIGHT = { BLOOD = true, FROST = true, UNHOLY = true },
	MAGE = { ARCANE = true,  },
	MONK = { WINDWALKER = true },
	PALADIN = { HOLY = true },
	ROGUE = { ASSASSINATION = true, OUTLAW = true, SUBTLETY = true },
	WARLOCK = { AFFLICTION = true, DEMONOLOGY = true, DESTRUCTION = true },
}

local updateClassResources = function(self, unit)
	local playerSpec = addon.utils.GetSpecName()
	local hasClassResources = classResourceMap[playerClass]
		and classResourceMap[playerClass][playerSpec]

	if hasClassResources then
		self.Power:SetPoint('TOP', UIParent, 'CENTER', 0, -306)
		self.Power:SetHeight(6)
	else
		self.Power:SetPoint('TOP', UIParent, 'CENTER', 0, -300)
		self.Power:SetHeight(12)
	end
end

addon.units.player = {
	spawn = function(self)
		local f = self:Spawn('player')
		f:SetSize(300, 30)
		f:SetPoint('TOPRIGHT', UIParent, 'CENTER', -191, -300)
	end,

	style = function(self, unit)
		self:RegisterForClicks('AnyUp')
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = addon.colors

		addon.elements.Health(self, unit)
		self.Health:SetAllPoints()

		addon.elements.Power(self, unit)
		self.Power:SetWidth(298)

		addon.elements.Castbar(self, unit)
		self.Castbar:SetPoint('TOP', UIParent, 'CENTER', 0, -318)
		self.Castbar:SetSize(298, 12)

		local name = addon.elements.Text(self.Health)
		self:Tag(name, '[AelUI:name]')
		name:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 4, -6)

		addon.elements.Leader(self, unit)
		self.LeaderIndicator:SetParent(self.Health)
		self.LeaderIndicator:SetPoint('LEFT', name, 'RIGHT', 4, -2)

		local powerText = addon.elements.Text(self.Power)
		self:Tag(powerText, '[AelUI:power]')
		powerText:SetJustifyH('CENTER')
		powerText:SetPoint('BOTTOM', self.Power, 'BOTTOM', 0, -4)
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
		self.ClassPower.container:SetSize(298, 5)
		self.ClassPower.container:SetPoint('TOP', UIParent, 'CENTER', 0, -300)

		if playerClass == 'DEATHKNIGHT' then
			addon.elements.Runes(self, unit)
			self.runesFrame:SetPoint('TOP', UIParent, 'CENTER', 0, -300)
			self.runesFrame:SetSize(298, 5)
		end

		updateClassResources(self, unit)

		local f = CreateFrame('Frame')
		f:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED')
		f:SetScript('OnEvent', function(_, event, u)
			if event == 'PLAYER_SPECIALIZATION_CHANGED' and u == 'player' then
				updateClassResources(self, unit)
			end
		end)
	end,
}
