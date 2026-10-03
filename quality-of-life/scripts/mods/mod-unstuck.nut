// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-starting-stage.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


local is_unstuck_screen = false;


function Mod_Unstuck_OnScreenMessage_PopupMessage (key, value) {
  if (key != null) {
    switch (key) {
      case "Mode":
        if (value == "MOD_UNSTUCK") {
          is_unstuck_screen = true;
          UI_SetProperty ("panel", "ninepatch.automatic_content_padding", 35);
          UI_SetProperty ("panel", "ninepatch.automatic_content_width", true);
          UI_SetProperty ("aligner_2", "aligner.min_padding", 35);
          UI_SetProperty ("aligner_2", "aligner.automatic_area_width", true);
          UI_SetProperty ("marker_1", "marker.area_height", 1);
          UI_SetProperty ("Title", "textbox.textbox_width", 600);
          UI_SetProperty ("Text", "textbox.textbox_width", 500);
          UI_SetProperty ("aligner_1", "aligner.layout", 1);
          UI_SetProperty ("aligner_1", "aligner.min_padding", 0);
          UI_SetProperty ("aligner_1", "aligner.align_y_axis", false);
          UI_SetProperty ("aligner_1", "aligner.area_width", 550.0);
          UI_SetProperty ("Button_1", "selection_priority", 15);
          UI_SetVisible ("marker_2", false);
          foreach (button_num in [0,1]) {
            UI_SetProperty ("Button_" + button_num.tostring(), "button.ninepatch_margin", 20);
          }
        }
        break;
    }
  }
}


function Mod_Unstuck_OnLeave_PopupMessage() {
  is_unstuck_screen = false;
  UI_SetProperty ("panel", "ninepatch.automatic_content_padding", 14);
  UI_SetProperty ("aligner_2", "aligner.min_padding", 16);
  UI_SetProperty ("marker_1", "marker.area_height", 35);
  UI_SetProperty ("Title", "textbox.textbox_width", 752);
  UI_SetProperty ("Text", "textbox.textbox_width", 705);
  UI_SetProperty ("aligner_1", "aligner.layout", 0);
  UI_SetProperty ("aligner_1", "aligner.align_y_axis", true);
  UI_SetProperty ("aligner_1", "aligner.min_padding", 0.1);
  UI_SetProperty ("aligner_1", "aligner.area_width", 814.0);
  UI_SetVisible ("marker_2", true);
  UI_SetProperty ("Button_1", "selection_priority", 10);
  UI_SetProperty ("aligner_2", "aligner.automatic_area_width", true);
  UI_SetProperty ("panel", "ninepatch.automatic_content_width", true);
}


function Mod_Unstuck_OnClick_PopupMessage (clicked) {
  if (is_unstuck_screen == true && clicked != null) {
    switch (clicked) {
      case "fader":
        UI_PopScreen();
        break;
      case "Button_0":
        UI_PopScreen ("PauseMenu");
        Game_LogEvent ("MOD_UNSTUCK");
        if (this.rawin ("Mod_StartingStage_OnClick_PopupMessage") == true) {
          local ret = Mod_StartingStage_OnClick_PopupMessage();
          if (ret != null) return ret;
        }
        Game_FastTravelToExternalStagePointOfInterest ("stages/island/index.xml", "HOME_SHELTER");
        break;
    }
  }
}


function Mod_Unstuck_OnClick_PauseMenu (clicked) {
  if (clicked == "mod_unstuck") {
    UI_SendScreenMessage ("PopupMessage", "Mode", "MOD_UNSTUCK");
    UI_ShowPopup (
      "|img src='emojis/package.png' scale=1.3 offset=2| " + LocalizeText("Unstuck"),
      LocalizeText("Fast travel to starting shelter?"),
      LocalizeText("Unstuck") + "," + LocalizeText("Cancel"));
  }
}


function Mod_Unstuck_OnEnter_PauseMenu() {
  UI_SetVisible ("marker_spacer3", false);
  UI_SetProperty ("mod_unstuck", "button.text", LocalizeText("UNSTUCK"));
  UI_SetVisible ("mod_unstuck", true);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
