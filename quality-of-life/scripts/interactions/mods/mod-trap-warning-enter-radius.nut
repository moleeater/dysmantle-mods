// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-trap-warning.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function OnActorEntersRadius (trappit, player) {
  if (this.rawin ("Mod_TrapWarning_OnActorEntersRadius_TrapPit") == true) Mod_TrapWarning_OnActorEntersRadius_TrapPit (trappit, player);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
