// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_WellPrepared_PressButtonUseTimeoutIsInteractionAvailable_WishingWell (well, player) {
  if (Game_GetWorldStateAsInteger ("MODS", "well_prepared_enabled", 0) == 1) {
    return false;
  }
}


function Mod_WellPrepared_PressButtonUseUseIsInteractionAvailable_WishingWell (well, player) {
  if (Game_GetWorldStateAsInteger ("MODS", "well_prepared_enabled", 0) == 1) {
    return Game_IsStoringMaterials() == true ? false : true;
  }
}


function Mod_WellPrepared_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_well_prepared_enabled":
        local enabled = UI_GetProperty ("mod_well_prepared_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "well_prepared_enabled", enabled ? "1" : "0");
        break;
      case "mod_well_prepared_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Well prepared"),
            LocalizeText("Replenish wishing wells immediatelly, you don't have to wait half an hour to use them again."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-well-prepared-video")}] );
        break;
    }
  }
}


function Mod_WellPrepared_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_well_prepared_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "well_prepared_enabled", 0));
  UI_SetProperty ("mod_well_prepared_enabled_title", "textbox.text", LocalizeText("Well prepared"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
