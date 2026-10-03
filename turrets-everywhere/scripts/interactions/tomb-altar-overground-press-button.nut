// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-turrets-everywhere.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function IsInteractionAvailable(so_self, so_activator)
{
  return !StageObject_GetKeyValue(so_self, "open", false);
}


function OnInteraction(so_self, so_activator)
{
  Actor_PlayAnimation(so_self,"open");
  Actor_ClearActionQueue(so_activator);
  Actor_QueueActionWait(so_activator, 0.5);
  Game_SpawnMaterials(so_self, so_activator, "TOMB_ORB");
//    Actor_QueueActionSendCommandWord(so_activator, so_activator, "tomb_reward");
  Game_SetStagePointOfInterestCompleted(so_self);
  StageObject_SetKeyValueBoolean(so_self, "looted", true);
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_TurretsEverywhere_PressButton_TombAltarOverground") == true) Mod_TurretsEverywhere_PressButton_TombAltarOverground (so_self, so_activator);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}
