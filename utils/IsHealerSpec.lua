local addon = select(2, ...)

local healerSpecs = {
	DISCIPLINE = true,
	HOLY = true,
	MISTWEAVER = true,
	RESTORATION = true,
}

function addon.utils.IsHealerSpec(spec)
	return healerSpecs[spec] or false
end
