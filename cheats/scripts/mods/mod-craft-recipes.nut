// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local is_craft_screen = false;


function Mod_CraftRecipes_OnScreenMessage_Cheats (key, value) {
  if (key != null) {
    switch (key) {
      case "Mode":
        if (value == "MOD_CRAFT_RECIPES") {
          is_craft_screen = true;
          UI_SetVisible ("panel2", false);
          UI_SetVisible ("panel4", false);
          UI_SetVisible ("panel5", false);
          UI_SetProperty ("Title", "localize", false);
          UI_SetProperty ("Title", "textbox.text", "Craft recipes");
          UI_SetProperty ("panel3", "position.y", -0.41);
          UI_SetProperty ("panel3", "ninepatch.rectangle_width", 760);
          UI_SetProperty ("panel3", "ninepatch.rectangle_height", 405);
          UI_SetProperty ("touchfield_1", "position.x", -0.49);
          UI_SetProperty ("touchfield_1", "position.y", 0.19);
          UI_SetProperty ("touchfield_1", "touchfield.area_width", 745);
          UI_SetProperty ("touchfield_1", "touchfield.area_height", 320);
          UI_SetProperty ("mod_craft_recipes_scrollbar", "scale", 1.0);
          UI_SetProperty ("mod_craft_recipes_scrollbar", "position.x", 0.0005);
          UI_SetProperty ("mod_craft_recipes_scrollbar", "position.y", 0.585);
          UI_SetProperty ("mod_craft_recipes_scrollbar", "slider.ninepatch_height", 310);
          UI_SetProperty ("all_recipes_unlocked", "textbox.text_vertical_spacing", 16);
          UI_SetProperty ("all_recipes_unlocked", "textbox.text_justify", true);
          UI_SetProperty ("all_recipes_locked", "textbox.text_vertical_spacing", 16);
          UI_SetProperty ("all_recipes_locked", "textbox.text_justify", true);
          UI_SetProperty ("all_recipes_locked", "position.x", 0.52);
          UI_SetProperty ("recipe_id", "position.x", -0.4);
          UI_SetProperty ("recipe_id", "position.y", 0.02);
          UI_SetProperty ("recipe_id", "editbox.ninepatch_width", 225);
          UI_SetProperty ("textbox_2", "position.x", -0.28);
          UI_SetProperty ("textbox_2", "position.y", 0.2);
          UI_SetProperty ("UnlockRecipe", "align", NX_ALIGN_TOP);
          UI_SetProperty ("UnlockRecipe", "position.x", 1.05);
          UI_SetProperty ("UnlockRecipe", "position.y", 0.03);
          UI_SetProperty ("CraftRecipe", "align", NX_ALIGN_TOP);
          UI_SetProperty ("CraftRecipe", "position.x", 1.55);
          UI_SetProperty ("CraftRecipe", "position.y", 0.03);
          UI_SetProperty ("ChangeRecipeUpgradeLevel", "align", NX_ALIGN_TOP);
          UI_SetProperty ("ChangeRecipeUpgradeLevel", "position.x", 2.05);
          UI_SetProperty ("ChangeRecipeUpgradeLevel", "position.y", 0.03);
          UI_SetProperty ("UncraftRecipe", "align", NX_ALIGN_TOP);
          UI_SetProperty ("UncraftRecipe", "position.x", 1.55);
          UI_SetProperty ("UncraftRecipe", "position.y", 1.2);
          UI_SetProperty ("LockRecipe", "align", NX_ALIGN_TOP);
          UI_SetProperty ("LockRecipe", "position.x", 2.05);
          UI_SetProperty ("LockRecipe", "position.y", 1.2);
          if (NX_ProductFeatureExists ("MOBILE_UI") == true) {
            UI_SetProperty ("recipe_id", "editbox.text_scale", 1.5);
            UI_SetProperty ("all_recipes_unlocked", "scale", 1.25);
            UI_SetProperty ("all_recipes_locked", "scale", 1.25);
          } else {
            UI_SetProperty ("all_recipes_unlocked", "textbox.textbox_width", 430);
            UI_SetProperty ("all_recipes_locked", "textbox.textbox_width", 430);
          }
        }
        break;
    }
  }
}


function Mod_CraftRecipes_OnClick_Cheats (clicked) {
  if (is_craft_screen && clicked != null) {
    switch (clicked) {
      case "UnlockRecipe":
      case "CraftRecipe":
      case "ChangeRecipeUpgradeLevel":
      case "UncraftRecipe":
      case "LockRecipe":
        local recipe_id = UI_GetProperty ("recipe_id", "editbox.text");
        if (recipe_id != null) {
          recipe_id = strip (recipe_id);
          if (recipe_id != "") {
            local failed = false;
            local recipe_files = NX_FindFiles ("dysmantle", "recipes*.xml", false);
            if (recipe_files != null && recipe_files.len() > 0) {
              foreach (recipe_file in recipe_files) {
                if (DM_GetArrayNodeValue (recipe_file, "RECIPES", recipe_id, "id") == recipe_id) {
                  local requires_iap = DM_GetArrayNodeValue (recipe_file, "RECIPES", recipe_id, "requires_iap");
                  if (requires_iap != null && IAP_IsItemPurchased (requires_iap) != true) {
                    UI_SetProperty ("recipe_id", "editbox.text", "");
                    local dlc_name = DM_GetArrayNodeValue ("in-app-purchases/in-app-purchases.xml", "ITEMS", requires_iap, "name")
                    Engine_ShowPopup ("DLC missing", dlc_name != null ? dlc_name : requires_iap, "OK", "Cheats", "mod_craft_recipes_popup");
                    failed = true;
                  }
                  break;
                }
              }
            }
            if (! failed) {
              Game_LogEvent ("MOD_CRAFT_RECIPES", (["UncraftRecipe","LockRecipe"].find(clicked) != null ? "-" : "") + recipe_id);
            }
          }
        }
        break;
    }
  }
}


