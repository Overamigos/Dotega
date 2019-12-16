function FluxUltParticle( args)
    local caster = args.caster
    local target = args.target
    local ability = args.ability

    local particleName = "particles/units/heroes/hero_earth_spirit/espirit_bouldersmash_target_trail.vpcf"
    local poscaster = caster:GetAbsOrigin()* Vector( 1, 1, 0 )
    local postarget = target:GetAbsOrigin()* Vector( 1, 1, 0 )
    local distance = (poscaster - postarget):Length()
    local forwardVec = (poscaster - postarget):Normalized()
    local info = 
	{
		Ability = ability,
        	EffectName = particleName,
        	vSpawnOrigin = target:GetAbsOrigin(),
        	fDistance = distance,
        	fStartRadius = 0,
        	fEndRadius = 0,
        	Source = caster,
        	bHasFrontalCone = false,
        	fExpireTime = GameRules:GetGameTime() + 0.1,
		bDeleteOnHit = false,
		vVelocity = forwardVec * 1000,
		bProvidesVision = false,
		iVisionRadius = 0
    }
    projectile = ProjectileManager:CreateLinearProjectile(info)
end

-- function FluxUltWave(args)
-- 	local caster = args.caster
-- 	local ability = args.ability
	
-- 	local particleName = "particles/econ/items/tiny/tiny_prestige/tiny_prestige_avalanche_projectile.vpcf"
--     local poscaster = caster:GetAbsOrigin()* Vector( 1, 1, 0 )
-- 	local forwardVec = caster:GetForwardVector()*Vector(1, 1, 0):Normalized()
-- 	local maxRadius = args.max_radius
-- 	local maxDistance = args.max_distante
-- 	local maxAngle = math.atan(maxRadius/2/maxDistance)
-- 	local theta = math.random(0, maxAngle)
-- 	local newRot = forwardVec

-- 	newRot.x =  math.cos( theta )*forwardVec.x - math.sin( theta )*forwardVec.y
-- 	newRot.y =  math.sin( theta )*forwardVec.x + math.cos( theta )*forwardVec.y
-- 	newRot = newRot:Normalized()
--     local info = 
-- 	{
-- 		Ability = ability,
--         	EffectName = particleName,
--         	vSpawnOrigin = caster:GetAbsOrigin(),
--         	fDistance = maxDistance,
--         	fStartRadius = 0,
--         	fEndRadius = 0,
--         	Source = caster,
--         	bHasFrontalCone = false,
--         	bReplaceExisting = false,
--         	fExpireTime = GameRules:GetGameTime() + 1,
-- 		bDeleteOnHit = false,
-- 		vVelocity = newRot * 3000,
-- 		bProvidesVision = false,
-- 		iVisionRadius = 0
-- 	}
--     projectile = ProjectileManager:CreateLinearProjectile(info)
	
-- end