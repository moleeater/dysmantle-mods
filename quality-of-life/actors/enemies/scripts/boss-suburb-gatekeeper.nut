// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-trophies.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Include("actors/enemies/scripts/common-puker.nut");

local enemy_in_radius = false;
local timer = 0;

function OnThink(so_actor, tdelta)
{
    local action = Game_GetCurrentAction(so_actor);
    local current_time = Stage_GetTimeMilliseconds();
    local so_current_target = Actor_GetAttributeTargetActor(so_actor);

    if (!so_current_target || Actor_GetAttributeHitPoints(so_current_target) <= 0)
    {
        if (time_target_updated + 200 < current_time)
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
            if (GetActorDistance(so_actor, so_current_target) < 90 && has_line_of_sight)
            {
                Game_StartAttack(so_actor, "spit", false);
            }
        }
    }

    if (so_current_target)
    {
        timer += tdelta;
    }

    if (so_current_target && Game_GetCurrentAction(so_actor) == "ChaseAction")
    {
        if (GetActorDistance(so_actor, so_current_target) < 90 && has_line_of_sight)
        {
            Game_StartAttack(so_actor, "spit", false);
        }

        if (timer > 20.0 || (timer > 15.0 && damage_counter >= 5))
        {
            if (enemy_in_radius)
            {
                Game_StartAttack(so_actor, "secondary_attack", false);
                timer = 0;
                damage_counter = 0;
            }
        }
    }
}

function OnEnemyInRadiusChanged(so_actor, so_target, in_radius)
{
    enemy_in_radius = in_radius;
}

function OnCommandWord(so_actor, command_word)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_Trophies_OnCommandWord_Creature") == true) Mod_Trophies_OnCommandWord_Creature (so_actor, command_word);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    if (command_word == "trigger_special_item") // From secondary_attack animation
    {
        local pos = StageObject_GetPosition(so_actor);
        local owner_angle = StageObject_GetAngle(so_actor) * PI / 180;

        local num_pukes = 4 + rand()%3;
        for (local i = 0; i < num_pukes; i++)
        {
            local angle = owner_angle + (2 * PI * 0.9) * (((i + 0.5) / num_pukes) - 0.5);
            local power = 30 + 100 * m_randf();

            local puke_handle = Stage_CreateActor("actors/projectiles/puke-projectile.xml", pos[0], pos[1], -140);
            Actor_SetOwner(puke_handle, so_actor);
            Actor_SetLinearVelocity(puke_handle, power * cos(-angle), -power * sin(-angle), -(400 + 400 * m_randf()));
        }
    }
}
