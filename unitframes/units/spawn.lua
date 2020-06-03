print("AelUI: unitframes/units/spawn.lua")
local addon = select(2, ...)

for unit, conf in pairs(addon.units) do
	oUF:RegisterStyle('AelUI:'..unit, conf.style)
end

oUF:Factory(function(self)
	for unit, conf in pairs(addon.units) do
		self:SetActiveStyle('AelUI:'..unit)
		conf.spawn(self)
	end
end)
