// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-trophies.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-turrets-everywhere.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

local main_hive = "DOOMHIVE_BOSS_1";
local small_hives = ["DOOMHIVE_BOSS_2", "DOOMHIVE_BOSS_3", "DOOMHIVE_BOSS_4", "DOOMHIVE_BOSS_5"];
local hive_puids = []

local timer = 0;
local phase = 0;
local activated = false;

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
  }

  if (hive_puids.len() < 1 + small_hives.len())
  {
    AddHivePuid(main_hive);
    foreach (small_hive in small_hives)
    {
      AddHivePuid(small_hive);
    }
  }
}

function AddHivePuid(id)
{
  local so = StageObject_GetById(id);
  if (so != null)
  {
    local puid = StageObject_GetPersistentUniqueId(so);
    if (hive_puids.find(puid) == null)
    {
      hive_puids.append(puid);
    }
  }
}

function OnCommandWord(so_actor, command_word)
{
  if (!activated && command_word == "activate")
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

  local total_turret_health = GetHealth(main_hive);
  foreach (id in small_hives)
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

  foreach (id in small_hives)
  {
    SendCommand(id, "open");
  }

  SendCommand(main_hive, "open");

  local so = StageObject_GetById(main_hive);
  if (so != null)
  {
    StageObject_SetKeyValueBoolean(so, "invulnerable", true);
  }
}

function InitializePhase2(so_actor)
{
  phase = 2;

  local so = StageObject_GetById(main_hive);
  if (so != null)
  {
    StageObject_SetKeyValueBoolean(so, "invulnerable", false);
  }
}

function IsPhase1Completed(so_actor)
{
  local health = 0;
  foreach (id in small_hives)
  {
    health += GetHealth(id);
  }

  return health <= 0;
}

function OnActivate(so_actor)
{
  Game_ShowActorHitPointsBar(so_actor);
  InitializePhase1(so_actor);
}

function OnDeath(so_actor)
{
  foreach (puid in hive_puids)
  {
    Game_MarkStageObjectPUIDPersistentlyDestroyed(puid, true);
  }
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_Trophies_OnDeath_Boss") == true) Mod_Trophies_OnDeath_Boss (so_actor);
  if (this.rawin ("Mod_TurretsEverywhere_OnDeath_Boss") == true) Mod_TurretsEverywhere_OnDeath_Boss (so_actor, 1);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}
