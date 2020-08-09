local addon = select(2, ...)

local updateClassResources = function(frame, unit)
	local playerClass = select(2, UnitClass('player'))
	local playerSpec = addon.utils.GetSpecName()
	local hasClassResources = false

	if playerClass == 'DEATHKNIGHT' then
		local runeFrame = addon.elements.Runes(frame, unit)
		runeFrame:SetPoint('TOP', UIParent, 'CENTER', 0, -310)
		runeFrame:SetSize(298, 5)
		hasClassResources = true

	elseif playerClass == 'MONK' then
		if playerSpec == 'BREWMASTER' then
			hasClassResources = true
		end
	end

	if hasClassResources then
		frame.Power:SetPoint('TOP', UIParent, 'CENTER', 0, -316)
		frame.Power:SetHeight(4)
	else
		frame.Power:SetPoint('TOP', UIParent, 'CENTER', 0, -310)
		frame.Power:SetHeight(10)
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
		frame.Castbar:SetPoint('TOP', UIParent, 'CENTER', 0, -326)
		frame.Castbar:SetWidth(298)

		updateClassResources(frame, unit)

		local f = CreateFrame('Frame', nil, UIParent)
		f:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED')
		f:SetScript('OnEvent', function(self, event, u)
			if event == 'PLAYER_SPECIALIZATION_CHANGED' then
				if u == 'player' then
					updateClassResources(frame, unit)
				end
			end
		end)
	end,
}
