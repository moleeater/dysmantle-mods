// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-starting-stage.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function IsInteractionAvailable(so_self, so_activator)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_StartingStage_OnActorEntersRadiusIsInteractionAvailable_ManaRiftTeleport") == true) {
    local ret = Mod_StartingStage_OnActorEntersRadiusIsInteractionAvailable_ManaRiftTeleport (so_self, so_activator);
    if (ret != null) return ret;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  if (Game_GetWorldStateAsInteger("MANA_RIFTS", "enabled") == 0)
    return false;

  return StageObject_GetKeyValue(so_self, "open");
}


function OnInteraction(so_self, so_activator)
{
  StageObject_SetKeyValueBoolean(so_self, "open", true);
  Actor_InteractWithInteraction(so_self, so_activator, "init");
  Game_SetStagePointOfInterestCompleted(so_self);
  local target_pos = StageObject_GetKeyValue(so_self, "teleport_target_pos");
  if (target_pos != null)
  {
    Game_TeleportPlayers(target_pos[0], target_pos[1], target_pos[2]);
    return;
  }
}
