// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-auto-gasmask.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function OnInteraction(so_self, so_activator)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_AutoGasmask_OnActorEntersRadius200Warning_GasCloud") == true) {
    if (Mod_AutoGasmask_OnActorEntersRadius200Warning_GasCloud (so_self, so_activator) == true) return false;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  local tags = KeyValueStore_GetKeyValue (Game_GetAllPlayerModifiersAsKeyValueStore (so_activator), "tags");
  if (tags == null || ! Tags_ContainsTag (tags, "GAS_IMMUNITY")) {
    Game_AddActorNotification (so_activator, LOC_TEXT("The gas is getting to my lungs. I need a [GREEN]Gas Mask[WHITE]."));
    Actor_PlayAnimation (so_activator, "cough");
  }
}
