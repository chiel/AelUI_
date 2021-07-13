local addon = select(2, ...)

function addon.elements.RaidTarget(self, unit)
	local raidTarget = self:CreateTexture(nil, 'OVERLAY')
	raidTarget:SetSize(24, 24)
	self.RaidTargetIndicator = raidTarget
end
