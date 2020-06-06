print("AelUI: unitframes/units/player.lua")
local addon = select(2, ...)

addon.units.player = {
	spawn = function(self)
		local player = self:Spawn('player')
		player:SetSize(300, 30)
		player:SetPoint('TOPRIGHT', UIParent, 'CENTER', -192, -300)
	end,

	style = function(frame, unit)
		addon.elements.Base(frame, unit)

		addon.elements.Health(frame, unit)
		frame.Health:SetAllPoints()

		addon.elements.Power(frame, unit)
		frame.Power:SetPoint('TOP', UIParent, 'CENTER', 0, -300)
		frame.Power:SetSize(300, 12)
	end,
}
