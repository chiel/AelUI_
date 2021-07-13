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

function addon.elements.Border(parent, size, color)
	local size = size or 1
	local offset = 1 + size
	local r, g, b, a = unpack(color or { 1, 1, 1, 0 })
	local border = CreateFrame('Frame', nil, parent, 'BackdropTemplate')
	border:SetBackdrop({ edgeFile = addon.media.border, edgeSize = size })
	border:SetBackdropBorderColor(r, g, b, a)
	border:SetPoint('TOPLEFT', -offset, offset)
	border:SetPoint('BOTTOMRIGHT', offset, -offset)
	border:SetFrameLevel(parent:GetFrameLevel() - 1)

	return border
end
