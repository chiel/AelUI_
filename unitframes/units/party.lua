local addon = select(2, ...)

local playerClass = select(2, UnitClass('player'))

local debuffColors = {}
for debuffType, color in next, DebuffTypeColor do
	debuffColors[string.upper(debuffType)] = { color.r, color.g, color.b }
end

-- local buffWhitelist = {
-- 	-- monk
-- 	[115203] = true, -- Fortifying Brew
-- 	[115176] = true, -- Zen Meditation
--
-- 	-- paladin
-- 	[31884]  = true, -- Avenging Wrath
-- 	[1022]   = true, -- Blessing of Protection
-- 	[1044]   = true, -- Blessing of Freedom
-- 	[6940]   = true, -- Blessing of Sacrifice
-- 	[642]    = true, -- Divine Shield
--
-- 	-- warrior
-- 	[107574] = true, -- Avatar
-- 	[12975]  = true, -- Last Stand
-- 	[97462]  = true, -- Rallying Cry
-- 	[871]    = true, -- Shield Wall
--
-- 	-- trinkets
-- 	[314858] = true, -- Psychic Shell
-- }

local buffsPerClass = {
	DRUID = {
		[33763]  = { color = {48 / 255, 128 / 255, 56 / 255},  position = {'RIGHT', -9, 0} },   -- Lifebloom
		[774]    = { color = {199 / 255, 39 / 255, 190 / 255}, position = {'RIGHT', -26, 0} },  -- Rejuvenation
		[8936]   = { color = {43 / 244, 176 / 255, 160 / 255}, position = {'RIGHT', -44, 0} },  -- Regrowth
		[48438]  = { color = {83 / 255, 218 / 255, 137 / 255}, position = {'RIGHT', -62, 0} },  -- Wild Growth
		[102351] = { color = {184 / 255, 242 / 255, 122 / 255}, position = {'RIGHT', -80, 0} }, -- Cenarion Ward
		-- [155777] = { color = {165 / 255, 23 / 255, 157 / 255}, position = {'RIGHT', -44, 0} },  -- Rejuvenation (Germination)
	},
	MONK = {
		[115175] = { color = {1, 1, 1}, position = {'RIGHT', -26, 0} }, -- Soothing Mist
		[198533] = { color = {1, 1, 1}, position = {'RIGHT', -9, 0} },  -- Soothing Mist (statue)
		[119611] = { color = {1, 1, 1}, position = {'RIGHT', -44, 0} }, -- Renewing Mist
		[124682] = { color = {1, 1, 1}, position = {'RIGHT', -62, 0} }, -- Enveloping Mist
		[191840] = { color = {1, 1, 1}, position = {'RIGHT', -80, 0} }, -- Essence Font
	},
	-- SHAMAN = {
	-- 	[129934] = { color = {1, 1, 1}, position = {'RIGHT', -80, 0} },
	-- },
}

local classDebuffPrio = {
	DRUID = { 'CURSE', 'POISON', 'DISEASE', 'MAGIC' },
	MAGE = { 'CURSE', 'MAGIC', 'CURSE', 'POISON' },
	MONK = { 'DISEASE', 'POISON', 'MAGIC', 'CURSE' },
	PALADIN = { 'DISEASE', 'POISON', 'MAGIC', 'CURSE' },
	PRIEST = { 'DISEASE', 'MAGIC', 'POISON', 'CURSE' },
	SHAMAN = { 'CURSE', 'POISON', 'DISEASE', 'MAGIC' },
}

local classBuffs = buffsPerClass[playerClass] or {}

local debuffPrio = classDebuffPrio[playerClass] or { 'MAGIC', 'DISEASE', 'POISON', 'CURSE' }

local function CustomFilter(_, _, _, _, _, _, _, _, _, caster, _, _, spellID)
	return caster == 'player' and classBuffs[spellID]
end

local function PostCreateIcon(element, button)
	button.cd:SetDrawEdge(false)
	button.cd:SetReverse(true)
	button.cd:SetSwipeColor(0, 0, 0, .8)
	button.cd:SetHideCountdownNumbers(true)

	local border = CreateFrame('Frame', nil, button, 'BackdropTemplate')
	border:SetBackdrop({ edgeFile = addon.media.border, edgeSize = 1 })
	border:SetBackdropBorderColor(0, 0, 0, 1)
	border:SetPoint('TOPLEFT', -1, 1)
	border:SetPoint('BOTTOMRIGHT', 1, -1)
	button.border = border
end

