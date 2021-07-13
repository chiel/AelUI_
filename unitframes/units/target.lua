local addon = select(2, ...)

local playerClass = select(2, UnitClass('player'))

-- local buffBlacklist = {
-- 	[186403] = true, -- Sign of Battle
-- 	[264408] = true, -- Soldier of the Horde
-- 	[269083] = true, -- Enlisted
-- }

-- local classDebuffPrio = {
-- 	MONK = { 'DISEASE', 'POISON', 'MAGIC', 'CURSE' },
-- 	SHAMAN = { 'CURSE', 'POISON', 'DISEASE', 'MAGIC' },
-- }
--
-- local debuffColors = {}
-- for debuffType, color in next, DebuffTypeColor do
-- 	debuffColors[string.upper(debuffType)] = { color.r, color.g, color.b }
-- end
--
-- local debuffPrio = classDebuffPrio[playerClass]
--
-- local function UpdateBorder(self, unit)
-- 	local self = element.__owner
--
-- 	local debuffTypes = {
-- 		CURSE   = false,
-- 		DISEASE = false,
-- 		MAGIC   = false,
-- 		POISON  = false,
-- 	}
--
-- 	local index = 1
-- 	while (index < 100) do
-- 		local _, _, _, debuffType = UnitAura(unit, index, 'HARMFUL')
-- 		if not debuffType then break end
-- 		debuffTypes[string.upper(debuffType)] = true
--
-- 		index = index + 1
-- 	end
--
-- 	local c = { 1, 1, 1 }
-- 	local setColor = false
-- 	for _, debuffType in pairs(debuffPrio) do
-- 		if debuffTypes[debuffType] then
-- 			c = debuffColors[debuffType]
-- 			break
-- 		end
-- 	end
--
-- 	self.Border:SetBackdropBorderColor(c[1], c[2], c[3], .75)
-- end

table.insert(addon.units, {
	unit = 'target',

	spawn = function(self)
		local f = self:Spawn('target', 'AelUITargetFrame')
		f:SetSize(300, 42)
		f:SetPoint('TOPLEFT', UIParent, 'CENTER', 187, -163)

		local ff = CreateFrame('Frame')
		ff:RegisterEvent('PLAYER_ENTERING_WORLD')
		ff:SetScript('OnEvent', function()
			local waRegion = WeakAuras.GetRegion('Class - '..playerClass..' - Primary')
			if not waRegion then
				return
			end

			f:ClearAllPoints()
			f:SetPoint('TOPLEFT', waRegion, 'TOPRIGHT', 21, -1)
		end)
	end,

	style = function(self, unit)
		self:RegisterForClicks('AnyUp')
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = addon.colors

		addon.elements.Health(self, unit)
		self.Health:SetAllPoints()

		-- addon.elements.Castbar(self, unit)
		-- self.Castbar:SetPoint('TOP', UIParent, 'CENTER', 0, -140)
		-- self.Castbar:SetSize(298, 12)
		-- self.Castbar.Icon:ClearAllPoints()
		-- self.Castbar.Icon:SetPoint('TOPRIGHT', self.Castbar, 'TOPLEFT', -5, 1)

		local buffs = CreateFrame('Frame', nil, self)
		-- buffs.CustomFilter = function(_, _, _, _, _, _, _, _, _, _, _, _, spellID)
		-- 	if buffBlacklist[spellID] then
		-- 		return false
		-- 	end
    --
		-- 	return true
		-- end
		-- buffs.PostUpdateIcon = function(element, unit, button, index)
		-- 	-- print(unit, button, index)
		-- 	local name, _, _, debuffType = UnitAura(unit, index, 'HELPFUL')
		-- 	print(name, debuffType)
		-- end

		-- self.Border = addon.elements.Border(self)
		-- self.Border:SetBackdropBorderColor(1, 1, 1, .5)
		-- buffs.PostUpdate = UpdateBorder

		buffs.size = 24
		buffs.spacing = 2
		buffs:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', -1, 3)
		buffs:SetSize(32 * 4, 32 * 4)
		self.Buffs = buffs

		-- local debuffs = CreateFrame('Frame', nil, self)
		-- debuffs.size = 24
		-- debuffs.spacing = 4
		-- debuffs:SetPoint('BOTTOMLEFT', self.Buffs, 'TOPLEFT', 0, 0)
		-- debuffs:SetSize(32 * 4, 32 * 4)
		-- self.Debuffs = debuffs

		local name = addon.elements.Text(self.Health)
		self:Tag(name, '[AelUI:name]')
		name:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -4, -6)

		local healthPercent = addon.elements.Text(self.Health, { size = 18 })
		self:Tag(healthPercent, '[AelUI:healthpercent]')
		healthPercent:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', 3, -4)

		local healthText = addon.elements.Text(self.Health, { size = 14 })
		self:Tag(healthText, '[AelUI:health]')
		healthText:SetPoint('BOTTOMLEFT', healthPercent, 'TOPLEFT', 0, 0)

		addon.elements.RaidTarget(self, unit)
		self.RaidTargetIndicator:SetParent(self.Health)
		self.RaidTargetIndicator:SetPoint('CENTER', self.Health)
	end,
})
