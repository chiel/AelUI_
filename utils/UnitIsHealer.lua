local addon = select(2, ...)

local healerClasses = {
	DRUID = true,
	MONK = true,
	PALADIN = true,
	PRIEST = true,
	SHAMAN = true,
}

function addon.utils.UnitIsHealer(unit)
	if not UnitIsConnected(unit) or UnitHasVehicleUI(unit) then
		return false
	end

	local _, class = UnitClass(unit)
	if not healerClasses[class] then
		return false
	end

	local hasMana = UnitPowerType(unit) == Enum.PowerType.Mana
	if not hasMana then
		return false
	end

	local role = UnitGroupRolesAssigned(unit)
	if role == 'HEALER' then
		return true
	end

	local maxPower = UnitPowerMax(unit, Enum.PowerType.Mana)
	if maxPower >= 10000 then
		return true
	end

	return false
end
