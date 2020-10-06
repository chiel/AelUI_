local addon = select(2, ...)

local playerClass = select(2, UnitClass('player'))

local updateClassResources = function(frame, unit)
	local playerSpec = addon.utils.GetSpecName()
	local hasClassResources = false

	if playerClass == 'DEATHKNIGHT' then
		hasClassResources = true

	elseif playerClass == 'MONK' then
		if playerSpec == 'WINDWALKER' then
			hasClassResources = true

		end
	end

	if hasClassResources then
		frame.Power:SetPoint('TOP', UIParent, 'CENTER', 0, -306)
		frame.Power:SetHeight(6)
	else
		frame.Power:SetPoint('TOP', UIParent, 'CENTER', 0, -300)
		frame.Power:SetHeight(12)
	end
end

addon.units.player = {
	spawn = function(self)
		local frame = self:Spawn('player')
		frame:SetSize(300, 30)
		frame:SetPoint('TOPRIGHT', UIParent, 'CENTER', -191, -300)
	end,

	style = function(frame, unit)
		addon.elements.Base(frame, unit)

		addon.elements.Health(frame, unit)
		frame.Health:SetAllPoints()

		addon.elements.Power(frame, unit)
		frame.Power:SetWidth(298)

		addon.elements.Castbar(frame, unit)
		frame.Castbar:SetPoint('TOP', UIParent, 'CENTER', 0, -318)
		frame.Castbar:SetSize(298, 12)

		local name = addon.elements.Text(frame.Health)
		frame:Tag(name, '[AelUI:name]')
		name:SetPoint('BOTTOMLEFT', frame, 'TOPLEFT', 4, -6)

		local power = addon.elements.Text(frame.Power)
		frame:Tag(power, '[AelUI:power]')
		power:SetJustifyH('CENTER')
		power:SetPoint('BOTTOM', frame.Power, 'BOTTOM', 0, -4)
		local powerTextShown = true

		local _, powerType = UnitPowerType('player')
		if powerType == 'MANA' then
			power:Hide()
			powerTextShown = false
		end

		frame.Power.PostUpdate = function()
			local _, powerType = UnitPowerType('player')
			if powerType == 'MANA' then
				if powerTextShown then
					power:Hide()
					powerTextShown = false
				end
				return
			end

			if not powerTextShown then
				power:Show()
				powerTextShown = true
			end
		end

		addon.elements.ClassPower(frame, unit)
		frame.classPowerFrame:SetSize(298, 5)
		frame.classPowerFrame:SetPoint('TOP', UIParent, 'CENTER', 0, -300)

		if playerClass == 'DEATHKNIGHT' then
			addon.elements.Runes(frame, unit)
			frame.runesFrame:SetPoint('TOP', UIParent, 'CENTER', 0, -300)
			frame.runesFrame:SetSize(298, 5)
		end

		updateClassResources(frame, unit)

		local f = CreateFrame('Frame', nil, UIParent)
		f:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED')
		f:SetScript('OnEvent', function(self, event, u)
			if event == 'PLAYER_SPECIALIZATION_CHANGED' and u == 'player' then
				updateClassResources(frame, unit)
			end
		end)
	end,
}
