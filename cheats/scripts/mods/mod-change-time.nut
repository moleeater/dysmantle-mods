// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local now = 0.0;


function Mod_ChangeTime_OnClick_WorldStateEditor (clicked) {
  if (clicked == "TimeOfDay") {
    local value = UI_GetProperty (clicked, "slider.value");
    if (value != null) {
      if (value > 0.995) {
        UI_SetProperty (clicked, "slider.value", 0.995);
      } else if (value < now) {
        UI_SetProperty (clicked, "slider.value", now);
      }
    }
  }
}


function Mod_ChangeTime_OnEnter_WorldStateEditor() {
  now = Game_GetWorldTimeRelativeDayBetween0And1AfterMidnight();
  if (now == null) {
    UI_PopScreen ("WorldStateEditor");
  } else {
    UI_SetProperty ("panel", "ninepatch.rectangle_height", 90);
    UI_SetProperty ("panel", "position.y", 0.1);
    UI_SetProperty ("Close", "position.y", -0.3);
    UI_SetProperty ("TimeOfDayTitle2", "localize", false);
    UI_SetProperty ("TimeOfDayTitle2", "textbox.text", "Change time");
    UI_SetProperty ("DeveloperPanel2", "ninepatch.rectangle_height", 50);
    UI_SetProperty ("DeveloperPanel2", "position.y", -0.15);
    UI_SetVisible ("ReloadTimeOfDayDefinitions", false);
    UI_SetProperty ("TimeOfDayTitle", "align", NX_ALIGN_BOTTOM);
    UI_SetProperty ("TimeOfDayTitle", "scale", 1.2);
    UI_SetProperty ("TimeOfDayTitle", "position.y", -1);
    UI_SetProperty ("TimeOfDay", "align", NX_ALIGN_BOTTOM);
    UI_SetProperty ("TimeOfDay", "position.y", 0.8);
    UI_SetProperty ("TimeOfDay", "slider.value", now);
  }
}


function Mod_ChangeTime_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_change_time_use":
        UI_PopScreen ("OptionsUnified");
        UI_PopScreen ("PauseMenu");
        UI_PushScreen ("WorldStateEditor");
        break;
      case "mod_change_time_title":
        Mods_Info_Popup (
            LocalizeText("Change time"),
            LocalizeText("Set time of the current day on a popup slider."));
        break;
    }
  }
}


function Mod_ChangeTime_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_change_time_use", "button.text", LocalizeText("Use"));
  UI_SetProperty ("mod_change_time_title", "textbox.text", LocalizeText("Change time"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
