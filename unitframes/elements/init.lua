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

	local border = CreateFrame('Frame', nil, parent, 'BackdropTemplate')
	border:SetBackdrop({ edgeFile = addon.media.border, edgeSize = 1 })
	border:SetBackdropBorderColor(0, 0, 0, 1)
	border:SetPoint('TOPLEFT', -1, 1)
	border:SetPoint('BOTTOMRIGHT', 1, -1)
	border:SetFrameLevel(parent:GetFrameLevel() - 1)

	return bg
end
