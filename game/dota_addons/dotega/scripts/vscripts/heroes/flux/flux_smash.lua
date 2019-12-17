function FluxSmashCast(args)
	local caster = args.caster
	local casterPos = caster:GetAbsOrigin()
	local ability = args.ability
	local modifier_slow = args.modifier_slow
	local modifier_slow_kb = args.modifier_stack_slow_kb
	local modifier_slow_tooltip = args.modifier_slow_tooltip
	local length = args.length
	local damage_max = args.damage_max
	local damage_min = args.damage_min
	local slow_percent_max = args.slow_percent_max
	local slow_percent_min = args.slow_percent_min
	local duration = args.duration
	local target = casterPos + length*caster:GetForwardVector()

	local teams = DOTA_UNIT_TARGET_TEAM_ENEMY
	local types = DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
	local flags = DOTA_UNIT_TARGET_FLAG_NONE

	local units = FindUnitsInRadius(caster:GetTeam(),
                              casterPos,
                              nil,
                              length,
                              DOTA_UNIT_TARGET_TEAM_ENEMY,
                              DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,
                              false)
	
	for _,unit in pairs(units) do
		local distance = (casterPos - unit:GetAbsOrigin()):Length()
		local stacks = math.floor(slow_percent_max - distance/length * (slow_percent_max - slow_percent_min))
		local damage = damage_max - distance/length * (damage_max - damage_min)
		
		ability:ApplyDataDrivenModifier(caster, unit, modifier_slow, {duration = duration})
		ability:ApplyDataDrivenModifier(caster, unit, modifier_slow_kb, {duration = 1})
		unit:SetModifierStackCount(modifier_slow, caster, stacks)
		
		local damageTable = {
			victim = unit,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			damage_flags = DOTA_DAMAGE_FLAG_NONE,
			ability = ability,
		}

		ApplyDamage(damageTable)
		unit.FS_speed = (length - distance) / (1 / 0.02)
		unit.FS_direction = ((unit:GetAbsOrigin() - casterPos) * Vector(1,1,0)):Normalized()
	 end

end

function knockback(args)
    local target = args.target
    if target.FS_direction then
        local target_pos = target:GetAbsOrigin()   
        local new_origin = target_pos + target.FS_direction * target.FS_speed
        target:SetAbsOrigin(new_origin)
    end
end

function bugg(args)
    local target = args.target
    local point = target:GetAbsOrigin()
    FindClearSpaceForUnit(target, point, false)
end 
