local addon = select(2, ...)

function addon.elements.Leader(self, unit)
	local leader = self:CreateTexture(nil, 'OVERLAY')
	leader:SetSize(16, 16)

	self.LeaderIndicator = leader
end
