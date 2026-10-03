// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_NoPetting_PressButtonUseIsInteractionAvailable_AnimalFriend (animal, player) {
  if (StageObject_HasTag (animal, "PET") == true && StageObject_HasTag (animal, "POCKET_PET") != true) {
    StageObject_SetKeyValueBoolean (animal, "petting_allowed", false);
  }
  if (Game_GetWorldStateAsInteger ("MODS", "no_petting_enabled", 0) == 1) {
    return false;
  }
}


function Mod_NoPetting_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_no_petting_enabled":
        Game_SetWorldState ("MODS", "no_petting_enabled", UI_GetProperty ("mod_no_petting_enabled", "checkbox.value") == 1 ? "1" : "0");
        break;
      case "mod_no_petting_enabled_title":
        Mods_Info_Popup (
            LocalizeText("No petting"),
            LocalizeText("Disable petting of animals completely, without conditions. Never get annoyed again by accidentally petting instead of searching or gathering."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-no-petting-video")}] );
        break;
    }
  }
}


function Mod_NoPetting_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_no_petting_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "no_petting_enabled", 0));
  UI_SetProperty ("mod_no_petting_enabled_title", "textbox.text", LocalizeText("No petting"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
