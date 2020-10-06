local addon = select(2, ...)

addon.elements.Text = function(parent, options)
	local options = options or {}
	options.pixel = options.pixel or false
	options.size = options.size or 20

	local font = options.pixel and addon.media.fontPixel or addon.media.font
	local flags = options.pixel and 'MONOCHROME,OUTLINE' or 'OUTLINE'

	local Text = parent:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
	Text:SetFont(font, options.size, flags)
	Text:SetTextColor(1, 1, 1)

	return Text
end
