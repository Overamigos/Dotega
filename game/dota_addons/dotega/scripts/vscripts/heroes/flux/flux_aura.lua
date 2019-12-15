function FluxAuraCheck( args)
    local caster = args.caster
	local ability = args.ability
	local modifierStack = args.modifier_stack_name
	local maxRadius = args.max_radius
	local minRadius = args.min_radius
	

    local targets = FindUnitsInRadius(caster:GetTeamNumber(),
                              caster:GetAbsOrigin(),
                              nil,
                              maxRadius,
                              DOTA_UNIT_TARGET_TEAM_ENEMY,
                              DOTA_UNIT_TARGET_HERO,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,
							  false)
	local stacks = 0
	for _,unit in pairs(targets) do
		local len = (unit:GetAbsOrigin() - caster:GetAbsOrigin()):Length()
		stacks = stacks + math.floor((maxRadius - len)/minRadius)							  
	end
	caster:SetModifierStackCount(modifierStack, caster, stacks)
end