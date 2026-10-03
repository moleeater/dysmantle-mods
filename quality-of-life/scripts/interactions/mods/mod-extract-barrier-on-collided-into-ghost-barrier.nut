// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-extract-barrier.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function OnInteraction (barrier, player) {
  if (this.rawin ("Mod_ExtractBarrier_OnCollidedInto_GhostBarrier") == true) Mod_ExtractBarrier_OnCollidedInto_GhostBarrier (barrier, player);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
