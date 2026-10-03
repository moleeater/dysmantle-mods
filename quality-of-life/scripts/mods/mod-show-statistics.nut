// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_ShowStatistics_OnClick_PauseMenu (clicked) {
  if (clicked == "mod_show_statistics") {
    Game_LogEvent ("MOD_SHOW_STATISTICS");
    UI_PushScreen ("EndStatistics");
  }
}


function Mod_ShowStatistics_OnEnter_PauseMenu() {
  UI_SetProperty ("mod_show_statistics", "button.text", "|#c0c0c0||img src='emojis/package.png' scale=2 offset=2||#000000|  " + LocalizeText("Lose unsaved progress and Show Statistics"));
  UI_SetVisible ("mod_show_statistics", true);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
