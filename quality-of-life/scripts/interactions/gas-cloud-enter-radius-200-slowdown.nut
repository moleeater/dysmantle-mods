// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-auto-gasmask.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function OnActorEntersRadius(so_self, so_activator)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_AutoGasmask_OnActorEntersRadius200Slowdown_GasCloud") == true) {
    if (Mod_AutoGasmask_OnActorEntersRadius200Slowdown_GasCloud (so_self, so_activator) == true) return false;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  local tags = KeyValueStore_GetKeyValue (Game_GetAllPlayerModifiersAsKeyValueStore (so_activator), "tags");
  if (tags == null || ! Tags_ContainsTag (tags, "GAS_IMMUNITY")) {
    Game_SetTemporaryModifier (so_activator, "GAS_SLOWDOWN_MOVE_SPEED", 3.0, "move_speed_percentage_increase", -60);
    Game_SetTemporaryModifier (so_activator, "GAS_SLOWDOWN_RUNNING_SPEED", 3.0, "running_speed_percentage_increase", -100);
  }
}


function OnActorLeavesRadius(so_self, so_activator)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_AutoGasmask_OnActorLeavesRadius200Slowdown_GasCloud") == true) {
    if (Mod_AutoGasmask_OnActorLeavesRadius200Slowdown_GasCloud (so_self, so_activator) == true) return false;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  local tags = KeyValueStore_GetKeyValue (Game_GetAllPlayerModifiersAsKeyValueStore (so_activator), "tags");
  if (tags == null || ! Tags_ContainsTag (tags, "GAS_IMMUNITY")) {
    Game_SetTemporaryModifier (so_activator, "GAS_SLOWDOWN_MOVE_SPEED", 0, "move_speed_percentage_increase", 0);
    Game_SetTemporaryModifier (so_activator, "GAS_SLOWDOWN_RUNNING_SPEED", 0, "running_speed_percentage_increase", 0);
  }
}
