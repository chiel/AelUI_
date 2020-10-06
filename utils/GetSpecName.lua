local addon = select(2, ...)

addon.utils.GetSpecName = function()
	local specIndex = GetSpecialization()
	return string.upper(specIndex and select(2, GetSpecializationInfo(specIndex)) or 'None')
end
