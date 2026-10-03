// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-starting-stage.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function OnInteraction(so_self, so_activator)
{
  local set_id = StageObject_GetKeyValue(so_self, "set", null);
  if (set_id != null)
  {
    local num = Game_GetWorldStateAsInteger("PET_HUB_PROGRESS", set_id, 0);
    local target = Game_GetWorldStateAsInteger("PET_HUB_PROGRESS_TARGET", set_id, 0);
    if (target < 2)
      target = 2; // Fixes temporary issue with saves.
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    if (this.rawin ("Mod_StartingStage_OnGameStart_PetStageExit_Circle") == true) {
      local ret = Mod_StartingStage_OnGameStart_PetStageExit_Circle (so_self, so_activator);
      if (ret != null) target = ret;
    }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    if (num < target)
    {
      StageObject_SetEnabled(so_self, false);
    }
    else
    {
      local so_tip = StageObject_GetKeyValue(so_self, "tip_actor", null);
      if (so_tip != null)
        StageObject_SetEnabled(so_tip, false);
    }
  }

  local is_pet_hub_teleporter = StageObject_GetKeyValue(so_self, "pet_hub_teleporter", false);
  if (is_pet_hub_teleporter)
  {
    // Check that are we returning to the position where we portaled in before.
    local kvs = Game_GetGlobalKeyValueStore("pet_hub_portal");
    if (kvs != null)
    {
      local target_stage = KeyValueStore_GetKeyValue(kvs, "teleport_from_stage");
      local target_pos = KeyValueStore_GetKeyValue(kvs, "teleport_target_pos");
      local is_open = KeyValueStore_GetKeyValue(kvs, "open", false);
      if (is_open && target_pos != null)
      {
        Actor_PlayAnimation(so_self, "pet_portal_active");
      }
      else
      {
        Actor_SetActorFlag(so_self, "ONLY_VISIBLE_IN_EDITOR", true);
      }
    }
  }
}
