// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-tabula-rasa-farms.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function OnInteraction (waterplane, same) {
  if (this.rawin ("Mod_TabulaRasaFarms_OnGameStart_WaterPlane") == true) Mod_TabulaRasaFarms_OnGameStart_WaterPlane (waterplane, same);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
