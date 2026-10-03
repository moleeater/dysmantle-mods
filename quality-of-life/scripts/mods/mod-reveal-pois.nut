// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local is_revealpoi_screen = false;


Include ("scripts/mods/mods-info.nut");


function Mod_RevealPOIs_OnScreenMessage_PopupMessage (key, value) {
  if (key != null) {
    switch (key) {
      case "Mode":
        if (value == "MOD_REVEALPOIS") {
          is_revealpoi_screen = true;
          UI_SetProperty ("panel", "ninepatch.automatic_content_padding", 35);
          UI_SetProperty ("panel", "ninepatch.automatic_content_width", true);
          UI_SetProperty ("aligner_2", "aligner.min_padding", 25);
          UI_SetProperty ("aligner_2", "aligner.automatic_area_width", true);
          UI_SetProperty ("marker_1", "marker.area_height", 1);
          UI_SetProperty ("Title", "textbox.textbox_width", 600);
          UI_SetProperty ("Text", "textbox.textbox_width", 480);
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


function Mod_RevealPOIs_OnLeave_PopupMessage() {
  is_revealpoi_screen = false;
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


function Mod_RevealPOIs_OnClick_PopupMessage (clicked) {
  if (is_revealpoi_screen == true && clicked != null) {
    switch (clicked) {
      case "fader":
        UI_PopScreen();
        break;
      case "Button_0":
        UI_SendScreenMessage ("OptionsUnified", "mod_reveal_pois_ui_update", "1");
        Game_LogEvent ("MOD_REVEALPOIS");
        local stage = Stage_GetFilename();
        local pois = stage.slice(0, stage.len() - 10) + "/points-of-interest.xml";
        for (local pois_node_index = 0; pois_node_index < DM_GetArrayNumberOfNodes (pois, stage); pois_node_index++) {
          local so_id = DM_GetArrayNodeValue (pois, stage, pois_node_index, "so_id");
          local requires_iap = DM_GetArrayNodeValue (pois, stage, pois_node_index, "requires_iap");
          if (so_id != null && so_id != ""
          && (requires_iap == null || requires_iap == "" || IAP_IsItemPurchased (requires_iap) == true)) {
            Game_RevealPointOfInterestOnMap (so_id);
          }
        }
        local stage_kvs = Stage_GetKeyValueStore();
        if (stage_kvs != null) {
          KeyValueStore_SetKeyValueBoolean (stage_kvs, "mod_reveal_pois_all", true);
          local kvp = KeyValueStore_GetKeyValueAsPointer (stage_kvs, "mod_reveal_pois_all");
          if (kvp != null) {
            KeyValueStore_SetFlagForKeyValue (kvp, "SAVE_STATE", true);
          }
        }
        break;
    }
  }
}


function Mod_RevealPOIs_OnScreenMessage_OptionsUnified (key, value) {
  if (key == "mod_reveal_pois_ui_update") {
    UI_SetProperty ("mod_reveal_pois_activate", "active", false);
  }
}


function Mod_RevealPOIs_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_reveal_pois_activate":
        UI_SendScreenMessage ("PopupMessage", "Mode", "MOD_REVEALPOIS");
        UI_ShowPopup (
          "|img src='emojis/package.png' scale=1.3 offset=2| " + LocalizeText("Reveal POIs"),
          LocalizeText("Spoil exploration and show all points of interests on the current map.")
            + "\n\n" + LocalizeText("Revealing is irreversible, you can never remove the POIs."),
          LocalizeText("Activate") + "," + LocalizeText("Cancel"));
        break;
      case "mod_reveal_pois_title":
        Mods_Info_Popup (
            LocalizeText("Reveal POIs"),
            LocalizeText("Spoil exploration and show all points of interests on the current map."));
        break;
    }
  }
}


function Mod_RevealPOIs_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_reveal_pois_activate", "button.text", LocalizeText("Activate"));
  UI_SetProperty ("mod_reveal_pois_title", "textbox.text", LocalizeText("Reveal POIs"));
  UI_SetProperty ("mod_reveal_pois_activate", "active", false);
  local stage = Stage_GetFilename();
  if (stage != null && stage.len() >= 10 && stage.slice(stage.len() - 10) == "/index.xml") {
    local pois = stage.slice(0, stage.len() - 10) + "/points-of-interest.xml";
    if (NX_FileExists (pois) == true) {
      local stage_kvs = Stage_GetKeyValueStore();
      if (stage_kvs == null || KeyValueStore_GetKeyValue (stage_kvs, "mod_reveal_pois_all", false) != true) {
        UI_SetProperty ("mod_reveal_pois_activate", "active", true);
      }
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
