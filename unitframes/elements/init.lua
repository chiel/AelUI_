local addon = select(2, ...)

addon.elements = {}

addon.elements.Base = function(frame, unit)
	frame:SetScript('OnEnter', UnitFrame_OnEnter)
	frame:SetScript('OnLeave', UnitFrame_OnLeave)
	frame:RegisterForClicks('AnyUp')

	frame.colors = addon.colors
end

addon.elements.CreateBg = function(ParentFrame)
	local Bg = CreateFrame('Frame', nil, ParentFrame)
	Bg:SetFrameLevel(0)
	Bg:SetBackdrop({
		bgFile = addon.media.textureBg,
		edgeFile = addon.media.border,
		tile = false, tileSize = 4, edgeSize = 1,
		insets = { left = 1, right = 1, top = 1, bottom = 1 }
	})
	Bg:SetBackdropColor(.2, .2, .2, 1)
	Bg:SetBackdropBorderColor(0, 0, 0)
	Bg:SetPoint('TOPLEFT', -1, 1)
	Bg:SetPoint('BOTTOMRIGHT', 1, -1)

	return Bg
end

addon.elements.CreateFg = function(ParentFrame)
	local Bg = CreateFrame('Frame', nil, ParentFrame)
	Bg:SetFrameLevel(0)
	Bg:SetBackdrop({
		bgFile = addon.media.texture,
		edgeFile = addon.media.border,
		tile = false, tileSize = 4, edgeSize = 1,
		insets = { left = 1, right = 1, top = 1, bottom = 1 }
	})
	Bg:SetBackdropColor(.2, .2, .2, 1)
	Bg:SetBackdropBorderColor(0, 0, 0)
	Bg:SetPoint('TOPLEFT', -1, 1)
	Bg:SetPoint('BOTTOMRIGHT', 1, -1)
end
