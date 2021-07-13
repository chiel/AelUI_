local addon = select(2, ...)

for i, conf in ipairs(addon.units) do
	oUF:RegisterStyle('AelUI:'..conf.unit, conf.style)
end

oUF:Factory(function(self)
	for i, conf in ipairs(addon.units) do
		self:SetActiveStyle('AelUI:'..conf.unit)
		conf.spawn(self)
	end
end)
