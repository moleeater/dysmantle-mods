// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-hide-corpses.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Include("actors/enemies/scripts/common.nut");

local has_line_of_sight = false;
local time_target_updated = 0;
local time_near_enemy = 0;
local is_near_enemy = false;
local preferred_distance = 0;
local explosion_radius = 0;

function OnGameStart(so_actor)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_HideCorpses_OnGameStart_Creature") == true) Mod_HideCorpses_OnGameStart_Creature (so_actor);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    local wander_radius = 360.0;

    explosion_radius = StageObject_GetKeyValue(so_actor, "explosion_radius", 120.0);
    preferred_distance = explosion_radius - 20.0;

    time_target_updated = Stage_GetTimeMilliseconds() + m_randf(0, 1000);
    Game_StartWander(so_actor, wander_radius, true);
}

function OnThink(so_actor, tdelta)
{
    if (StageObject_HasTag(so_actor, "EXPLODING"))
    {
        return;
    }

    if (Actor_GetAttributeHitPoints(so_actor) < 1.0)
    {
        StartExploding(so_actor);
        return;
    }

    local action = Game_GetCurrentAction(so_actor);
    local current_time = Stage_GetTimeMilliseconds();
    local so_current_target = Actor_GetAttributeTargetActor(so_actor);

    if (time_target_updated + 1000 < current_time && action != "InvestigateAction")
    {
        time_target_updated = current_time;
        local remove_old_target = so_current_target && Actor_GetAttributeHitPoints(so_current_target) <= 0;
        Game_UpdateTargetActor(so_actor, -1, -1, remove_old_target);
    }
    
    if (so_current_target)
    {
        if (action != "ChaseAction" && action != "AttackAction")
        {
            Game_StartChase(so_actor, preferred_distance, true);
        }
        else if (action == "ChaseAction")
        {
            local distance = GetActorDistance(so_actor, so_current_target);
            if (has_line_of_sight && distance < explosion_radius)
            {
                if (!is_near_enemy)
                {
                    is_near_enemy = true;
                    time_near_enemy = current_time;
                }
                else if (time_near_enemy + 1000 < current_time)
                {
                    StartExploding(so_actor);
                    StageObject_AddTag(so_actor, "NO_EXPERIENCE_REWARD_ON_DEATH");
                }
            }
            else
            {
                is_near_enemy = false;
            }
        }
    }

    HandleIdleAnimation(so_actor, tdelta);
}

function StartExploding(so_actor)
{
    if (StageObject_HasTag(so_actor, "EXPLODING"))
    {
        return;
    }

    local current_time = Stage_GetTimeMilliseconds();

    Game_PlayAnimationByAction(so_actor, "charging_up");
    Game_StartWait(so_actor, 10000);
    Actor_SetActorFlag(so_actor, "NO_MOMENTUM_FROM_COLLISIONS", true);
    StageObject_AddTag(so_actor, "EXPLODING");
    StageObject_SetKeyValueInteger(so_actor, "explosion_start_time", current_time);
    StageObject_SetKeyValueInteger(so_actor, "explosion_end_time", current_time + 2000);
}

function OnCommandWord(so_actor, command_word)
{
    if (command_word == "fire_weapon")
    {
        Stage_KillActorAndStartDeathAnimation(so_actor);
        local pos = StageObject_GetPosition(so_actor);
        local damage = Actor_GetAttributeDamage(so_actor);
        Game_CreateExplosion(so_actor, pos[0], pos[1], pos[2], explosion_radius, damage, 600.0);
    }
}

function OnTargetChanged(so_actor, so_new_target, so_old_target)
{
    if (so_new_target)
    {
        if (Game_GetCurrentAction(so_actor) == "MoveToAction")
        {
            Game_StopCurrentAction(so_actor);
        }

        Game_StartChase(so_actor, preferred_distance, true);
    }
}

function OnLineOfSightToTargetChanged(so_actor, so_target, has_los)
{
    has_line_of_sight = has_los;
}

function OnReceiveDamage(so_actor, so_dealer)
{
    local so_current_target = Actor_GetAttributeTargetActor(so_actor);
    if (!so_current_target || !has_line_of_sight)
    {
        Game_SetTargetActor(so_actor, so_dealer);
    }
}

function OnCollision(so_actor, so_enemy)
{
    local so_current_target = Actor_GetAttributeTargetActor(so_actor);
    if (!so_current_target || !has_line_of_sight)
    {
        Game_SetTargetActor(so_actor, so_enemy);
    }
}

function OnHearNoise(so_actor, position, noise_type, so_lure)
{
    HandleLure(so_actor, noise_type, so_lure);
}
