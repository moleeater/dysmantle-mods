// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_DidIDieded_OnUpdate_PauseMenu (tdelta) {
  UI_SetProperty ("PlayerProgressDesc", "textbox.text", "|img src='map/icon-player-death-position.png'| x " + Game_GetNumberOfTimesDied() + "      |img src='map/icon-hatch.png'| x " + Game_GetNewGamePlusCycleNumber());
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
