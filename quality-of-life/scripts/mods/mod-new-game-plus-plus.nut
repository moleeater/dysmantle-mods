// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local flowers = [
    "FROST_LILY",
    "TIGER_LILY",
    "AMBER_LILY",
  ];
local recipes = [];


function Mod_NewGamePlusPlus_OnSetupNewGame (test_game_start_id, player) {
  if (Profile_GetValue ("!SAVE_STATE", "mod_new_game_plus_plus", "id") == "mod_new_game_plus_plus") {
    local recipe_files = NX_FindFiles ("dysmantle", "recipes*.xml", false);
    if (recipe_files != null && recipe_files.len() > 0) {
      foreach (recipe_file in recipe_files) {
        for (local recipe_node_index = 0; recipe_node_index < DM_GetArrayNumberOfNodes (recipe_file, "RECIPES"); recipe_node_index++) {
          if (DM_GetArrayNodeValue (recipe_file, "RECIPES", recipe_node_index, "category") == "COOKING") {
            local dish = DM_GetArrayNodeValue (recipe_file, "RECIPES", recipe_node_index, "id");
            if (dish != null && dish.len() > 5 && dish.slice(0, 5) == "DISH_"
            && Profile_GetValue ("!SAVE_STATE", "mod_new_game_plus_plus", dish) == "unlock") {
              Game_SetRecipeUnlocked (dish, true, false);
              Profile_SetValue ("!SAVE_STATE", "mod_new_game_plus_plus", dish, "");
              Game_LogEvent ("MOD_NEW_GAME_PLUS_PLUS", dish);
            }
          }
        }
      }
    }
    if (IAP_IsItemPurchased ("DLC2") == true) {
      foreach (flower in flowers) {
        foreach (num in [1,2,3]) {
          local recipe = flower + "_" + num.tostring();
          if (Profile_GetValue ("!SAVE_STATE", "mod_new_game_plus_plus", recipe) == "0") {
            Game_CraftRecipe (recipe, false);
            Profile_SetValue ("!SAVE_STATE", "mod_new_game_plus_plus", recipe, "");
            Game_LogEvent ("MOD_NEW_GAME_PLUS_PLUS", recipe);
          }
        }
      }
    }
    for (local ui_node_index = 0; ui_node_index < DM_GetArrayNumberOfNodes ("ui/NewGamePlus.xml", "COMPONENTS"); ui_node_index++) {
      if (DM_GetArrayNodeValue ("ui/NewGamePlus.xml", "COMPONENTS", ui_node_index, "type") == "CHECKBOX"
      && DM_GetArrayNodeValue ("ui/NewGamePlus.xml", "COMPONENTS", ui_node_index, "parent") == "mod_new_game_plus_plus_recipes") {
        local ui_name = DM_GetArrayNodeValue ("ui/NewGamePlus.xml", "COMPONENTS", ui_node_index, "name");
        if (ui_name != null && ui_name.len() > 23 && ui_name.slice(0, 23) == "mod_new_game_plus_plus_") {
          local recipe = ui_name.slice(23);
          local target_level = Profile_GetValue ("!SAVE_STATE", "mod_new_game_plus_plus", recipe);
          if (target_level != null && target_level != "") {
            if (target_level == "uncraft") {
              Game_CheatCraftOrUncraftRecipe (recipe, false);
              Game_LogEvent ("MOD_NEW_GAME_PLUS_PLUS", "-" + recipe);
            } else {
              Game_CraftRecipe (recipe, false);
              target_level = target_level.tointeger();
              if (target_level > 0) {
                for (local level = 1; level <= target_level; level++) {
                  local current_level = Game_GetRecipeUpgradeLevel (recipe);
                  if (current_level < target_level) {
                    Game_UpgradeRecipe (recipe);
                  }
                }
              }
              Game_LogEvent ("MOD_NEW_GAME_PLUS_PLUS", recipe + (target_level > 0 ? "+" + target_level.tostring() : ""));
              switch (recipe) {
                case "RIFT_TOOLKIT":
                  Game_SetWorldState ("MANA_RIFTS", "enabled", "1");
                  Game_LogEvent ("MOD_NEW_GAME_PLUS_PLUS", "MANA_RIFTS");
                  break;
                case "TRANSMITTER_CAMP_FAST_TRAVEL":
                  Game_SetFeatureAvailable ("CAMPFIRE_FAST_TRAVEL", true);
                  Game_LogEvent ("MOD_NEW_GAME_PLUS_PLUS", "CAMPFIRE_FAST_TRAVEL");
                  break;
              }
            }
            Profile_SetValue ("!SAVE_STATE", "mod_new_game_plus_plus", recipe, "");
          }
        }
      }
    }
  }
}


