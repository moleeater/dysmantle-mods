// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-starting-stage.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function OnInteraction (pad, same) {
  if (this.rawin ("Mod_StartingStage_OnGameStart_EscapepodLaunchpad") == true) Mod_StartingStage_OnGameStart_EscapepodLaunchpad (pad, same);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
