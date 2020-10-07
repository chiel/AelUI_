local addon = select(2, ...)

addon.elements = {}

function addon.elements.Backdrop(parent, color)
	r, g, b = unpack(color or {.2, .2, .2})

	local bd = CreateFrame('Frame', nil, parent)
	bd:SetFrameLevel(parent:GetFrameLevel() - 1)
	bd:SetBackdrop(addon.media.backdrop)
	bd:SetBackdropColor(r, g, b, 1)
	bd:SetBackdropBorderColor(1, 0, 0)
	bd:SetPoint('TOPLEFT', -1, 1)
	bd:SetPoint('BOTTOMRIGHT', 1, -1)

	return bd
end
