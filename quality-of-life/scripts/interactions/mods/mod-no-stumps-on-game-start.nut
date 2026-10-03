// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-no-stumps.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function OnInteraction (tree, same) {
  if (this.rawin ("Mod_NoStumps_OnGameStart_Tree") == true) Mod_NoStumps_OnGameStart_Tree (tree, same);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
