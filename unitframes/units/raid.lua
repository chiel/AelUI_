print("AelUI: unitframes/units/raid.lua")
local addon = select(2, ...)

addon.units.raid = {
	spawn = function(self)
		local raidFrame = CreateFrame('Frame', nil, UIParent)
		-- addon.elements.CreateBg(raidFrame)
		-- raidFrame:SetPoint('BOTTOMLEFT', UIParent, 'BOTTOMLEFT', 620, 10)
		raidFrame:SetPoint('BOTTOMLEFT', UIParent, 'CENTER', 0, 0)
		raidFrame:SetSize(200, 200)

		-- local raid = {}
		for i = 1, NUM_RAID_GROUPS do
			-- print('SPAWN GROUP', i)
			local group = self:SpawnHeader(
				'aelUI_raid', nil, 'raid',
				'showSolo', true, -- debug
				'showParty', true, -- debug
				'showRaid', true,
				'showPlayer', true,
				'maxColumn', 1,
				'unitsPerColumn', 5,
				'columnAnchorPoint', 'LEFT',
				'yOffset', -6,
				'groupFilter', i,
				'oUF-initialConfigFunction', [[
					self:SetWidth(70)
					self:SetHeight(58)
				]]
			)

			group:SetParent(raidFrame)
			-- addon.elements.CreateBg(group)
			-- group:SetPoint('BOTTOMLEFT', 0, 0)
			group:SetPoint('BOTTOMLEFT', (90 * (i - 1)), 0)
		end

	end,

	style = function(frame, unit)
		-- print('STYLE', unit, frame.unit, frame)
		-- if unit ~= frame.unit then
		-- 	print('DIFF', unit, frame.unit)
		-- 	return
		-- end

		frame:SetScript('OnEnter', UnitFrame_OnEnter)
		frame:SetScript('OnLeave', UnitFrame_OnLeave)
		frame:RegisterForClicks('AnyUp')

		frame.colors = addon.colors

		-- addon.elements.Base(frame, unit)

		-- addon.elements.Health(frame, unit)
		-- frame.Health:SetPoint('TOPLEFT', 1, -1)
		-- frame.Health:SetPoint('BOTTOMRIGHT', -1, 1)

		-- addon.elements.RaidText(frame, unit)
		-- frame.RaidText:SetPoint('BOTTOM', frame, 'BOTTOM', 0, 12)

		-- local text = addon.elements.Text(frame, unit, { size = 16 })
		-- frame:Tag(text, '[AelUI:raidtext]')
		-- text:SetPoint('BOTTOM', frame, 'BOTTOM', 0, 12)

		-- frame.Range = {
		-- 	insideAlpha = 1,
		-- 	outsideAlpha = .5,
		-- }
	end,
}
