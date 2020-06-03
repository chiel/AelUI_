print("AelUI: unitframes/units/player.lua")
local addon = select(2, ...)

addon.units.player = {
	spawn = function(self)
		local player = self:Spawn('player')
		player:SetSize(300, 30)
		player:SetPoint('BOTTOM', UIParent, 'CENTER', 0, -300)
	end,

	style = function(frame, unit)
		addon.elements.Base(frame, unit)

		addon.elements.Health(frame, unit)
		frame.Health:SetPoint('TOPLEFT', 1, -1)
		frame.Health:SetPoint('BOTTOMRIGHT', -1, 1)
	end,
}
