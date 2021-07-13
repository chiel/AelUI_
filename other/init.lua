-- print('OTHER', AelUIPlayerFrame, AelUIPetFrame)

local f = CreateFrame('Frame', 'AelUIConsumablesAnchor', UIParent)
f:SetSize(1, 1)
f:SetPoint('CENTER', UIParent, 'CENTER', 0, 0)
f:RegisterEvent('PLAYER_ENTERING_WORLD')
f:RegisterEvent('UNIT_PET')
f:SetScript('OnEvent', function(self, event, unit)
	if event == 'UNIT_PET' and unit ~= 'player' then
		return
	end

	local anchorFrame = AelUIPlayerFrame
	if UnitExists('pet') then
		anchorFrame = AelUIPetFrame
	end

	f:ClearAllPoints()
	f:SetPoint('TOPLEFT', anchorFrame, 'BOTTOMLEFT', 0, 0)
end)
