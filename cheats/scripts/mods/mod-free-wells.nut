// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_FreeWells_OnGameStart_WishingWell (well, same) {
  if (Game_GetWorldStateAsInteger ("MODS", "free_wells_enabled", 0) == 1) {
    return "|img src='emojis/package.png' scale=0.5 offset=2| " + LocalizeText("Activate");
  }
}


function Mod_FreeWells_PressButtonUseIsInteractionAvailable_WishingWell (well, player) {
  if (Game_GetWorldStateAsInteger ("MODS", "free_wells_enabled", 0) == 1) {
    Actor_SetInteractionText (well, "use", "|img src='emojis/package.png' scale=0.5 offset=2| " + LocalizeText("Activate"));
  }
}


function Mod_FreeWells_PressButtonUseUse_WishingWell (well, player) {
  if (Game_GetWorldStateAsInteger ("MODS", "free_wells_enabled", 0) == 1) {
    return true;
  }
}


function Mod_FreeWells_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_free_wells_enabled":
        local enabled = UI_GetProperty ("mod_free_wells_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "free_wells_enabled", enabled ? "1" : "0");
        UI_SetVisible ("mod_free_wells_enabled_warning", true);
        break;
      case "mod_free_wells_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Free wells"),
            LocalizeText("Make your wishes come true for free at the Wishing Wells, you don't have to pay."));
        break;
    }
  }
}


function Mod_FreeWells_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetVisible ("mod_free_wells_enabled_warning", false);
  UI_SetProperty ("mod_free_wells_enabled_warning", "textbox.text", LocalizeText("To trigger the change, you need to rest at a campfire."));
  UI_SetProperty ("mod_free_wells_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "free_wells_enabled", 0));
  UI_SetProperty ("mod_free_wells_enabled_title", "textbox.text", LocalizeText("Free wells"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
