// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-keys-to-home.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function OnInteraction (hatch, same) {
  if (this.rawin ("Mod_KeysToHome_OnGameStart_ShelterEntryHatch") == true) Mod_KeysToHome_OnGameStart_ShelterEntryHatch (hatch, same);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
