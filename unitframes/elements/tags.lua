local addon = select(2, ...)

oUF.Tags.Events['AelUI:name'] = 'UNIT_NAME_UPDATE UNIT_CONNECTION UNIT_FACTION'
oUF.Tags.Methods['AelUI:name'] = function(unit)
	local name = UnitName(unit)
	local color
	if UnitIsPlayer(unit) then
		local class, classfn = UnitClass(unit)
		if name and name ~= 'Unknown' and classfn then
			color = addon.colors.class[classfn]
		end
	else
		color = addon.colors.reaction[UnitReaction(unit, 'player')]
	end

	if color then
		return addon.utils.Hex(color)..name
	end
	return name
end
