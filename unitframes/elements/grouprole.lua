local addon = select(2, ...)

local function PostUpdate(element, role)
	if role == 'DAMAGER' then
		element:Hide()
	end
end

function addon.elements.GroupRole(self, unit)
	local groupRole = self:CreateTexture(nil, 'OVERLAY')
	groupRole:SetSize(16, 16)
	groupRole.PostUpdate = PostUpdate

	self.GroupRoleIndicator = groupRole
end
