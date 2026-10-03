// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_SleepAnytime_OnClick_Sleep (clicked) {
  if (clicked != null && clicked.len() > 7 && clicked.slice(0, 6) == "Sleep_" && clicked.slice(clicked.len() - 1) == "h"
  && Game_GetWorldStateAsInteger ("MODS", "sleep_anytime_enabled", 0) == 1) {
    if (this.rawin("Game_SetLastTimeSlept") != true) {
      Engine_Warning("Sleep anytime mod ERROR: update your game to at least v1.4.0.40");
    } else {
      Game_SetLastTimeSlept (1);
    }
  }
}


function Mod_SleepAnytime_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_sleep_anytime_enabled":
        local enabled = UI_GetProperty ("mod_sleep_anytime_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "sleep_anytime_enabled", enabled ? "1" : "0");
        break;
      case "mod_sleep_anytime_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Sleep anytime"),
            LocalizeText("Remove sleep limitation, you don't have to wait hours between sleeps."));
        break;
    }
  }
}


function Mod_SleepAnytime_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_sleep_anytime_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "sleep_anytime_enabled", 0));
  UI_SetProperty ("mod_sleep_anytime_enabled_title", "textbox.text", LocalizeText("Sleep anytime"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
