// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

local mods_include_path = "";
mods_include_path = "scripts/mods/mod-trophies.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-roll-attack.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);

function OnCommandWord (so_actor, command_word) {
  if (this.rawin ("Mod_Trophies_OnCommandWord_Creature") == true) Mod_Trophies_OnCommandWord_Creature (so_actor, command_word);
}

// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


local has_line_of_sight = false;
local time_target_updated = 0;

function GetDistance(so_actor, so_target)
{
    local a = StageObject_GetPosition(so_actor);
    local b = StageObject_GetPosition(so_target);
    a[0] -= b[0];
    a[1] -= b[1];
    a[2] -= b[2];
    return sqrt(a[0] * a[0] + a[1] * a[1] + a[2] * a[2]);
}

function GetSpeed(so_actor)
{
    local v = Actor_GetLinearVelocity(so_actor);
    return sqrt(v[0] * v[0] + v[1] * v[1]);
}

function OnGameStart(so_actor)
{
    time_target_updated = Stage_GetTimeMilliseconds() + m_randf(0, 1000);
}

function OnThink(so_actor, tdelta)
{
    local so_current_target = Actor_GetAttributeTargetActor(so_actor);
    local current_time = Stage_GetTimeMilliseconds();

    if (!so_current_target || Actor_GetAttributeHitPoints(so_current_target) <= 0)
    {
        if (time_target_updated + 200 < current_time)
        {
            time_target_updated = current_time;
            Game_UpdateTargetActor(so_actor);
        }
    }

    if (so_current_target && Game_GetCurrentAction(so_actor) == "ChaseAction")
    {
        if (GetDistance(so_actor, so_current_target) < 45 && has_line_of_sight)
        {
            local angle = abs(Game_GetAngleDifference(so_current_target, so_actor));
            local target_speed = GetSpeed(so_current_target);
            if (angle > 90 && target_speed > 10)
            {
                Game_StartAttack(so_actor, "melee.hands_free.moving-2", true) || Game_StartAttack(so_actor, "melee.hands_free.moving", true) ;
            }
            else
            {
                Game_StartAttack(so_actor, "melee.hands_free.idle", false);
            }
        }
    }
}

function OnTargetChanged(so_actor, so_new_target, so_old_target)
{
    if (so_new_target)
    {
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
