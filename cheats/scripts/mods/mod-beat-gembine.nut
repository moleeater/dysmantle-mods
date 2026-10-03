// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_BeatGembine_OnClick_Gembine (clicked) {
  if (clicked == "mod_beat_gembine") {
    UI_SetVisible ("mod_beat_gembine", false);
    UI_SendScreenMessage ("Gembine", "HighScoreMade", "");
    Game_SetWorldState ("GEMBINE", "secret_opened", "1");
  }
}


function Mod_BeatGembine_OnEnter_Gembine() {
  if (Game_GetWorldStateAsInteger ("MODS", "beat_gembine_enabled", 0) == 1) {
    UI_SetProperty ("mod_beat_gembine", "button.text", "|#c0c0c0||img src='emojis/package.png' scale=1.5 offset=2||#000000|  " + LocalizeText("Cheat"));
    UI_SetVisible ("mod_beat_gembine", Game_GetWorldState ("GEMBINE", "secret_opened") == "1" ? false : true);
  }
}


function Mod_BeatGembine_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_beat_gembine_enabled":
        local enabled = UI_GetProperty ("mod_beat_gembine_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "beat_gembine_enabled", enabled ? "1" : "0");
        break;
      case "mod_beat_gembine_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Beat Gembine"),
            LocalizeText("Cheat Gembine, fake a high score win, open the ultimate secret reward."));
        break;
    }
  }
}


function Mod_BeatGembine_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_beat_gembine_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "beat_gembine_enabled", 0));
  UI_SetProperty ("mod_beat_gembine_enabled_title", "textbox.text", LocalizeText("Beat Gembine"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
