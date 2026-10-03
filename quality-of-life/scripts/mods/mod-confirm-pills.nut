// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-starting-stage.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


local is_confirm_screen = false;
local return_to_home_shelter_campfire = false;
local player_index = 0;


function Mod_ConfirmPills_OnTriggerDown_AmberPills (player, return_to_home_shelter_campfire, title, desc) {
  UI_SendScreenMessage ("PopupMessage", "Mode", "MOD_CONFIRM_PILLS");
  local player_index = Game_GetPlayerIndexByActor (player);
  UI_SendScreenMessage ("PopupMessage", "mod_confirm_pills_player_index", player_index == null ? "0" : player_index.tostring());
  UI_SendScreenMessage ("PopupMessage", "mod_confirm_pills_return_to_home_shelter_campfire_message", return_to_home_shelter_campfire == true ? "1" : "0");
  UI_ShowPopup ("|img src='emojis/package.png' scale=1.3 offset=2| " + LocalizeText(title), desc, LocalizeText("Use") + "," + LocalizeText("Cancel"));
}


function Mod_ConfirmPills_OnScreenMessage_PopupMessage (key, value) {
  if (key != null) {
    switch (key) {
      case "Mode":
        if (value == "MOD_CONFIRM_PILLS") {
          is_confirm_screen = true;
          UI_SetProperty ("panel", "ninepatch.automatic_content_width", true);
          UI_SetProperty ("aligner_2", "aligner.automatic_area_width", true);
          UI_SetProperty ("Title", "textbox.textbox_width", 700);
          UI_SetProperty ("Text", "scale", 2.0);
          UI_SetProperty ("Text", "textbox.textbox_width", 300);
          UI_SetProperty ("aligner_1", "aligner.area_width", 650.0);
          UI_SetProperty ("Button_1", "selection_priority", 15);
          foreach (button_num in [0,1]) {
            UI_SetProperty ("Button_" + button_num.tostring(), "button.ninepatch_margin", 20);
          }
        }
        break;
      case "mod_confirm_pills_player_index":
        player_index = value.tointeger();
        break;
      case "mod_confirm_pills_return_to_home_shelter_campfire_message":
        return_to_home_shelter_campfire = value == "1" ? true : false;
        break;
    }
  }
}


function Mod_ConfirmPills_OnClick_PopupMessage (clicked) {
  if (is_confirm_screen == true && clicked != null) {
    switch (clicked) {
      case "fader":
        UI_PopScreen();
        break;
      case "Button_0":
        if (this.rawin ("Mod_StartingStage_OnClick_PopupMessage") == true) {
          local ret = Mod_StartingStage_OnClick_PopupMessage (return_to_home_shelter_campfire);
          if (ret != null) return ret;
        }
        local player = Game_GetPlayerActor (player_index);
        StageObject_SetKeyValueBoolean (player, "return_to_home_shelter_campfire", return_to_home_shelter_campfire);
        if (Actor_IsAnimationPlaying (player, "eat") != true) {
          Actor_QueueActionPlayAnimationWithParameters (player, "eat", 1.0, 0.0, true);
        }
        break;
    }
  }
}


function Mod_ConfirmPills_OnLeave_PopupMessage() {
  is_confirm_screen = false;
  UI_SetProperty ("aligner_2", "aligner.automatic_area_width", false);
  UI_SetProperty ("Title", "textbox.textbox_width", 752);
  UI_SetProperty ("Text", "scale", 1.0);
  UI_SetProperty ("Text", "textbox.textbox_width", 705);
  UI_SetProperty ("aligner_1", "aligner.area_width", 814.0);
  UI_SetProperty ("Button_1", "selection_priority", 10);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
