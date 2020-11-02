local addon = select(2, ...)

local buffsPerClass = {
	DRUID = {
		[8936]   = { color = {43 / 244, 176 / 255, 160 / 255}, position = {'TOP', 22, -3} },  -- Regrowth
		[774]    = { color = {199 / 255, 39 / 255, 190 / 255}, position = {'TOP', 11, -3} },  -- Rejuvenation
		[33763]  = { color = {48 / 255, 128 / 255, 56 / 255},  position = {'TOP', 0, -3} },   -- Lifebloom
		[48438]  = { color = {83 / 255, 218 / 255, 137 / 255}, position = {'TOP', -11, -3} },  -- Wild Growth
		[102351] = { color = {184 / 255, 242 / 255, 122 / 255}, position = {'TOP', -22, -3} }, -- Cenarion Ward
	},
	MONK = {
		[115175] = { color = {1, 1, 1}, position = {'RIGHT', -26, 0} }, -- Soothing Mist
		[198533] = { color = {1, 1, 1}, position = {'RIGHT', -9, 0} },  -- Soothing Mist (statue)
		[119611] = { color = {1, 1, 1}, position = {'RIGHT', -44, 0} }, -- Renewing Mist
		[124682] = { color = {1, 1, 1}, position = {'RIGHT', -62, 0} }, -- Enveloping Mist
		[191840] = { color = {1, 1, 1}, position = {'RIGHT', -80, 0} }, -- Essence Font
	},
}

local playerClass = select(2, UnitClass('player'))
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

local function Position(raid)
	local isHealer = addon.utils.IsHealerSpec(addon.utils.GetSpecName())

	for i = 1, NUM_RAID_GROUPS do
		raid[i]:ClearAllPoints();

		if isHealer then
			if i == 1 then
				raid[i]:SetPoint('TOPRIGHT', UIParent, 'CENTER', -596, 200)
			else
				raid[i]:SetPoint('TOPRIGHT', raid[i - 1], 'TOPLEFT', -8, 0)
			end
		else
			if i == 1 then
				raid[i]:SetPoint('TOPLEFT', UIParent, 'BOTTOMLEFT', 620, ((56 + 8) * 5))
			else
				raid[i]:SetPoint('TOPLEFT', raid[i - 1], 'TOPRIGHT', 8, 0)
			end
		end
	end
end

addon.units.raid = {
	spawn = function(self)
		local spec = addon.utils.GetSpecName()
		local isHealer = addon.utils.IsHealerSpec(spec)
		local width = isHealer and 80 or 68
		local height = isHealer and 66 or 56

		local raid = {}
		for i = 1, NUM_RAID_GROUPS do
			raid[i] = self:SpawnHeader(
				nil, nil, 'raid',
				'showPlayer', true,
				'showRaid', true,
				'maxColumns', 1,
				'unitsPerColumn', 5,
				'yOffset', -8,
				'groupFilter', i,
				'groupBy', 'ASSIGNEDROLE',
				'groupingOrder', 'TANK,HEALER,DAMAGER',
				'oUF-initialConfigFunction', ([[
					self:SetWidth(%d)
					self:SetHeight(%d)
				]]):format(width, height)
			)
		end

		Position(raid)

		local f = CreateFrame('Frame')
		f:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED')
		f:SetScript('OnEvent', function(_, event)
			if event == 'PLAYER_SPECIALIZATION_CHANGED' then
				Position(raid)
			end
		end)
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

		local buffs = CreateFrame('Frame', nil, self)
		buffs:SetAllPoints()
		buffs.size = 6
		buffs.CustomFilter = CustomFilter
		buffs.PostCreateIcon = PostCreateIcon
		buffs.PostUpdateIcon = PostUpdateIcon
		buffs.SetPosition = function() end
		self.Buffs = buffs

		local text = addon.elements.Text(self.Health, { size = 16 })
		self:Tag(text, '[AelUI:raidtext]')
		text:SetPoint('BOTTOM', self, 'BOTTOM', 0, 12)

		addon.elements.GroupRole(self, unit)
		self.GroupRoleIndicator:SetParent(self.Health)
		self.GroupRoleIndicator:SetPoint('TOPLEFT', 4, -4)

		self.Range = {
			insideAlpha = 1,
			outsideAlpha = .5,
		}
	end,
}
