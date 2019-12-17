function cast(args)
	local caster = args.caster
	local target = args.target
	local modifier_enemy = args.modifier_main_enemy
	local modifier_ally = args.modifier_main_ally
	local duration = args.duration
	local ability = args.ability

	if caster:GetTeam() == target:GetTeam() then
		ability:ApplyDataDrivenModifier(caster, target, modifier_ally, {duration = duration})
	else
		ability:ApplyDataDrivenModifier(caster, target, modifier_enemy, {duration = duration})
	end
end

function pulse(args)
	local caster = args.caster
	local target = args.target
	local base = args.amount
	local radius = args.radius
	local kbforce = args.kbforce
	local posT = target:GetAbsOrigin()


	if caster:GetTeam() == target:GetTeam() then
		local units = FindUnitsInRadius(caster:GetTeam(),
                              posT,
                              nil,
                              radius,
                              DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                              DOTA_UNIT_TARGET_HERO,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,
							  false)
			
		local amount = table.getn(units)*base/50
		for _,unit in pairs(units) do	
			unit:Heal(amount, caster)
		end

		local units = FindUnitsInRadius(caster:GetTeam(),
                              posT,
                              nil,
                              radius,
                              DOTA_UNIT_TARGET_TEAM_ENEMY,
                              DOTA_UNIT_TARGET_HERO,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,
							  false)
		for _,unit in pairs(units) do
			local direction = (unit:GetAbsOrigin() - posT)*Vector(1, 1, 0):Normalized()
			if target == caster then
				direction = direction*-1
			end
			local new_origin = unit:GetAbsOrigin() + 1 * direction * kbforce/100
			unit:SetAbsOrigin(new_origin)
			FindClearSpaceForUnit(unit, new_origin, false) 
		end
		
	else
		local units = FindUnitsInRadius(caster:GetTeam(),
                              posT,
                              nil,
                              radius,
                              DOTA_UNIT_TARGET_TEAM_ENEMY,
                              DOTA_UNIT_TARGET_HERO,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,
							  false)
			
		local amount = table.getn(units)*base/50
		for _,unit in pairs(units) do	
			local damageTable = {
				victim = unit,
				attacker = caster,
				damage = amount,
				damage_type = DAMAGE_TYPE_MAGICAL,
				damage_flags = DOTA_DAMAGE_FLAG_NONE,
				ability = args.ability, 
			}
			
			ApplyDamage(damageTable)

			local direction = (posT - unit:GetAbsOrigin())*Vector(1, 1, 0):Normalized()
			local new_origin = unit:GetAbsOrigin() + 1 * direction * kbforce/100
			unit:SetAbsOrigin(new_origin)
			FindClearSpaceForUnit(unit, new_origin, false) 
		end
		
	end
end
