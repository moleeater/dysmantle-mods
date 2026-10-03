// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-roll-attack.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Include("actors/enemies/scripts/common.nut");

const preferred_distance = 300;
const min_shoot_distance = 90;
const max_shoot_distance = 400;

local has_line_of_sight = false;
local time_target_updated = 0;
local time_attacked = 0;
local time_enemy_checked = 0;

function OnGameStart(so_actor)
{
    time_target_updated = Stage_GetTimeMilliseconds() + m_randf(0, 1000);

    local start_wander = StageObject_GetKeyValue(so_actor, "Wander_start_automatically");
    if (start_wander)
    {
        local wander_radius = StageObject_GetKeyValue(so_actor, "Wander_radius");
        Game_StartWander(so_actor, wander_radius, true);
    }

    local start_follow_path = StageObject_GetKeyValue(so_actor, "FollowPath_start_automatically");
    if (start_follow_path)
    {
        Game_StartFollowPath(so_actor, "FollowPath_path");
    }
}

function OnThink(so_actor, tdelta)
{
    local action = Game_GetCurrentAction(so_actor);
    if (action == "AttackAction")
    {
        return;
    }

    local current_time = Stage_GetTimeMilliseconds();
    local so_current_target = Actor_GetAttributeTargetActor(so_actor);

    if (!so_current_target || Actor_GetAttributeHitPoints(so_current_target) <= 0)
    {
        if (time_target_updated + 200 < current_time &&
            action != "InvestigateAction")
        {
            time_target_updated = current_time;
            Game_UpdateTargetActor(so_actor);
        }
    }

    if (so_current_target)
    {
        if (action != "ChaseAction" && action != "AttackAction")
        {
            Game_StartChase(so_actor, preferred_distance, true);
        }
        else if (action == "ChaseAction")
        {
            if (has_line_of_sight)
            {
                local distance = GetActorDistance(so_actor, so_current_target);
                if (distance < 30)
                {
                    Game_StartAttack(so_actor, "melee", false);
                    time_attacked = current_time;
                }
                else if (distance > min_shoot_distance && distance < max_shoot_distance)
                {
                    if (current_time > time_attacked + 1800)
                    {
                        Game_StartRangedAttack(so_actor, "shoot", 700, 0.5);
                        time_attacked = current_time;
                    }
                }
            }
        }
    }    
    else
    {
        if (current_time > time_enemy_checked + 2000)
        {
            time_enemy_checked = current_time;

            local angle = StageObject_GetAngle(so_actor);
            local so_enemy = Game_GetNearestEnemyInCone(so_actor, angle, 45, max_shoot_distance);
            if (so_enemy != null)
            {
                local distance = GetActorDistance(so_actor, so_enemy);
                if (distance > min_shoot_distance)
                {
                    Game_StartRangedAttack(so_actor, "shoot", 700, 0.5);
                    time_attacked = current_time;
                }
            }
        }
    }
    

    HandleIdleAnimation(so_actor, tdelta);
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
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    if (this.rawin ("Mod_RollAttack_OnCollision_Creature") == true) Mod_RollAttack_OnCollision_Creature (so_actor, so_enemy);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}

function OnHearNoise(so_actor, position, noise_type, so_lure)
{
   // HandleLure(so_actor, noise_type, so_lure);
}
