// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-hide-corpses.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-roll-attack.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Include("actors/enemies/scripts/common.nut");

local has_line_of_sight = false;
local time_target_updated = 0;

function OnGameStart(so_actor)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_HideCorpses_OnGameStart_Creature") == true) Mod_HideCorpses_OnGameStart_Creature (so_actor);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
            Game_StartChase(so_actor);
        }
        else if (action == "ChaseAction")
        {
            if (GetActorDistance(so_actor, so_current_target) < 45 && has_line_of_sight)
            {
                local angle = abs(Game_GetAngleDifference(so_current_target, so_actor));
                local target_speed = GetSpeed(so_current_target);
                if (/*angle > 90 && */target_speed > 100)
                {
                    Game_StartAttack(so_actor, "melee_moving", true);
                }
                else
                {
                    Game_StartAttack(so_actor, "melee", false);
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

        Game_StartChase(so_actor);
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
    HandleLure(so_actor, noise_type, so_lure);
}
