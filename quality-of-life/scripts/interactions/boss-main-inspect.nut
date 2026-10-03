// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-extract-barrier.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function IsInteractionAvailable(so_self, so_activator)
{
  if (Game_GetWorldState("MAIN_QUEST", "scanned_fuel_cells") == null)
    return false;
  if (Game_GetWorldState("BOSS", "looted_" + StageObject_GetPersistentUniqueId(so_self).tostring()) != null)
    return false;
  return Actor_GetAttributeHitPoints(so_self) > 10;
}

function SetSpawnersActive(so_self, enabled)
{
  local pos = StageObject_GetStagePosition(so_self);
  local list = Stage_QueryActorsWithTypeInRadius(pos[0], pos[1], pos[2], 1000, "actors/interactives/spawner.xml");
  foreach (so in list)
  {
    StageObject_SetKeyValueBoolean(so, "active", enabled);
  }
}

function OnInteraction(so_self, so_activator)
{
  local kvs = Stage_GetKeyValueStore();
  KeyValueStore_SetKeyValueFloat(kvs, "camera_distance_modifier", 400);
  Stage_SendStageObjectCommandWord(so_self, "activate");
  Actor_QueueActionStopAnimationWithTransition(so_self, "sleeping", "wake_up_initial", true);
  Game_ShowActorHitPointsBar(so_self);
  local name = StageObject_GetKeyValueStringLocalized(so_self, "name");
  Game_ShowBossTitle(name, 3, 5);
  local barrier = StageObject_GetKeyValue(so_self, "barrier");
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_ExtractBarrier_PressButtonUseInspect_BossMain") == true) {
    local ret = Mod_ExtractBarrier_PressButtonUseInspect_BossMain (so_self, so_activator, barrier);
    if (ret != null) barrier = ret;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  if (barrier != null)
    StageObject_SetEnabled(barrier, true);
  SetSpawnersActive(so_self, true);
}
