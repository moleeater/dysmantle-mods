// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-hide-corpses.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Include("actors/enemies/scripts/common.nut");

const melee_distance = 60;
const min_shoot_distance = 150;
const max_shoot_distance = 400;

local preferred_distance = melee_distance - 10;
local has_line_of_sight = false;
local time_target_updated = 0;
local time_attacked = 0;
local stinger_attack_delay = 3000;

function OnGameStart(so_actor)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_HideCorpses_OnGameStart_Creature") == true) Mod_HideCorpses_OnGameStart_Creature (so_actor);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    local wander_radius = 360.0;

    time_attacked = Stage_GetTimeMilliseconds();
    time_target_updated = Stage_GetTimeMilliseconds() + m_randf(0, 1000);
    Game_StartWander(so_actor, wander_radius, true);
}

function OnThink(so_actor, tdelta)
{
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
            Game_StartChase(so_actor, preferred_distance, false);
        }
        else if (action == "ChaseAction")
        {
            if (has_line_of_sight)
            {
                local kvs = Game_GetAllPlayerModifiersAsKeyValueStore(so_current_target);
                local tags = kvs == null ? null : KeyValueStore_GetKeyValue(kvs, "tags");
                local barbed_immunity = tags != null && Tags_ContainsTag(tags, "BARBED_IMMUNITY");
                if (barbed_immunity)
                {
                    StageObject_SetKeyValueFloat(so_actor, "melee_damage_multiplier", 0.25);
                }
                else
                {
                    StageObject_SetKeyValueFloat(so_actor, "melee_damage_multiplier", 1.0);
                }

                local distance = GetActorDistance(so_actor, so_current_target);
                local diff = abs(Game_GetAngleDifference(so_actor, so_current_target));
                if (distance < melee_distance)
                {
                    if (diff < 30)
                    {
                        Game_StartAttack(so_actor, "needle_attack", false, false);
                        time_attacked = current_time;
                    }
                }
                else if (distance > min_shoot_distance && distance < max_shoot_distance)
                {
                    if (diff < 30 && current_time > time_attacked + stinger_attack_delay)
                    {
                        Game_StartAttack(so_actor, "stinger_attack", false, true);
                        time_attacked = current_time;
                        stinger_attack_delay = m_randf() * 4000 + 2000;
                    }
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

        Game_StartChase(so_actor, preferred_distance, false);
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
