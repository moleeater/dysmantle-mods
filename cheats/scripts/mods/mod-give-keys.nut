// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local is_keys_screen = false;


function Mod_GiveKeys_OnScreenMessage_Cheats (key, value) {
  if (key != null) {
    switch (key) {
      case "Mode":
        if (value == "MOD_GIVE_KEYS") {
          is_keys_screen = true;
          UI_SetVisible ("panel2", false);
          UI_SetVisible ("panel3", false);
          UI_SetVisible ("panel4", false);
          UI_SetVisible ("panel5", false);
          UI_SetVisible ("mod_give_keys_panel", true);
          UI_SetProperty ("Title", "localize", false);
          UI_SetProperty ("Title", "textbox.text", "|img src='emojis/package.png' scale=0.7 offset=2|  Give keys");
          UI_SetProperty ("mod_give_keys_give", "button.text", "|img src='emojis/thumbs up.png' scale=0.5 offset=2|");
          UI_SetProperty ("mod_give_keys_lose", "button.text", "|img src='emojis/cross mark.png' scale=0.5 offset=2|");
        }
        break;
    }
  }
}


function Mod_GiveKeys_OnEnter_Cheats() {
  UI_AddDropDownListLine ("mod_give_keys_dropdown", 0, "-");
  foreach (dlc in [ "", "DLC1", "DLC2", "DLC3" ]) {
    if (dlc == "" || IAP_IsItemPurchased (dlc) == true) {
      local collection = "dysmantle/collection" + (dlc == "" ? "" : "-" + dlc.toupper()) + ".xml"
      for (local keys_node_index = 0; keys_node_index < DM_GetArrayNumberOfNodes (collection, "KEYS"); keys_node_index++) {
        local key = DM_GetArrayNodeValue (collection, "KEYS", keys_node_index, "id");
        local recipe = DM_GetArrayNodeValue (collection, "KEYS", keys_node_index, "recipe");
        if (key != null && recipe == null) {
          local is_allowed = true;
          switch (key) {
            case "DLC3_VAULTROOM_DLC1_KEY":
              if (IAP_IsItemPurchased ("DLC3") != true || IAP_IsItemPurchased ("DLC1") != true) {
                is_allowed = false;
              }
              break;
            case "DLC3_VAULTROOM_DLC2_KEY":
              if (IAP_IsItemPurchased ("DLC3") != true || IAP_IsItemPurchased ("DLC2") != true) {
                is_allowed = false;
              }
              break;
            case "KEYCARD_BLUE":
            case "KEYCARD_YELLOW":
            case "KEYCARD_RED":
              if (dlc == "") {
                is_allowed = false;
              }
              break;
          }
          if (is_allowed) {
            UI_AddDropDownListLine ("mod_give_keys_dropdown", key, Game_GetConvertedString ("[KEY_ICON=" + key + "] [KEY_NAME=" + key + "]"));
          }
        }
      }
    }
  }
}


function Mod_GiveKeys_OnClick_Cheats (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_give_keys_give":
      case "mod_give_keys_lose":
        local index = UI_GetProperty ("mod_give_keys_dropdown", "drop_down_list.selected_line_index");
        local key = index == null || index == 0 ? null : UI_GetDropDownListLineIdByIndex ("mod_give_keys_dropdown", index.tointeger());
        if (key != null) {
          switch (clicked) {
            case "mod_give_keys_give":
              if (Game_IsCollectibleFound ("KEYS", key) != true) {
                Game_SetCollectibleFound ("KEYS", key, true);
                Game_LogEvent ("MOD_GIVE_KEYS", key);
              }
              break;
            case "mod_give_keys_lose":
              if (Game_IsCollectibleFound ("KEYS", key) == true) {
                Game_SetCollectibleFound ("KEYS", key, false);
                Game_LogEvent ("MOD_GIVE_KEYS", "-" + key);
              }
              break;
          }
        }
        break;
    }
  }
}


function Mod_GiveKeys_OnLeave_Cheats() {
  is_keys_screen = false;
  UI_SetProperty ("Title", "textbox.text", "|img scale=1.1 offset=3 src='emojis/shushing face.png'| Cheats |img scale=1.1 offset=3 src='emojis/shushing face.png'|");
  UI_SetVisible ("panel2", true);
  UI_SetVisible ("panel3", true);
  UI_SetVisible ("panel4", true);
  UI_SetVisible ("panel5", true);
  UI_SetVisible ("mod_give_keys_panel", false);
  UI_RemoveAllDropDownListLines ("mod_give_keys_dropdown");
}


function Mod_GiveKeys_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_give_keys_use":
        UI_SendScreenMessage ("Cheats", "Mode", "MOD_GIVE_KEYS");
        UI_PushScreen ("Cheats");
        break;
      case "mod_give_keys_title":
        Mods_Info_Popup (
            LocalizeText("Give keys"),
            LocalizeText("Get any collectible keys without finding them or completing quests."));
        break;
    }
  }
}


function Mod_GiveKeys_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_give_keys_use", "button.text", LocalizeText("Use"));
  UI_SetProperty ("mod_give_keys_title", "textbox.text", LocalizeText("Give keys"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
