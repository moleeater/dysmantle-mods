// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


local is_backpack_screen = false;


function Mod_BiggerBackpack_OnScreenMessage_PopupMessage (key, value) {
  if (key != null) {
    switch (key) {
      case "Mode":
        if (value == "MOD_BIGGER_BACKPACK") {
          is_backpack_screen = true;
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


function Mod_BiggerBackpack_OnLeave_PopupMessage() {
  is_backpack_screen = false;
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


function Mod_BiggerBackpack_OnClick_PopupMessage (clicked) {
  if (is_backpack_screen == true && clicked != null) {
    switch (clicked) {
      case "fader":
        UI_PopScreen();
        break;
      case "Button_0":
        if (Game_GetWorldState ("MODS", "bigger_backpack_used") != "1") {
          Game_SetWorldState ("MODS", "bigger_backpack_used", "1");
        }
        local current_level = Game_GetRecipeUpgradeLevel ("BACKPACK");
        if (current_level != null && current_level < 31) {
          for (local level = current_level + 1; level <= 31; level++) {
            Game_UpgradeRecipe ("BACKPACK");
          }
        }
        foreach (rarity in [ "COMMON", "UNCOMMON", "RARE" ]) {
          Game_CraftRecipe ("COMPRESSOR_" + rarity, false);
        }
        for (local recipe_node_index = 0; recipe_node_index < DM_GetArrayNumberOfNodes ("dysmantle/recipes-mod-cheats.xml", "RECIPES"); recipe_node_index++) {
          local recipe_id = DM_GetArrayNodeValue ("dysmantle/recipes-mod-cheats.xml", "RECIPES", recipe_node_index, "id");
          if (recipe_id.len() > 11 && recipe_id.slice(0, 11) == "COMPRESSOR_") {
            Game_CraftRecipe (recipe_id, false);
          }
        }
        UI_SendScreenMessage ("OptionsUnified", "mod_bigger_backpack_active", "0");
        UI_SendScreenMessage ("Stage", "mod_bigger_backpack_ui_update", "1");
        break;
    }
  }
}


function Mod_BiggerBackpack_OnScreenMessage_OptionsUnified (key, value) {
  if (key == "mod_bigger_backpack_active") {
    UI_SetProperty ("mod_bigger_backpack_craft", "active", value == "1");
  }
}


function Mod_BiggerBackpack_OnScreenMessage_Stage (key, value) {
  if (key == "mod_bigger_backpack_ui_update") {
    local is_hacked = UI_GetProperty ("Materials", "aligner.fixed_num_rows") == 2;
    local level = Game_GetRecipeUpgradeLevel ("BACKPACK");
    UI_SetProperty ("Materials", "position.y", is_hacked ? 0.995 : (level != null && level > 6 ? 0.95 : 0.98));
  }
}


function Mod_BiggerBackpack_OnUpdate_ProtagonistReactions (player) {
  UI_SendScreenMessage ("Stage", "mod_bigger_backpack_ui_update", "1");
}


function Mod_BiggerBackpack_OnEnter_Stage() {
  if (Game_GetRecipeUpgradeLevel ("BACKPACK") == 31 && Game_IsRecipeCrafted ("COMPRESSOR_PLANTS") != true) {
    foreach (rarity in [ "COMMON", "UNCOMMON", "RARE" ]) {
      Game_CraftRecipe ("COMPRESSOR_" + rarity, false);
    }
    for (local recipe_node_index = 0; recipe_node_index < DM_GetArrayNumberOfNodes ("dysmantle/recipes-mod-cheats.xml", "RECIPES"); recipe_node_index++) {
      local recipe_id = DM_GetArrayNodeValue ("dysmantle/recipes-mod-cheats.xml", "RECIPES", recipe_node_index, "id");
      if (recipe_id.len() > 11 && recipe_id.slice(0, 11) == "COMPRESSOR_") {
        Game_CraftRecipe (recipe_id, false);
      }
    }
  }
  UI_SendScreenMessage ("Stage", "mod_bigger_backpack_ui_update", "1");
}


function Mod_BiggerBackpack_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_bigger_backpack_craft":
        UI_SendScreenMessage ("PopupMessage", "Mode", "MOD_BIGGER_BACKPACK");
        UI_ShowPopup (
          "|img src='emojis/package.png' scale=1.3 offset=2| " + LocalizeText("Bigger backpack"),
          LocalizeText("Get +24 backpack notches per material slots, increasing the backpack capacity to 4x."),
          LocalizeText("Craft") + "," + LocalizeText("Cancel"));
        break;
      case "mod_bigger_backpack_title":
        Mods_Info_Popup (
            LocalizeText("Bigger backpack"),
            LocalizeText("Get +24 backpack notches per material slots, increasing the backpack capacity to 4x.")
                + "\n" + LocalizeText("Also adds compressors for every rarity and material type, so 1 notch can have 3 materials."));
        break;
    }
  }
}


function Mod_BiggerBackpack_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_bigger_backpack_craft", "active", Game_GetRecipeUpgradeLevel ("BACKPACK") == 31 ? false : true);
  UI_SetProperty ("mod_bigger_backpack_craft", "button.text", LocalizeText("Craft"));
  UI_SetProperty ("mod_bigger_backpack_title", "textbox.text", LocalizeText("Bigger backpack"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
