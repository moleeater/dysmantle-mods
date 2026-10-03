// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-fix-from-storage.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function IsInteractionAvailable(so_self, so_activator)
{
  local num_investigated = Game_GetWorldStateAsInteger("OBELISKS", "num_investigated", 0);
  local powered = StageObject_GetKeyValue(so_self, "powered", false);

  if (abs(Game_GetAngleDifference(so_self, so_activator)) < 130)
  {
    return false;
  }

  return num_investigated >= 3 && !powered && !Game_IsShowingActorNotification(so_activator);
}


function OnInteraction(so_self, so_activator)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  local mod_fix_from_storage_is_done = false;
  if (this.rawin ("Mod_FixFromStorage_HoldDownButton_ArenaObelisk") == true) {
    local ret = Mod_FixFromStorage_HoldDownButton_ArenaObelisk (so_self, so_activator, "1xTOMB_ORB");
    if (ret != null) mod_fix_from_storage_is_done = ret;
  }
  if (mod_fix_from_storage_is_done == true || Game_ThrowMaterialsToActor(so_activator, so_self, "1xTOMB_ORB"))
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  {
    local quest_id = "quests/obelisk-intro.nut";
    Game_SendQuestPhaseCommandWord(quest_id, "COMPLETE", "activate");
    StageObject_SetKeyValueBoolean(so_self, "powered", true);
    Actor_PlayAnimation(so_self, "powered");
    Actor_SetInteractionEnabled(so_self, "power", false);
  }
  else
  {
    local text = LOC_TEXT("I should return with [REQUIRED_MATERIALS].");

    local cost = StageObject_GetKeyValue(so_self, "cost");
    text = string_replace(text, "[REQUIRED_MATERIALS]", "1x[MATERIAL_ICON="+cost+"][MATERIAL_NAME="+cost+"]");
    Game_AddActorNotification(so_activator, text);
  }
}
