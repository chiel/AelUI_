local addon = select(2, ...)

addon.utils.Hex = function(r, g, b)
	if(type(r) == 'table') then
		if(r.r) then
			r, g, b = r.r, r.g, r.b
		else
			r, g, b = unpack(r)
		end
	end

	return string.format('|cff%02x%02x%02x', r * 255, g * 255, b * 255)
end
