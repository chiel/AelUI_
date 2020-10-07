local addon = select(2, ...)

function addon.utils.UnitColor(unit)
	if not UnitIsConnected(unit) or UnitIsDeadOrGhost(unit) then
		return addon.colors.disconnected
	end

	if not UnitPlayerControlled(unit) and UnitIsTapDenied(unit) then
		return addon.colors.tapped
	end

	if UnitIsPlayer(unit) then
		local _, class = UnitClass(unit)
		return addon.colors.class[class]
	end

	return addon.colors.reaction[UnitReaction(unit, 'player')]
end
