// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-link-gas-leaks.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function OnInteraction (gascloud, same) {
  if (this.rawin ("Mod_LinkGasLeaks_OnGameStart_GasCloud") == true) Mod_LinkGasLeaks_OnGameStart_GasCloud (gascloud, same);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
