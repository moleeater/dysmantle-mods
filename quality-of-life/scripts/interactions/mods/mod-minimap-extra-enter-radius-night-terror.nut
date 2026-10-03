// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-minimap-extra.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function OnActorEntersRadius (terror, player) {
  if (this.rawin ("Mod_MinimapExtra_OnActorEntersRadius_Terror") == true) Mod_MinimapExtra_OnActorEntersRadius_Terror (terror, player);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
