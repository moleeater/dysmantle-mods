// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local amount_maximum = 999.0;
local nonlinearity_power = 4.0;
local is_spawn_screen = false;


function Mod_SpawnMaterials_OnScreenMessage_Cheats (key, value) {
  if (key != null) {
    switch (key) {
      case "Mode":
        if (value == "MOD_SPAWN_MATERIALS") {
          is_spawn_screen = true;
          UI_SetVisible ("panel3", false);
          UI_SetVisible ("panel4", false);
          UI_SetVisible ("panel5", false);
          UI_SetVisible ("AddAllMaterialsToStorage", false);
          UI_SetProperty ("Title", "localize", false);
          UI_SetProperty ("Title", "textbox.text", "Spawn materials");
          UI_SetProperty ("panel2", "ninepatch.rectangle_height", 375);
          UI_SetProperty ("material_id", "position.y", 0.08);
          UI_SetProperty ("material_id", "scale", 1.3);
          UI_SetProperty ("material_id", "editbox.max_chars", 255);
          UI_SetProperty ("mod_spawn_materials_touchfield", "position.x", -0.485);
          UI_SetProperty ("mod_spawn_materials_touchfield", "position.y", 0.23);
          UI_SetProperty ("mod_spawn_materials_touchfield", "scale_multiplier", 1.78);
          UI_SetProperty ("mod_spawn_materials_touchfield", "touchfield.area_height", 156);
          UI_SetProperty ("mod_spawn_materials_scrollbar", "scale", 1.0);
          UI_SetProperty ("mod_spawn_materials_scrollbar", "position.x", 0.485);
          UI_SetProperty ("mod_spawn_materials_scrollbar", "slider.ninepatch_height", 270);
          UI_SetProperty ("mod_spawn_materials_scrollbar", "position.y", 0.59);
          UI_SetProperty ("all_materials", "textbox.text_justify", true);
          UI_SetProperty ("all_materials", "textbox.text_vertical_spacing", 15);
          UI_SetVisible ("mod_spawn_materials_amount", true);
          UI_SetVisible ("mod_spawn_materials_amount_slider", true);
        }
        break;
    }
  }
}


function Mod_SpawnMaterials_OnEnter_Cheats() {
  UI_SetProperty ("mod_spawn_materials_amount_slider", "slider.value", 0.0);
  UI_SetProperty ("mod_spawn_materials_amount", "editbox.text", " 1x");
  UI_SetProperty ("mod_spawn_materials_amount", "user_string", "1");
  if (is_spawn_screen) {
    local text = UI_GetProperty ("all_materials", "textbox.text");
    text = string_replace (text, " |img scale=0.25 src='", "    |img scale=0.4 src='");
    text = string_replace (text, "|img scale=0.25 src='", "|img scale=0.4 src='");
    UI_SetProperty ("all_materials", "localize", false);
    UI_SetProperty ("all_materials", "textbox.text", text);
  }
}


function Mod_SpawnMaterials_OnClick_Cheats (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "SpawnMaterial":
        if (is_spawn_screen) {
          local material_id = UI_GetProperty ("material_id", "editbox.text");
          if (material_id != null) {
            local materials = [];
            local material_ids = split (material_id, ",");
            material_id = "";
            local requires_iaps = {};
            foreach (material in material_ids) {
              material = strip (material);
              if (DM_GetArrayNodeValue ("dysmantle/material-types.xml", "MATERIAL_TYPES", material, "id") == material) {
                local requires_iap = DM_GetArrayNodeValue ("dysmantle/material-types.xml", "MATERIAL_TYPES", material, "requires_iap");
                if (requires_iap != null && IAP_IsItemPurchased (requires_iap) != true) {
                  requires_iaps[requires_iap] <- true;
                } else {
                  materials.push(material);
                  material_id += (material_id == "" ? material : "," + material);
                }
              }
            }
            local spawned = "";
            local spawned_loggable = "";
            local dlc_missing = "";
            if (materials.len() > 0) {
              UI_SetProperty ("material_id", "editbox.text", material_id);
              local amount = UI_GetProperty ("mod_spawn_materials_amount", "user_string");
              if (amount != null) {
                foreach (material in materials) {
                  local tags = [];
                  local tagstr = DM_GetArrayNodeValue ("dysmantle/material-types.xml", "MATERIAL_TYPES", material, "tags");
                  if (tagstr != null) {
                    tags = split (tagstr, ",");
                  }
                  if (tags.find("UNSTORABLE") == null || amount.tointeger() == 1) {
                    Game_SpawnMaterials (Game_GetPrimaryPlayerActor(), Game_GetPrimaryPlayerActor(), amount + "x" + material);
                    spawned += amount + "x" + Game_GetConvertedString("[MATERIAL_ICON=" + material + "]") + "    ";
                    spawned_loggable += (spawned_loggable.len() > 0 ? "," : "") + amount + "x" + material;
                  }
                }
              }
            }
            if (spawned.len() > 0) {
              UI_SetProperty ("mod_spawn_materials_amount_slider", "slider.value", 0.0);
              UI_SetProperty ("mod_spawn_materials_amount", "editbox.text", " 1x");
              UI_SetProperty ("mod_spawn_materials_amount", "user_string", "1");
              UI_SetProperty ("material_id", "editbox.text", "");
            }
            if (requires_iaps.len() > 0) {
              foreach (requires_iap, value in requires_iaps) {
                local dlc_name = DM_GetArrayNodeValue ("in-app-purchases/in-app-purchases.xml", "ITEMS", requires_iap, "name");
                dlc_missing += (dlc_name != null ? dlc_name : requires_iap) + "    ";
              }
            }
            if (spawned.len() > 0 || dlc_missing.len() > 0) {
              Engine_ShowPopup ("Spawn materials", (spawned.len() > 0 ? "Spawned:    " + spawned + "\n\n" : "") + (dlc_missing.len() > 0 ? "DLC missing:    " + dlc_missing : ""), "OK", "Cheats", "mod_spawn_materials_popup");
            }
            if (spawned.len() > 0) {
              Game_LogEvent ("MOD_SPAWN_MATERIALS", spawned_loggable);
            }
          }
        }
        break;
      case "mod_spawn_materials_amount_slider":
        local slider_value = UI_GetProperty ("mod_spawn_materials_amount_slider", "slider.value");
        local amount = 1;
        if (slider_value != null) {
          amount = round(pow(slider_value.tofloat(), nonlinearity_power.tofloat()) * (amount_maximum.tofloat() - 1.0)) + 1;
        }
        UI_SetProperty ("mod_spawn_materials_amount", "user_string", amount.tostring());
        UI_SetProperty ("mod_spawn_materials_amount", "editbox.text", " " + amount.tostring() + "x");
        break;
    }
  }
}


