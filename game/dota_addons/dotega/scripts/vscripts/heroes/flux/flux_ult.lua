function FluxUltParticle( args)
    local caster = args.caster
    local target = args.target
	local ability = args.ability
    local kbforce = args.kbforce
    local radius = args.radius

    if caster:HasTalent("special_bonus_flux_global_discharge") then
        radius = caster:FindTalentValue("special_bonus_flux_global_discharge")
    end

    local kbextra = 1
    if caster:HasTalent("special_bonus_flux_force") then
        kbextra = caster:FindTalentValue("special_bonus_flux_force")
    end
    kbforce = kbforce*kbextra
    local poscaster = caster:GetAbsOrigin()* Vector( 1, 1, 0 )

    local targets = FindUnitsInRadius(caster:GetTeamNumber(),
    poscaster,
        nil,
        radius,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false)
    local stacks = 0

    for _,unit in pairs(targets) do
        local postarget = unit:GetAbsOrigin()* Vector( 1, 1, 0 )
        local distance = (poscaster - postarget):Length()
        local forwardVec = (poscaster - postarget):Normalized()	
        local new_origin = postarget -1 * forwardVec * kbforce	
        unit:SetAbsOrigin(new_origin)	
        FindClearSpaceForUnit(unit, new_origin, false) 			  
    end
    
end    

-- local info = 
-- {
-- 	Ability = ability,
-- 	EffectName = particleName,
-- 	vSpawnOrigin = target:GetAbsOrigin(),
-- 	fDistance = 100,
-- 	fStartRadius = 0,
-- 	fEndRadius = 0,
-- 	Source = caster,
-- 	bHasFrontalCone = false,
-- 	fExpireTime = GameRules:GetGameTime(),
-- 	bDeleteOnHit = false,
-- 	vVelocity = forwardVec * 1000,
-- 	bProvidesVision = false,
-- 	iVisionRadius = 0
-- }
--projectile = ProjectileManager:CreateLinearProjectile(info)