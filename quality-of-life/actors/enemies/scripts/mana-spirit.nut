// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-break-spirits.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-hide-corpses.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-roll-attack.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Include("actors/enemies/scripts/common.nut");

const preferred_distance = 300;
const min_shoot_distance = 90;
const max_shoot_distance = 480;

local has_line_of_sight = false;
local time_target_updated = 0;
local time_attacked = 0;
local time_teleported = 0;
local so_teleport_target = null;

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
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    if (this.rawin ("Mod_BreakSpirits_OnThink_ManaSpirit") == true) Mod_BreakSpirits_OnThink_ManaSpirit (so_actor);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    local action = Game_GetCurrentAction(so_actor);
   
    // stop stunned if invulnerable
    if(action == "StunAction"){

        local is_vulnerable = StageObject_GetKeyValue(so_actor, "vulnerability_timer") > 0.1;

        if(!is_vulnerable) {
              Game_StopCurrentAction(so_actor);
              return;
        }

    }

    if (action == "TeleportAction")
    {
        return;
    }

    local current_time = Stage_GetTimeMilliseconds();
    local so_current_target = Actor_GetAttributeTargetActor(so_actor);
    
    if (so_teleport_target != null && current_time > time_teleported + 4000 && action != "AttackAction")
    {
        if (StageObject_IsValid(so_teleport_target))
        {
            local is_vulnerable = StageObject_GetKeyValue(so_actor, "vulnerability_timer") > 0.1;
            if (!is_vulnerable)
            {
                local distance = GetActorDistance(so_actor, so_teleport_target) * (m_randf() * 0.5 + 0.4);
                local delay_after = 0.2;
                Teleport(so_actor, true, distance, delay_after);
                return;
            }
        }
        else
        {
            so_teleport_target = null;
        }
    }    

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
                if (distance < 45)
                {
                    Game_StartAttack(so_actor, "melee", false);
                    time_attacked = current_time;
                }
                else if (distance > min_shoot_distance && distance < max_shoot_distance)
                {
                    if (current_time > time_attacked + 2000)
                    {
                        Game_StartAttack(so_actor, "shoot", false);
                        time_attacked = current_time;
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

        Game_StartChase(so_actor, preferred_distance, true);

        so_teleport_target = so_new_target;
    }
}

function OnLineOfSightToTargetChanged(so_actor, so_target, has_los)
{
    has_line_of_sight = has_los;
}

function OnWeaponHit(so_actor, so_dealer_owner, so_dealer, damage, damage_type, weapon_type)
{
    local so_current_target = Actor_GetAttributeTargetActor(so_actor);
    if (!so_current_target || !has_line_of_sight)
    {
        Game_SetTargetActor(so_actor, so_dealer_owner);
    }

    if (StageObject_HasTag(so_dealer_owner, "PLAYER") && weapon_type == "MELEE_WEAPON")
    {
        local is_vulnerable = StageObject_GetKeyValue(so_actor, "vulnerability_timer") > 0.1;
        if (!is_vulnerable)
        {
            local distance = m_randf() * 120 + 180;
            local delay_after = 1;
            Teleport(so_actor, false, distance, delay_after);
        }
    }

    if (StageObject_HasTag(so_dealer_owner, "PLAYER") && weapon_type == "RANGED_WEAPON")
    {
        if (StageObject_HasTag(so_dealer, "MANA_DAMAGE"))
        {
            StageObject_SetKeyValueFloat(so_actor, "vulnerability_timer", 10.0);
        }
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

function GetDirection(so_actor, so_target)
{
    local a = StageObject_GetPosition(so_actor);
    local b = StageObject_GetPosition(so_target);
    return atan2(b[1] - a[1], b[0] - a[0]);
}

function Teleport(so_actor, towards_target, dist, delay)
{
    if (so_teleport_target == null || !StageObject_IsValid(so_teleport_target))
    {
        return;
    }

    local target_pos = StageObject_GetPosition(so_teleport_target);

    local action = Game_GetCurrentAction(so_actor);
    if (action == "TeleportAction")
    {
        return;
    }

    Game_SetTargetActor(so_actor, so_teleport_target);
    Game_StartTeleport(so_actor, target_pos[0], target_pos[1], target_pos[2], dist, towards_target, delay);
    time_teleported = Stage_GetTimeMilliseconds();
}
