// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

local mods_include_path = "";
mods_include_path = "scripts/mods/mod-hide-corpses.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-roll-attack.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-trophies.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-turrets-everywhere.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function OnGameStart (enemy) {
  if (this.rawin ("Mod_HideCorpses_OnGameStart_Creature") == true) Mod_HideCorpses_OnGameStart_Creature (enemy);
}


function OnCollision (so_actor, so_enemy) {
  if (this.rawin ("Mod_RollAttack_OnCollision_Creature") == true) Mod_RollAttack_OnCollision_Creature (so_actor, so_enemy);
}


function OnCommandWord (so_actor, command_word) {
  if (this.rawin ("Mod_Trophies_OnCommandWord_Creature") == true) Mod_Trophies_OnCommandWord_Creature (so_actor, command_word);
  if (this.rawin ("Mod_TurretsEverywhere_OnCommandWord_Creature") == true) Mod_TurretsEverywhere_OnCommandWord_Creature (so_actor, command_word);
}

// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function GetDistance(a, b)
{
    local c = array(3);
    c[0] = a[0] - b[0];
    c[1] = a[1] - b[1];
    c[2] = a[2] - b[2];
    return sqrt(c[0] * c[0] + c[1] * c[1] + c[2] * c[2]);
}

function GetActorDistance(so_actor, so_target)
{
    local a = StageObject_GetPosition(so_actor);
    local b = StageObject_GetPosition(so_target);
    return GetDistance(a, b);
}

function GetSpeed(so_actor)
{
    local v = Actor_GetLinearVelocity(so_actor);
    return sqrt(v[0] * v[0] + v[1] * v[1]);
}

function Clamp(value, min, max)
{
    return value < min ? min : (value > max ? max : value);
}


idle_animation_timer <- 0;
next_idle_animation_time <- null;

function HandleIdleAnimation(so_actor, tdelta)
{
    local action = Game_GetCurrentAction(so_actor);
    if (action == "EnemyBaseAction")
    {
        idle_animation_timer += tdelta;
        if (next_idle_animation_time == null || idle_animation_timer > next_idle_animation_time)
        {
            local anim_duration = 0;
            if (next_idle_animation_time != null)
            {
                local res = Game_PlayAnimationByAction(so_actor, "idle");
                if (res)
                {
                    anim_duration = res[1];
                }
            }

            idle_animation_timer = 0;
            next_idle_animation_time = anim_duration + 1 + (rand() % 10000) / 1000.0;
        }
    }
    else
    {
        idle_animation_timer = 0;
    }
}

function HandleLure(so_actor, noise_type, so_lure)
{
    if (so_lure != 0 && noise_type == "Lure")
    {
        Game_SetTargetActor(so_actor, 0);
        Game_StartInvestigate(so_actor, noise_type, so_lure);
    }
}
