local addon = select(2, ...)

local playerClass = select(2, UnitClass('player'))

local buffsPerClass = {
	DRUID = {
		[33763]  = { color = {48 / 255, 128 / 255, 56 / 255},  position = {'RIGHT', -9, 0} },   -- Lifebloom
		[774]    = { color = {199 / 255, 39 / 255, 190 / 255}, position = {'RIGHT', -26, 0} },  -- Rejuvenation
		[8936]   = { color = {43 / 244, 176 / 255, 160 / 255}, position = {'RIGHT', -44, 0} },  -- Regrowth
		[48438]  = { color = {83 / 255, 218 / 255, 137 / 255}, position = {'RIGHT', -62, 0} },  -- Wild Growth
		[102351] = { color = {184 / 255, 242 / 255, 122 / 255}, position = {'RIGHT', -80, 0} }, -- Cenarion Ward
	},
	MONK = {
		[115175] = { color = {1, 1, 1}, position = {'RIGHT', -26, 0} }, -- Soothing Mist
		[198533] = { color = {1, 1, 1}, position = {'RIGHT', -9, 0} },  -- Soothing Mist (statue)
		[119611] = { color = {1, 1, 1}, position = {'RIGHT', -44, 0} }, -- Renewing Mist
		[124682] = { color = {1, 1, 1}, position = {'RIGHT', -62, 0} }, -- Enveloping Mist
		[191840] = { color = {1, 1, 1}, position = {'RIGHT', -80, 0} }, -- Essence Font
	},
}

local classBuffs = buffsPerClass[playerClass] or {}

local function CustomFilter(_, _, _, _, _, _, _, _, _, caster, _, _, spellID, _, _, casterIsPlayer)
	return casterIsPlayer and classBuffs[spellID]
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
	local name, _, _, _, _, _, _, _, _, spellID, _, _, casterIsPlayer = UnitAura(unit, index)
	local def = classBuffs[spellID]
	if not def or not casterIsPlayer then return end

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

addon.units.party = {
	spawn = function(self)
		local party = self:SpawnHeader(
			nil, nil, 'party',
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

		addon.elements.GroupRole(self, unit)
		self.GroupRoleIndicator:SetParent(self.Health)
		self.GroupRoleIndicator:SetPoint('RIGHT', self.Health, 'TOPRIGHT', -4, 0)

		local buffs = CreateFrame('Frame', nil, self)
		buffs:SetAllPoints()
		buffs.size = 12
		buffs.CustomFilter = CustomFilter
		buffs.PostCreateIcon = PostCreateIcon
		buffs.PostUpdateIcon = PostUpdateIcon
		buffs.SetPosition = SetPosition
		self.Buffs = buffs

		local debuffs = CreateFrame('Frame', nil, self)
		debuffs:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', -1, -5)
		debuffs:SetSize((20 + 4) * 10, 20)
		debuffs.size = 20
		debuffs.spacing = 4
		debuffs.initialAnchor = 'TOPLEFT'
		debuffs['growth-x'] = 'RIGHT'
		self.Debuffs = debuffs

		self.Range = {
			insideAlpha = 1,
			outsideAlpha = .5,
		}
	end,
}
