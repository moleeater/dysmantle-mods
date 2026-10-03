// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-starting-stage.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function OnInteraction (pet_stage_exit, same) {
  if (this.rawin ("Mod_StartingStage_OnGameStart_PetStageExit_Main") == true) Mod_StartingStage_OnGameStart_PetStageExit_Main (pet_stage_exit, same);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
