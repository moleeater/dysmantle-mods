// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-dodge-cliffs.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function OnInteraction (cliff, player) {
  if (this.rawin ("Mod_DodgeCliffs_OnCollidedInto_Cliff") == true) Mod_DodgeCliffs_OnCollidedInto_Cliff (cliff, player);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
