function FluxUltParticle( args)
    local caster = args.caster
    local target = args.target
	local ability = args.ability
	local kbforce = args.kbforce

    local particleName = "particles/units/heroes/hero_earth_spirit/espirit_bouldersmash_target_trail.vpcf"
    local poscaster = caster:GetAbsOrigin()* Vector( 1, 1, 0 )
    local postarget = target:GetAbsOrigin()* Vector( 1, 1, 0 )
    local distance = (poscaster - postarget):Length()
    local forwardVec = (poscaster - postarget):Normalized()

	 
    local new_origin = target:GetAbsOrigin() -1 * forwardVec * kbforce
	target:SetAbsOrigin(new_origin)
	local point = target:GetAbsOrigin()
    FindClearSpaceForUnit(target, point, false) 
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