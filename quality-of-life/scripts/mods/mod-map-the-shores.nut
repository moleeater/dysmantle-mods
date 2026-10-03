// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local reveal_radius_multiplier = 1.1;
local stage_kvs = null;


Include ("scripts/mods/mods-info.nut");


function Mod_MapTheShores_Query (waterplane) {
  local puid = StageObject_GetPersistentUniqueId (waterplane);
  if (stage_kvs == null || puid == null || KeyValueStore_GetKeyValue (stage_kvs, "mod_map_the_shores_" + puid.tostring()) == null) {
    local scale = StageObject_GetScale (waterplane);
    if (scale == null) scale = 1.0;
    local position = StageObject_GetStagePosition (waterplane);
    if (position != null) {
      local width = 120.0 * scale;
      local is_openwater = true;
      local objects = Stage_QueryStageObjectsInsideRectangle (position[0], position[1], width, width);
      if (objects != null && objects.len() > 0) {
        foreach (object in objects) {
          if (StageObject_GetType (object) == STAGE_OBJECT_TYPE_DECAL
          || StageObject_HasTag (object, "CLIFF") == true
          || StageObject_HasTag (object, "FOLIAGE") == true
          || StageObject_HasTag (object, "TREE") == true) {
            is_openwater = false;
          }
        }
      }
      if (is_openwater == true) {
        local radius = width * reveal_radius_multiplier;
        foreach (x_sign in [-1,1]) {
          foreach (y_sign in [-1,1]) {
            local coord_x = position[0] + width * x_sign;
            local coord_y = position[1] + width * y_sign;
            Game_RevealMapAtPointRadius (coord_x, coord_y, radius);
          }
        }
      }
      if (stage_kvs != null && puid != null) {
        KeyValueStore_SetKeyValueBoolean (stage_kvs, "mod_map_the_shores_" + puid.tostring(), is_openwater);
      }
    }
  }
}


function Mod_MapTheShores_OnGameStart_WaterPlane (waterplane, same) {
  if (Game_IsCinemaModeEnabled() != true && Game_GetWorldStateAsInteger ("MODS", "map_the_shores_enabled", 0) == 1) {
    local is_small_stage = true;
    local stage = Stage_GetFilename();
    if (stage != null) {
      local stage_info = Stage_GetExternalStageInfo (stage);
      if (stage_info != null) {
        if (stage_info.rawin("width_in_cells") == true && stage_info.rawin("height_in_cells") == true
        && (stage_info.rawget("width_in_cells") > 400 || stage_info.rawget("height_in_cells") > 400)) {
          is_small_stage = false;
        }
      }
    }
    if (!is_small_stage) {
      stage_kvs = Stage_GetKeyValueStore();
      Mod_MapTheShores_Query (waterplane);
    }
  }
}


function Mod_MapTheShores_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_map_the_shores_enabled":
        local enabled = UI_GetProperty ("mod_map_the_shores_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "map_the_shores_enabled", enabled ? "1" : "0");
        if (enabled) {
          local is_small_stage = true;
          local stage = Stage_GetFilename();
          if (stage != null) {
            local stage_info = Stage_GetExternalStageInfo (stage);
            if (stage_info != null) {
              if (stage_info.rawin("width_in_cells") == true && stage_info.rawin("height_in_cells") == true
              && (stage_info.rawget("width_in_cells") > 400 || stage_info.rawget("height_in_cells") > 400)) {
                is_small_stage = false;
              }
            }
          }
          if (!is_small_stage) {
            local waters = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, "WATER");
            if (waters != null && waters.len() > 0) {
              stage_kvs = Stage_GetKeyValueStore();
              foreach (water in waters) {
                if (Actor_GetActorType (water) == "actors/objects/water-plane.xml") {
                  Mod_MapTheShores_Query (water);
                }
              }
            }
          }
        }
        break;
      case "mod_map_the_shores_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Map the shores"),
            LocalizeText("Reveal grids neighbouring open waters on the world map when you are near."));
        break;
    }
  }
}


function Mod_MapTheShores_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_map_the_shores_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "map_the_shores_enabled", 0));
  UI_SetProperty ("mod_map_the_shores_enabled_title", "textbox.text", LocalizeText("Map the shores"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