local function PostUpdateIcon(self, unit, button, index, position, duration, expiration, debuffType, isStealable)
	local name, _, _, _, _, _, caster, _, _, spellID, _, _, casterIsPlayer = UnitAura(unit, index)
	local def = classBuffs[spellID]
	if not def or not caster == 'player' then return end

	button:ClearAllPoints()
	button:SetPoint(unpack(def.position))

	if not def.showIcon then
		button.icon:SetTexture(addon.media.textureBg)
		button.icon:SetVertexColor(unpack(def.color))
	end
end

local function SetPosition(element, from, to)
end

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

local function UpdateBorder(self, event, unit)
	if UnitIsUnit(self.unit, 'target') then
		self.Border:SetBackdropBorderColor(1, 1, 1, .75)
		return
	end

	if debuffPrio ~= nil then
		local debuffTypes = {
			CURSE   = false,
			DISEASE = false,
			MAGIC   = false,
			POISON  = false,
		}

		local i = 1
		while (i < 100) do
			local name, _, _, debuffType = UnitAura(self.unit, i, 'HARMFUL')
			if not name then break end

			if debuffType then
				debuffTypes[string.upper(debuffType)] = true
			end

			i = i + 1
		end

		for _, debuffType in pairs(debuffPrio) do
			if debuffTypes[debuffType] then
				c = debuffColors[debuffType]
				self.Border:SetBackdropBorderColor(c[1], c[2], c[3], .75)
				return
			end
		end
	end

	self.Border:SetBackdropBorderColor(0, 0, 0, 0)
end

table.insert(addon.units, {
	unit = 'party',

	spawn = function(self)
		local width = 250
		local height = 30
		-- local height = 42
		local spacing = 32
		local x = -81
		local y = (height * 5) + (spacing * 6)

		local party = self:SpawnHeader(
			'AelUIPartyFrame', nil, 'party',
			-- 'showSolo', true, -- debug
			'showParty', true,
			'showPlayer', true,
			-- 'point', 'LEFT',
			'yOffset', -spacing,
			'groupBy', 'ASSIGNEDROLE',
			'groupingOrder', 'TANK,HEALER,DAMAGER',
			'oUF-initialConfigFunction', ([[
				self:SetWidth(%d)
				self:SetHeight(%d)
			]]):format(width, height)
		)

		party:SetPoint('TOPRIGHT', AelUIPlayerFrame, 'TOPLEFT', x, y)
	end,

	style = function(self, unit)
		self:RegisterForClicks('AnyUp')
		self:SetScript('OnEnter', UnitFrame_OnEnter)
		self:SetScript('OnLeave', UnitFrame_OnLeave)

		self.colors = addon.colors

		addon.elements.Health(self, unit)
		self.Health:SetAllPoints()

		self.Border = addon.elements.Border(self, 2)
		self:RegisterEvent('PLAYER_TARGET_CHANGED', UpdateBorder, true)
		self:RegisterEvent('GROUP_ROSTER_UPDATE', UpdateBorder, true)

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

		addon.elements.GroupRole(self, unit)
		self.GroupRoleIndicator:SetParent(self.Health)
		self.GroupRoleIndicator:SetPoint('RIGHT', self.Health, 'TOPRIGHT', -4, 0)

		local buffs = CreateFrame('Frame', nil, self)
		buffs:SetAllPoints()
		-- buffs:SetPoint('RIGHT', -8, 0)
		-- buffs:SetSize((16 + 8) * 8, 16)
		-- buffs.numBuffs = 6
		buffs.size = 12
		-- buffs.spacing = 8
		-- buffs.initialAnchor = 'BOTTOMRIGHT'
		-- buffs['growth-x'] = 'LEFT'
		buffs.CustomFilter = CustomFilter
		buffs.PostCreateIcon = PostCreateIcon
		buffs.PostUpdateIcon = PostUpdateIcon
		buffs.SetPosition = SetPosition
		self.Buffs = buffs

		local debuffs = CreateFrame('Frame', nil, self)
		debuffs:SetPoint('TOPLEFT', self, 'TOPRIGHT', 5, 1)
		debuffs:SetSize(32 * 10, 32)
		debuffs.size = 32
		-- debuffs:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', -1, -5)
		-- debuffs:SetSize((20 + 4) * 10, 20)
		-- debuffs.size = 20
		debuffs.spacing = 2
		debuffs.initialAnchor = 'TOPLEFT'
		debuffs['growth-x'] = 'RIGHT'

		debuffs.PostUpdate = function()
			UpdateBorder(self)
		end

		self.Debuffs = debuffs

		self.Range = {
			insideAlpha = 1,
			outsideAlpha = .5,
		}
	end,
})
