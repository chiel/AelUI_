local addon = select(2, ...)

addon.elements = {}

function addon.elements.Backdrop(parent, color)
	local bg = parent:CreateTexture(nil, 'BORDER')
	bg:SetTexture(addon.media.textureBg)
	bg:SetVertexColor(unpack(color or {.2, .2, .2}))

	if parent:GetObjectType() == 'StatusBar' then
		bg:SetPoint('TOPRIGHT', parent)
		bg:SetPoint('BOTTOMLEFT', parent:GetStatusBarTexture(), 'BOTTOMRIGHT')
	else
		bg:SetAllPoints()
	end

	parent:SetBackdrop({ edgeFile = addon.media.border, edgeSize = -1 })
	parent:SetBackdropBorderColor(0, 0, 0, 1)

	return bg
end
