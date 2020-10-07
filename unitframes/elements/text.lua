local addon = select(2, ...)

function addon.elements.Text(parent, options)
	local options = options or {}
	options.pixel = options.pixel or false
	options.size = options.size or 20

	local font = options.pixel and addon.media.fontPixel or addon.media.font
	local flags = options.pixel and 'MONOCHROME,OUTLINE' or 'OUTLINE'

	local text = parent:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
	text:SetFont(font, options.size, flags)
	text:SetTextColor(1, 1, 1)

	return text
end