function Mod_CraftRecipes_OnLeave_Cheats() {
  is_craft_screen = false;
  UI_SetProperty ("Title", "textbox.text", "|img scale=1.1 offset=3 src='emojis/shushing face.png'| Cheats |img scale=1.1 offset=3 src='emojis/shushing face.png'|");
  UI_SetProperty ("panel3", "position.y", -0.154);
  UI_SetProperty ("panel3", "ninepatch.rectangle_width", 733);
  UI_SetProperty ("panel3", "ninepatch.rectangle_height", 162);
  UI_SetProperty ("touchfield_1", "position.x", -0.182);
  UI_SetProperty ("touchfield_1", "position.y", 0.052);
  UI_SetProperty ("touchfield_1", "touchfield.area_width", 495);
  UI_SetProperty ("touchfield_1", "touchfield.area_height", 149);
  UI_SetProperty ("mod_craft_recipes_scrollbar", "scale", 0.5);
  UI_SetProperty ("mod_craft_recipes_scrollbar", "position.x", 0.155);
  UI_SetProperty ("mod_craft_recipes_scrollbar", "position.y", 0.51);
  UI_SetProperty ("mod_craft_recipes_scrollbar", "slider.ninepatch_height", 270);
  UI_SetProperty ("all_recipes_unlocked", "textbox.textbox_width", 290);
  UI_SetProperty ("all_recipes_unlocked", "textbox.text_vertical_spacing", 0);
  UI_SetProperty ("all_recipes_unlocked", "textbox.text_justify", false);
  UI_SetProperty ("all_recipes_unlocked", "scale", 0.827);
  UI_SetProperty ("all_recipes_locked", "textbox.textbox_width", 290);
  UI_SetProperty ("all_recipes_locked", "textbox.text_vertical_spacing", 0);
  UI_SetProperty ("all_recipes_locked", "textbox.text_justify", false);
  UI_SetProperty ("all_recipes_locked", "scale", 0.827);
  UI_SetProperty ("all_recipes_locked", "position.x", 0.508159);
  UI_SetProperty ("recipe_id", "position.x", -0.49);
  UI_SetProperty ("recipe_id", "position.y", 0.18);
  UI_SetProperty ("recipe_id", "editbox.text_scale", 1);
  UI_SetProperty ("recipe_id", "editbox.ninepatch_width", 211);
  UI_SetProperty ("textbox_2", "position.x", 0.013);
  UI_SetProperty ("textbox_2", "position.y", -0.6);
  UI_SetProperty ("UnlockRecipe", "align", NX_ALIGN_HCENTER | NX_ALIGN_VCENTER);
  UI_SetProperty ("UnlockRecipe", "position.x", 0.246);
  UI_SetProperty ("UnlockRecipe", "position.y", 1.62);
  UI_SetProperty ("CraftRecipe", "align", NX_ALIGN_HCENTER | NX_ALIGN_VCENTER);
  UI_SetProperty ("CraftRecipe", "position.x", 0.246);
  UI_SetProperty ("CraftRecipe", "position.y", 2.68);
  UI_SetProperty ("ChangeRecipeUpgradeLevel", "align", NX_ALIGN_HCENTER | NX_ALIGN_VCENTER);
  UI_SetProperty ("ChangeRecipeUpgradeLevel", "position.x", 0.5);
  UI_SetProperty ("ChangeRecipeUpgradeLevel", "position.y", 3.74);
  UI_SetProperty ("UncraftRecipe", "align", NX_ALIGN_HCENTER | NX_ALIGN_VCENTER);
  UI_SetProperty ("UncraftRecipe", "position.x", 0.763);
  UI_SetProperty ("UncraftRecipe", "position.y", 2.68);
  UI_SetProperty ("LockRecipe", "align", NX_ALIGN_HCENTER | NX_ALIGN_VCENTER);
  UI_SetProperty ("LockRecipe", "position.x", 0.763);
  UI_SetProperty ("LockRecipe", "position.y", 1.62);
  UI_SetVisible ("panel2", true);
  UI_SetVisible ("panel4", true);
  UI_SetVisible ("panel5", true);
}


function Mod_CraftRecipes_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_craft_recipes_use":
        UI_SendScreenMessage ("Cheats", "Mode", "MOD_CRAFT_RECIPES");
        UI_PushScreen ("Cheats");
        break;
      case "mod_craft_recipes_title":
        Mods_Info_Popup (
            LocalizeText("Craft recipes"),
            LocalizeText("Unlock, craft and upgrade all recipes, items, tools, weapons, specials, trinkets, outfits, headgears, features, transmitters, buildables, dishes, skills, obelisks using the vanilla Cheats UI."));
        break;
    }
  }
}


function Mod_CraftRecipes_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_craft_recipes_use", "button.text", LocalizeText("Use"));
  UI_SetProperty ("mod_craft_recipes_title", "textbox.text", LocalizeText("Craft recipes"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