function Mod_SpawnMaterials_OnLeave_Cheats() {
  is_spawn_screen = false;
  UI_SetVisible ("mod_spawn_materials_amount", false);
  UI_SetVisible ("mod_spawn_materials_amount_slider", false);
  UI_SetProperty ("Title", "localize", false);
  UI_SetProperty ("Title", "textbox.text", "|img scale=1.1 offset=3 src='emojis/shushing face.png'| Cheats |img scale=1.1 offset=3 src='emojis/shushing face.png'|");
  UI_SetProperty ("panel2", "ninepatch.rectangle_height", 99);
  UI_SetProperty ("material_id", "position.y", 0.255);
  UI_SetProperty ("material_id", "scale", 1.0);
  UI_SetProperty ("mod_spawn_materials_touchfield", "position.x", -0.053);
  UI_SetProperty ("mod_spawn_materials_touchfield", "position.y", 0.05);
  UI_SetProperty ("mod_spawn_materials_touchfield", "scale_multiplier", 1);
  UI_SetProperty ("mod_spawn_materials_touchfield", "touchfield.area_height", 90);
  UI_SetProperty ("mod_spawn_materials_scrollbar", "scale", 0.5);
  UI_SetProperty ("mod_spawn_materials_scrollbar", "position.x", 0.49);
  UI_SetProperty ("mod_spawn_materials_scrollbar", "slider.ninepatch_height", 180);
  UI_SetProperty ("mod_spawn_materials_scrollbar", "position.y", 0.5);
  UI_SetProperty ("all_materials", "textbox.text_justify", false);
  UI_SetProperty ("all_materials", "textbox.text_vertical_spacing", 0);
  local text = UI_GetProperty ("all_materials", "textbox.text");
  text = string_replace (text, "    |img scale=0.4 src='", " |img scale=0.25 src='");
  text = string_replace (text, "|img scale=0.4 src='", "|img scale=0.25 src='");
  UI_SetProperty ("all_materials", "localize", false);
  UI_SetProperty ("all_materials", "textbox.text", text);
  UI_SetVisible ("AddAllMaterialsToStorage", true);
  UI_SetVisible ("panel3", true);
  UI_SetVisible ("panel4", true);
  UI_SetVisible ("panel5", true);
}


function Mod_SpawnMaterials_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_spawn_materials_use":
        UI_SendScreenMessage ("Cheats", "Mode", "MOD_SPAWN_MATERIALS");
        UI_PushScreen ("Cheats");
        break;
      case "mod_spawn_materials_title":
        Mods_Info_Popup (
            LocalizeText("Spawn materials"),
            LocalizeText("Create any material, wood, metal, crop, mushroom, fish, mana using the vanilla Cheats UI."));
        break;
    }
  }
}


function Mod_SpawnMaterials_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_spawn_materials_use", "button.text", LocalizeText("Use"));
  UI_SetProperty ("mod_spawn_materials_title", "textbox.text", LocalizeText("Spawn materials"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
