// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_HomeGamePlus_PressButton_Respawner (respawner, player) {
  if (Stage_GetFilename() == "stages/shelters/surreal-shelter.stage") {
    UI_PushScreen ("NewGamePlus");
    return false;
  }
}


function Mod_HomeGamePlus_OnEnter_Stage() {
  if (Game_GetNewGamePlusCycleNumber() > 0 && Stage_GetFilename() == "stages/shelters/surreal-shelter.stage") {
    local respawner = Stage_CreateActor ("actors/objects/ark-lvl-3-respawner.xml", 585.0, 650.0, 4.0, false);
    StageObject_SetId (respawner, "respawner");
    StageObject_SetScale (respawner, 0.85);
    StageObject_SetAngle (respawner, 77.0);
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
