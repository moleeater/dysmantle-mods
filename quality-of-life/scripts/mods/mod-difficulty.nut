// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_Difficulty_OnSetupNewGame (test_game_start_id, player) {
  if (Profile_GetValue ("!SAVE_STATE", "mod_difficulty", "new_game_plus") == "true") {
    Profile_SetValue ("!SAVE_STATE", "mod_difficulty", "new_game_plus", "");
  } else {
    local difficulty = DM_GetArrayNodeValue ("save://index.xml", "!SETTINGS", "KeyValue_FLOAT_mod_difficulty", "value");
    if (difficulty != null) {
      local new_game_plus_cycles = round(difficulty.tofloat()).tostring();
      Profile_SetValue ("PLAYER_STATE", "new_game_plus_cycles", "value", new_game_plus_cycles);
      Game_LogEvent ("MOD_DIFFICULTY", new_game_plus_cycles);
    }
  }
}


function Mod_Difficulty_OnClick_FirstGameOptions (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "KeyValue_FLOAT_mod_difficulty":
        local slider_value = UI_GetProperty ("KeyValue_FLOAT_mod_difficulty", "slider.value");
        UI_SetProperty ("mod_difficulty_reload", "textbox.text", slider_value != null && round(slider_value.tofloat()) > 0 ? LocalizeText("You must save and reload after the game started!") : "");
        if (slider_value != null && round(slider_value.tofloat()) > 0) {
          UI_SetVisible ("mod_difficulty_reload", true);
        }
        break;
      case "mod_difficulty_title":
        Mods_Info_Popup (
            LocalizeText("Difficulty"),
            LocalizeText("Starting a new game allows you to set the cycle number, affecting enemy health, speed, damage and XP."));
        break;
    }
  }
}


function Mod_Difficulty_OnEnter_FirstGameOptions() {
  UI_SetProperty ("mod_difficulty_title", "textbox.text", "|img src='emojis/package.png' scale=0.7 offset=2|   " + LocalizeText("Difficulty"));
  UI_SetVisible ("mod_difficulty_reload", false);
}


function Mod_Difficulty_OnClick_NewGamePlus (clicked) {
  if (clicked == "StartNewGame") {
    Profile_SetValue ("!SAVE_STATE", "mod_difficulty", "new_game_plus", "true");
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
