// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-trophies.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-turrets-everywhere.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

local boss_turrets = ["BOSS_TURRET_1", "BOSS_TURRET_2", "BOSS_TURRET_3", "BOSS_TURRET_4"];
local boss_add_turrets = ["BOSS_ADD_TURRET_1", "BOSS_ADD_TURRET_2", "BOSS_ADD_TURRET_3", "BOSS_ADD_TURRET_4"];

local timer = 0;
local phase = 0;
local activated = false;

function OnGameStart(so_actor)
{
    foreach (id in boss_turrets)
    {
        SendCommand(id, "close");
    }

    foreach (id in boss_add_turrets)
    {
        SendCommand(id, "close");
    }
}

function OnThink(so_actor, tdelta)
{
    if (phase == 0)
    {
        return;
    }

    timer += tdelta;
    if (timer > 0.1)
    {
        timer = 0;

        UpdateHealth(so_actor);

        if (phase == 1 && IsPhase1Completed(so_actor))
        {
            InitializePhase2(so_actor);
        }
        else if (phase == 2 && IsPhase2Completed(so_actor))
        {
            InitializePhase3(so_actor);
        }
        else if (phase == 3 && IsPhase3Completed(so_actor))
        {
            InitializePhase4(so_actor);
        }
    }
}

function OnCommandWord(so_actor, command_word)
{
    if (!activated && command_word == "puzzle_component_trigger")
    {
        activated = true;
        OnActivate(so_actor);
    }
    else if (activated && command_word == "death_start")
    {
        OnDeath(so_actor);
    }
}

function SendCommand(id, command)
{
    local so = StageObject_GetById(id);
    if (so != null)
    {
        Stage_SendStageObjectCommandWord(so, command);
    }
}

function GetHealth(id)
{
    local so = StageObject_GetById(id);
    if (so != null)
    {
        local hp = Actor_GetAttributeHitPoints(so);
        if (hp >= 0)
        {
            return hp;
        }
    }

    return 0;
}

function GetMaxHealth(id)
{
    local so = StageObject_GetById(id);
    if (so != null)
    {
         return Actor_GetAttributeMaximumHitPoints(so);
    }

    return 0;
}

function UpdateHealth(so_actor)
{
    local current_health = Actor_GetAttributeHitPoints(so_actor);

    local total_turret_health = 0;
    foreach (id in boss_turrets)
    {
        total_turret_health += GetHealth(id);
    }
    foreach (id in boss_add_turrets)
    {
        total_turret_health += GetHealth(id);
    }

    local diff = current_health - total_turret_health;
    if (diff > 0)
    {
        Stage_DealDamage(0, so_actor, diff, 0);
    }
}

function InitializePhase1(so_actor)
{
    phase = 1;

    SendCommand(boss_turrets[0], "open");
    SendCommand(boss_turrets[1], "open");
    SendCommand(boss_turrets[2], "close");
    SendCommand(boss_turrets[3], "close");
}

function InitializePhase2(so_actor)
{
    phase = 2;
    
    SendCommand(boss_turrets[0], "close");
    SendCommand(boss_turrets[1], "close");
    SendCommand(boss_turrets[2], "open");
    SendCommand(boss_turrets[3], "open");
}

function InitializePhase3(so_actor)
{
    phase = 3;

    foreach (id in boss_turrets)
    {
        SendCommand(id, "close");
    }

    foreach (id in boss_add_turrets)
    {
        SendCommand(id, "open");
    }
}

function InitializePhase4(so_actor)
{
    phase = 4;

    foreach (id in boss_turrets)
    {
        SendCommand(id, "open");
    }

    foreach (id in boss_add_turrets)
    {
        SendCommand(id, "open");
    }
}

function IsPhase1Completed(so_actor)
{
    local max_health = GetMaxHealth(boss_turrets[0]) + GetMaxHealth(boss_turrets[1]);
    local turret_0_health = GetHealth(boss_turrets[0]);
    local turret_1_health = GetHealth(boss_turrets[1]);

    return (turret_0_health + turret_1_health) < 0.25 * max_health ||
        turret_0_health <= 0.01 ||
        turret_1_health <= 0.01;
}

function IsPhase2Completed(so_actor)
{
    local max_health = GetMaxHealth(boss_turrets[2]) + GetMaxHealth(boss_turrets[3]);
    local turret_2_health = GetHealth(boss_turrets[2]);
    local turret_3_health = GetHealth(boss_turrets[3]);

    return (turret_2_health + turret_3_health) < 0.25 * max_health ||
        turret_2_health <= 0.01 ||
        turret_3_health <= 0.01;
}

function IsPhase3Completed(so_actor)
{
    local num_alive = 0;
    foreach (id in boss_add_turrets)
    {
        if (GetHealth(id) > 0.01)
        {
            num_alive++;
        }
    }

    return num_alive <= boss_add_turrets.len() / 2;
}

function OnActivate(so_actor)
{
    Game_ShowActorHitPointsBar(so_actor);
    InitializePhase1(so_actor);
}

function OnDeath(so_actor)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_Trophies_OnDeath_Boss") == true) Mod_Trophies_OnDeath_Boss (so_actor);
  if (this.rawin ("Mod_TurretsEverywhere_OnDeath_TurretBoss") == true) Mod_TurretsEverywhere_OnDeath_TurretBoss (so_actor);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}
