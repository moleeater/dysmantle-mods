// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_IgnoreDeathCounter_HoldDownButton_PyramidTombKingSarcophage (sarcophage, player) {
  if (Game_GetWorldStateAsInteger ("MODS", "ignore_death_counter_enabled", 0) == 1) {
    return 0;
  }
}


function Mod_IgnoreDeathCounter_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_ignore_death_counter_enabled":
        local enabled = UI_GetProperty ("mod_ignore_death_counter_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "ignore_death_counter_enabled", enabled ? "1" : "0");
        break;
      case "mod_ignore_death_counter_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Ignore death counter"),
            LocalizeText("Bypass the number of deaths check when opening the sarcophage in the King's Tomb pyramid."));
        break;
    }
  }
}


function Mod_IgnoreDeathCounter_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_ignore_death_counter_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "ignore_death_counter_enabled", 0));
  UI_SetProperty ("mod_ignore_death_counter_enabled_title", "textbox.text", LocalizeText("Ignore death counter"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
