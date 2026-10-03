// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-defeat-horde.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function UpdateSpawnEntranceReference(so_self)
{
  local pos = StageObject_GetStagePosition(so_self);
  local at = "actors/objects/shelter-entry-hatch.xml";
  local spawn_entrance = Stage_QueryNearestActorWithType(pos[0], pos[1], pos[2], 2*20*60, at);
  if (spawn_entrance == null)
    return;
  StageObject_SetKeyValueStageObjectReference(so_self, "spawn_entrance", spawn_entrance);
}

function GetNumberOfWaves(so_self)
{
  local kvs = StageObject_GetKeyValueStore(so_self);
  local num = 0;

  for (local i = 0; i < 4; i++)
  {
    local path = KeyValueStore_GetKeyValue(kvs, "wave_" + i + "_actor_type");
    if (path == null)
      break;
    num++;
  }
  return num;
}

function VisualizePathDuring(so_self)
{
  local kvs = StageObject_GetKeyValueStore(so_self);
  local effect = "effects/shelter-horde-trail-visualization.xml";

  NX_PlaySound("sfx/path-visualization-whoosh", 0.7, 0.0, 1.0);

  for (local i = 0; i < 4; i++)
  {
    local kv_path = KeyValueStore_GetKeyValue(kvs, "walk_path_" + i);
    if (kv_path == null)
      return;
    Game_VisualizePathKeyValue(kv_path, so_self, effect, 5, 2, -10, false);
  }
}

function OnInteraction(so_self, so_activator)
{
  UpdateSpawnEntranceReference(so_self);

  local kvs = StageObject_GetKeyValueStore(so_self);
  local so_entrance = KeyValueStore_GetKeyValue(kvs, "spawn_entrance");
  if (so_entrance == null)
  {
    Engine_Warning("Spawn entrance not set!");
    return;
  }

  VisualizePathDuring(so_self);

  local tutorial_quest_id = "quests/shelter-defence.nut";
  if (!Game_IsQuestGoalCompleted(tutorial_quest_id, "PHASE_0", "BUILD_TURRETS"))
  {
    Game_AddActorNotification(so_activator, LOC_TEXT("I should build some defences first. Who knows how many monsters will come out of that old shelter."));
    Actor_QueueActionPlayAnimation(so_activator, "tool_equip", true);
    Game_RemoveAllBlockingPaths();
    return;
  }

  Game_LogEvent("SHELTER_DEFENCE", "START");
  Game_SaveGame(true);

  Stage_SendStageObjectCommandWord(so_activator, "gather_players");

  Actor_StopAnimationWithFade(so_self, "inactive_idle", 0);
  Actor_PlayAnimation(so_self, "activate_start");
  Actor_PlayAnimation(so_entrance, "spawning_monsters");

  StageObject_SetKeyValueInteger(so_self, "num_bursts_done", 0);
  StageObject_SetKeyValueInteger(so_self, "num_waves_done", 0);
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_DefeatHorde_HoldDownButtonUseActivate_EvacShelterLoudspeaker") == true) {
    Mod_DefeatHorde_HoldDownButtonUseActivate_EvacShelterLoudspeaker (so_self, so_activator, GetNumberOfWaves(so_self));
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  Actor_SetInteractionTriggerParameterFloat(so_self, "spawn_check", 0.5);

  local text_major = LOC_TEXT("Defend!");
  local text_minor;
  local num_waves = GetNumberOfWaves(so_self);
  if (num_waves < 2)
    text_minor = LOC_TEXT("Monsters incoming");
  else
    text_minor = LOC_TEXT("[NUMBER] waves of monsters incoming");
  text_minor = string_replace(text_minor, "[NUMBER]", num_waves);
  Game_AddMajorNotification("ui/gfx/icon-quest.png", "sfx/quest-new", text_major, text_minor, "TOP");

  Game_ShowActorHitPointsBar(so_self);

  Actor_SetInteractionEnabled(so_self, "spawn_check", true);

  Actor_QueueActionPlayAnimation(so_activator, "tool_equip", true);
  Actor_SetInteractionEnabled(so_self, "activate", false);

  Actor_PlayAnimation(so_entrance, "open");

  Game_SendQuestPhaseGoalCommandWord(tutorial_quest_id, "PHASE_0", "ACTIVATE_LOUDSPEAKER", "complete");

  local quest_id = StageObject_GetKeyValue(so_self, "quest_id");
  if (quest_id != null && quest_id != "")
    Game_ShowQuestStartDialog(quest_id, true);
}


function VisualizePath(so_self)
{
  local kvs = StageObject_GetKeyValueStore(so_self);
  local effect = "effects/shelter-horde-trail-visualization.xml";

  NX_PlaySound("sfx/path-visualization-whoosh", 0.7, 0.0, 1.0);

  for (local i = 0; i < 4; i++)
  {
    local kv_path = KeyValueStore_GetKeyValue(kvs, "walk_path_" + i);
    if (kv_path == null)
      return;
    Game_VisualizePathKeyValue(kv_path, so_self, effect, 5, 4, -10, true);
  }
}

function OnInteractionStarted(so_self, so_activator)
{
  local at = "actors/enemies/ex-human-underground-horde.xml";
  local rc = ActorType_GetReferenceCount(at);
  if (rc == 0)
    ActorType_LoadActorType(at, true);

  local blocking_path = StageObject_GetKeyValue(so_self, "shelter_defense_area");
  if (blocking_path != null)
    Game_AddBlockingPath(blocking_path);

  VisualizePath(so_self);
  Actor_ClearActionQueue(so_activator);
  Actor_QueueActionPlayAnimation(so_activator, "tool_unequip", false);
  //Actor_QueueActionMoveToBone(so_activator, so_self, "snap");
}


function OnInteractionCancelled(so_self, so_activator)
{
  Actor_QueueActionPlayAnimation(so_activator, "tool_equip", true);
  Game_RemoveAllBlockingPaths();
}
