local addon = select(2, ...)

function addon.elements.Castbar(self, unit)
	local castbar = CreateFrame('StatusBar', nil, self)
	castbar:SetStatusBarTexture(addon.media.texture)
	castbar:SetStatusBarColor(22 / 255, 142 / 255, 198 / 255)
	castbar:SetHeight(4)
	castbar.bd = addon.elements.Backdrop(castbar)

	local Icon = castbar:CreateTexture(nil, 'OVERLAY')
	Icon:SetSize(32, 32)
	Icon:SetPoint('BOTTOMRIGHT', castbar, 'BOTTOMLEFT', -5, -1)

	local options = { pixel = true, size = 8 }

	local Text = addon.elements.Text(castbar, options)
	Text:SetPoint('TOPLEFT', castbar, 'BOTTOMLEFT', 4, -6)

	local Time = addon.elements.Text(castbar, options)
	Time:SetPoint('TOPRIGHT', castbar, 'BOTTOMRIGHT', -4, -6)
	Time:SetJustifyH('RIGHT')

	castbar.Icon = Icon
	castbar.Text = Text
	castbar.Time = Time

	self.Castbar = castbar
end
