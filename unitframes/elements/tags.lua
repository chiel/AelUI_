local addon = select(2, ...)

oUF.Tags.Events['AelUI:name'] = 'UNIT_NAME_UPDATE UNIT_CONNECTION UNIT_FACTION'
oUF.Tags.Methods['AelUI:name'] = function(unit)
	local name = UnitName(unit)
	local color = addon.utils.UnitColor(unit)

	if color then
		return addon.utils.Hex(color)..name
	end

	return name
end

oUF.Tags.Events['AelUI:power'] = 'UNIT_DISPLAYPOWER UNIT_MAXPOWER UNIT_POWER_FREQUENT'
oUF.Tags.Methods['AelUI:power'] = function(unit)
	return UnitPower(unit)
end
