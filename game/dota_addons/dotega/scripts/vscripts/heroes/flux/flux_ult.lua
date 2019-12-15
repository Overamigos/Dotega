function FluxUltParticle( args)
    local caster = args.caster
    local target = args.target
    local ability = args.ability

    local particleName = "particles/units/heroes/hero_earth_spirit/espirit_bouldersmash_target_trail.vpcf"
    local poscaster = caster:GetAbsOrigin()* Vector( 1, 1, 0 )
    local postarget = target:GetAbsOrigin()* Vector( 1, 1, 0 )
    local distance = (poscaster - postarget):Length()
    local forwardVec = poscaster - postarget
    forwardVec = forwardVec:Normalized()
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
        	bReplaceExisting = false,
        	iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        	iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        	iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        	fExpireTime = GameRules:GetGameTime() + 1,
		bDeleteOnHit = false,
		vVelocity = forwardVec * 1000,
		bProvidesVision = false,
		iVisionRadius = 0
    }
    projectile = ProjectileManager:CreateLinearProjectile(info)
end

function FluxUltWave(args)
	local caster = args.caster
    local target = args.target
    local ability = args.ability

    local particleName = "particles/econ/items/tiny/tiny_prestige/tiny_prestige_avalanche_projectile.vpcf"
	
end