function Mod_NewGamePlusPlus_OnClick_NewGamePlus (clicked) {
  if (clicked == "StartNewGame") {
    if (UI_GetProperty ("mod_new_game_plus_plus_dishes", "checkbox.value") == 1) {
      local recipe_files = NX_FindFiles ("dysmantle", "recipes*.xml", false);
      if (recipe_files != null && recipe_files.len() > 0) {
        foreach (recipe_file in recipe_files) {
          for (local recipe_node_index = 0; recipe_node_index < DM_GetArrayNumberOfNodes (recipe_file, "RECIPES"); recipe_node_index++) {
            if (DM_GetArrayNodeValue (recipe_file, "RECIPES", recipe_node_index, "category") == "COOKING") {
              local dish = DM_GetArrayNodeValue (recipe_file, "RECIPES", recipe_node_index, "id");
              if (dish != null && dish.len() > 5 && dish.slice(0, 5) == "DISH_" && Game_IsRecipeUnlocked (dish) == true) {
                Profile_SetValue ("!SAVE_STATE", "mod_new_game_plus_plus", dish, "unlock");
              }
            }
          }
        }
      }
    }
    if (IAP_IsItemPurchased ("DLC2") == true && UI_GetProperty ("mod_new_game_plus_plus_flowers", "checkbox.value") == 1) {
      foreach (flower in flowers) {
        foreach (num in [1,2,3]) {
          local recipe = flower + "_" + num.tostring();
          if (Game_IsRecipeCrafted (recipe) == true) {
            Profile_SetValue ("!SAVE_STATE", "mod_new_game_plus_plus", recipe, "0");
          }
        }
      }
    }
    foreach (recipe in recipes) {
      local is_checked = UI_GetProperty ("mod_new_game_plus_plus_" + recipe, "checkbox.value") == 1 ? true : false;
      local is_vanilla = UI_GetProperty ("mod_new_game_plus_plus_" + recipe, "user_string") == "vanilla" ? true : false;
      if (is_checked || is_vanilla) {
        local level = Game_GetRecipeUpgradeLevel (recipe);
        Profile_SetValue ("!SAVE_STATE", "mod_new_game_plus_plus", recipe, is_vanilla && ! is_checked ? "uncraft" : level == null ? "" : level.tostring());
      }
    }
  }
}


function Mod_NewGamePlusPlus_OnEnter_NewGamePlus() {
  UI_SetProperty ("panel", "ninepatch.automatic_content_height", false);
  UI_SetProperty ("panel", "ninepatch.rectangle_width", 950);
  UI_SetProperty ("panel", "ninepatch.rectangle_height", 535);
  UI_SetProperty ("aligner_2", "position.x", -0.2);
  UI_SetProperty ("mod_new_game_plus_plus_desc", "textbox.text", "|img src='emojis/package.png' scale=0.7|  " + LocalizeText("You will get to keep certain |#11ff11|special items|#ffffff| you may have found during your journey, but you will lose all other items and recipes."));
  for (local ui_node_index = 0; ui_node_index < DM_GetArrayNumberOfNodes ("ui/NewGamePlus.xml", "COMPONENTS"); ui_node_index++) {
    if (DM_GetArrayNodeValue ("ui/NewGamePlus.xml", "COMPONENTS", ui_node_index, "type") == "CHECKBOX"
    && DM_GetArrayNodeValue ("ui/NewGamePlus.xml", "COMPONENTS", ui_node_index, "parent") == "mod_new_game_plus_plus_recipes") {
      local ui_name = DM_GetArrayNodeValue ("ui/NewGamePlus.xml", "COMPONENTS", ui_node_index, "name");
      if (ui_name != null && ui_name.len() > 23 && ui_name.slice(0, 23) == "mod_new_game_plus_plus_") {
        local recipe = ui_name.slice(23);
        switch (recipe) {
          case "dishes":
            UI_SetProperty (ui_name, "checkbox.text", Game_GetConvertedString ("[RECIPE_ICON=DISH_HAMBURGER]  ") + LocalizeText("Cooking Recipes"));
            break;
          case "flowers":
            if (IAP_IsItemPurchased ("DLC2") == true && Game_IsRecipeCrafted ("SKILL_FLOWER_POWER_1") == true) {
              UI_SetProperty (ui_name, "checkbox.text", Game_GetConvertedString ("[RECIPE_ICON=AMBER_LILY_1]  [RECIPE_NAME=SKILL_FLOWER_POWER_1]"));
              UI_SetVisible (ui_name, true);
            }
            break;
          default:
            if (Game_IsRecipeCrafted (recipe) == true) {
              recipes.push(recipe);
              UI_SetProperty (ui_name, "checkbox.text", Game_GetConvertedString ("[RECIPE_ICON=" + recipe + "]  [RECIPE_NAME=" + recipe + "]"));
              UI_SetVisible (ui_name, true);
            }
            break;
        }
      }
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
