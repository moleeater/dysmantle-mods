// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-trophies.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-turrets-everywhere.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

local timer = 0;
local phase = 0;
local activated = false;
local activated_mechs = [];

function OnGameStart(so_actor)
{
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
    }
}

function OnCommandWord(so_actor, command_word)
{
    if (!activated && command_word == "activate")
    {
        Game_ShowActorHitPointsBar(so_actor);
        InitializePhase1(so_actor);
        activated = true;
    }
    else if (activated && command_word == "open")
    {
        if (phase >= 1)
        {
            ActivateMech(1);
        }

        if (phase >= 2)
        {
            ActivateMech(2);
            ActivateMech(3);
        }
        
        if (phase >= 3)
        {
            ActivateMech(4);
        }
    }
    else if (activated && command_word == "death_start")
    {
        OnDeath(so_actor);
    }
}

function SendCommandWord(id, command)
{
    local so = StageObject_GetById(id);
    if (so != null)
    {
        Stage_SendStageObjectCommandWord(so, command);
    }
}

function SendCommand(id, command, delay)
{
    local so = StageObject_GetById(id);
    if (so != null)
    {
        Stage_SendStageObjectCommand(so, command, delay);
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

    local total_health = 0;
    foreach (id in ["MECH_1", "MECH_2", "MECH_3", "MECH_4"])
    {
        total_health += GetHealth(id);
    }

    local diff = current_health - total_health;
    if (diff > 0)
    {
        Stage_DealDamage(0, so_actor, diff, 0);
    }
}

function ActivateMech(mech_num)
{
    local so_mech = StageObject_GetById("MECH_" + mech_num);
    if (so_mech == null)
    {
        return;
    }

    if (activated_mechs.find(mech_num) == null && Actor_GetAttributeHitPoints(so_mech) > 0.01)
    {
        StageObject_SetParentButRetainStageTransform(so_mech, null);
        Stage_SendStageObjectCommandWord(so_mech, "activate");
        Actor_QueueActionStopAnimationWithTransition(so_mech, "sleeping", "wake_up_initial", true);

        activated_mechs.append(mech_num);
    }
}

function OpenMechDoors(so_actor, mech_num)
{
    local open_command = Command_Create("open");
    local open_kvs = Command_GetKeyValueStore(open_command);
    KeyValueStore_SetKeyValueBoolean(open_kvs, "instant", false);

    SendCommand("GANTRY_ELEVATOR_" + mech_num + "_DOOR_A", open_command, 0);
    SendCommand("GANTRY_ELEVATOR_" + mech_num + "_DOOR_B", open_command, 0);

    local activate_command = Command_Create("activate");
    for (local i = 1; i <= 6; i++)
    {
        SendCommand("GANTRY_ELEVATOR_" + mech_num + "_PLAT_" + i, activate_command, 2);
    }
    Command_Delete(activate_command);

    local mech = StageObject_GetById("MECH_" + mech_num);
    if (mech != null)
    {
        Actor_PlayAnimationWithDelayPlaybackSpeedAndPosition(mech, "elevator_sound", 1.5, 0, 0);
    }

    Stage_SendStageObjectCommand(so_actor, open_command, 4);
    Command_Delete(open_command);
}

function InitializePhase1(so_actor)
{
    phase = 1;
    OpenMechDoors(so_actor, 1);
}

function InitializePhase2(so_actor)
{
    phase = 2;
    OpenMechDoors(so_actor, 2);
    OpenMechDoors(so_actor, 3);
}

function InitializePhase3(so_actor)
{
    phase = 3;
    OpenMechDoors(so_actor, 4);
}

function IsPhase1Completed(so_actor)
{
    local mech_1_health = GetHealth("MECH_1");
    return mech_1_health <= 0.01;
}

function IsPhase2Completed(so_actor)
{
    local mech_2_health = GetHealth("MECH_2");
    local mech_3_health = GetHealth("MECH_3");
    return mech_2_health <= 0.01 || mech_3_health <= 0.01;
}

function OnDeath(so_actor)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_Trophies_OnDeath_Boss") == true) Mod_Trophies_OnDeath_Boss (so_actor);
  if (this.rawin ("Mod_TurretsEverywhere_OnDeath_Boss") == true) Mod_TurretsEverywhere_OnDeath_Boss (so_actor, 2);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}
