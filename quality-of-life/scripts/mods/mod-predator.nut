// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local chitin_whitelist_puids = [ 1002238, 1004182, 1004180, 1004183, 1036304, 1036254, 1036334, 1036159, 1036306, 1036333, 1036335, 1038241, 1096308, 1098220, 1130296, 1130307, 1130306, 1130295, 1132144, 1134082, 1134108, 1192386, 1274134, 1276130, 1370106, 1376317, 1380411, 1382314, 1388311, 1390360, 1390358, 1480295, 1480294, 1482345, 1482346, 1484320, 1484316, 1486121, 1486101, 1574272, 1674166, 1770137, 1868126, ];
local interval_realseconds = 1.0;
local cellsize = 60.0;
local areas = [];
local update_in_realseconds = 0.0;
local nearest_enemy = { "obj": null, "position": null, "puid": null };
local nearest_animal = { "obj": null, "position": null, "puid": null };
local nearest_gatherable = { "obj": null, "position": null, "puid": null };
local nearest_bead = { "obj": null, "position": null, "puid": null };
local previous_area_num = null;
local minimap_rotated_based_on_camera = false;
local hide_minimap_enabled = false;


Include ("scripts/mods/mods-info.nut");


function Mod_Predator_Query (center_position, tag, exclude_tag = null, material_id = null) {
  local nearest = { "obj": null, "position": null, "puid": null };
  local nearest_distance = null;
  local objects = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, tag);
  if (objects != null && objects.len() > 0) {
    foreach (object in objects) {
      local puid = StageObject_GetPersistentUniqueId (object);
      local requires_skill = StageObject_GetKeyValue (object, "requires_skill", "");
      if (puid != null && Game_IsPUIDMarkedDestroyed (puid) != true
      && (material_id == null || StageObject_GetKeyValue (object, "material_id", null) == material_id)
      && (exclude_tag == null || StageObject_HasTag (object, exclude_tag) != true)
      && (requires_skill == "" || Game_IsRecipeCrafted (requires_skill) == true)) {
        local position = StageObject_GetStagePosition (object);
        if (position != null) {
          local distance = sqrt(pow(position[0] - center_position[0], 2) + pow(position[1] - center_position[1], 2) + pow(position[2] - center_position[2], 2));
          if (nearest_distance == null || distance < nearest_distance) {
            nearest_distance = distance;
            nearest.obj = object;
            nearest.puid = puid;
          }
        }
      }
    }
  }
  return nearest;
}


function Mod_Predator_Draw (nearest, camera_angle, center_position, player1_position, compass, minimap) {
  if (nearest.obj != null) {
    if (nearest.puid != null && Game_IsPUIDMarkedDestroyed (nearest.puid) == true) {
      nearest = { "obj": null, "position": null, "puid": null };
    } else {
      nearest.position = StageObject_GetStagePosition (nearest.obj);
    }
  }
  if (nearest.position == null) {
    UI_SetVisible (minimap, false);
    UI_SetVisible (compass, false);
  } else {
    local center_radian = m_anglemod (
        (0.0 - camera_angle) * PI / 180.0
        + atan2(nearest.position[1] - center_position[1], nearest.position[0] - center_position[0])
      );
    UI_SetProperty (compass, "position.x", center_radian.tofloat() / PI / 2);
    UI_SetVisible (compass, true);
    if (minimap_rotated_based_on_camera != true && hide_minimap_enabled != true) {
      UI_SetVisible (minimap, false);
    } else {
      local minimap_radian = center_radian;
      if (hide_minimap_enabled != true) {
        minimap_radian = m_anglemod (
            (0.0 - camera_angle) * PI / 180.0
            + atan2(nearest.position[1] - player1_position[1], nearest.position[0] - player1_position[0])
          );
      }
      UI_SetProperty (minimap, "angle.z", minimap_radian);
      UI_SetVisible (minimap, true);
    }
  }
}


function Mod_Predator_OnUpdate_Stage (tdelta) {
  update_in_realseconds -= tdelta;
  if (Game_IsCinemaModeEnabled() != true && UI_IsScreenInStack ("PauseMenu") != true && Game_GetWorldStateAsInteger ("MODS", "predator_enabled", 0) == 1) {
    local camera = Stage_GetActiveCamera();
    if (camera != null) {
      local camera_angle = StageObject_GetAngle (camera);
      if (camera_angle != null) {
        local players = [ null, null ];
        foreach (player_index in [0,1]) {
          players[player_index] = Game_GetPlayerActor (player_index);
        }
        local center_position = null;
        local player1_position = null;
        if (players[0] != null) {
          center_position = StageObject_GetStagePosition (players[0]);
          player1_position = center_position;
          if (players[1] != null) {
            local player2_position = StageObject_GetStagePosition (players[1]);
            local radian = atan2(player1_position[1] - player2_position[1], player1_position[0] - player2_position[0]);
            local distance = sqrt(pow(player1_position[0] - player2_position[0], 2) + pow(player1_position[1] - player2_position[1], 2)) / 2.0;
            center_position = [ player1_position[0] - cos(radian) * distance, player1_position[1] - sin(radian) * distance, player1_position[2] ];
          }
        }
        if (center_position != null) {
          if (update_in_realseconds < 0.0) {
            update_in_realseconds = interval_realseconds;
            local engine_kvs = Engine_GetKeyValueStore();
            if (engine_kvs != null) {
              minimap_rotated_based_on_camera = KeyValueStore_GetKeyValue (engine_kvs, "minimap_rotated_based_on_camera", false);
            }
            hide_minimap_enabled = Game_GetWorldStateAsInteger ("MODS", "hide_minimap_enabled", 0) == 1 ? true : false;
            nearest_enemy = { "obj": null, "position": null, "puid": null };
            if (Game_IsRecipeCrafted ("MONSTER_SCANNER") == true) {
              local area_num = null;
              local chunk_x = floor(center_position[0].tofloat() / cellsize / 20.0).tointeger();
              local chunk_y = floor(center_position[1].tofloat() / cellsize / 20.0).tointeger();
              local chunk = chunk_x.tostring() + "-" + chunk_y.tostring();
              foreach (index, area_data in areas) {
                if (area_data.chunks.find(chunk) != null) {
                  area_num = index;
                  break;
                }
              }
              if (area_num != previous_area_num) {
                nearest_enemy = { "obj": null, "position": null, "puid": null };
                previous_area_num = area_num;
              }
              local enemies = {};
              if (area_num != null && areas.len() > area_num && areas[area_num].enemies.len() > 0
              && Game_IsTransmitterInstalled (areas[area_num].id, "TRANSMITTER_SCANNER") == true) {
                foreach (puid, pos in areas[area_num].enemies) {
                  if (Game_IsPUIDMarkedDestroyed (puid) != true) {
                    enemies[puid] <- { "pos": pos, "obj": null };
                  }
                }
                if (enemies.len() > 0) {
                  foreach (tag in [ "MONSTER", "BOSS", "POINT_OF_INTEREST" ]) {
                    local objects = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, tag);
                    if (objects != null && objects.len() > 0) {
                      foreach (object in objects) {
                        local puid = StageObject_GetPersistentUniqueId (object);
                        if (puid != null && enemies.rawin(puid) == true && Game_IsPUIDMarkedDestroyed (puid) != true) {
                          local pos = StageObject_GetStagePosition (object);
                          if (pos != null) {
                            enemies[puid] = { "pos": pos, "obj": object };
                          }
                        }
                      }
                    }
                  }
                }
              }
              local nearest_enemy_distance = null;
              if (enemies != null && enemies.len() > 0) {
                foreach (puid, enemy_data in enemies) {
                  local distance = sqrt(pow(enemy_data.pos[0] - center_position[0], 2) + pow(enemy_data.pos[1] - center_position[1], 2) + pow(enemy_data.pos[2] - center_position[2], 2));
                  if (nearest_enemy_distance == null || distance < nearest_enemy_distance) {
                    nearest_enemy.puid = puid;
                    nearest_enemy_distance = distance;
                    nearest_enemy.obj = enemy_data.obj;
                    nearest_enemy.position = enemy_data.pos;
                  }
                }
              }
            }
            if (Game_IsRecipeCrafted ("SKILL_ANIMAL_FRIEND_3") != true) {
              nearest_animal = { "obj": null, "position": null, "puid": null };
            } else {
              nearest_animal = Mod_Predator_Query (center_position, "ANIMAL", "TAMED");
            }
            if (Game_IsFeatureAvailable ("GATHERER") == true) {
              nearest_gatherable = Mod_Predator_Query (center_position, "GATHERABLE");
            } else {
              nearest_gatherable = { "obj": null, "position": null, "puid": null };
            }
            nearest_bead = Mod_Predator_Query (center_position, "MATERIAL", null, "MANA_BEAD");
          }
          Mod_Predator_Draw (nearest_enemy, camera_angle, center_position, player1_position, "mod_compass_predator_enemy", "mod_predator_minimap_enemy");
          Mod_Predator_Draw (nearest_animal, camera_angle, center_position, player1_position, "mod_compass_predator_animal", "mod_predator_minimap_animal");
          Mod_Predator_Draw (nearest_gatherable, camera_angle, center_position, player1_position, "mod_compass_predator_gatherable", "mod_predator_minimap_gatherable");
          Mod_Predator_Draw (nearest_bead, camera_angle, center_position, player1_position, "mod_compass_predator_bead", "mod_predator_minimap_bead");
        }
      }
    }
  }
}


function Mod_Predator_Toggle (enabled = false) {
  if (enabled != true) {
    UI_SetVisible ("mod_compass", false);
    UI_SetVisible ("mod_predator_minimap_enemy", false);
    UI_SetVisible ("mod_predator_minimap_animal", false);
    UI_SetVisible ("mod_predator_minimap_gatherable", false);
    UI_SetVisible ("mod_predator_minimap_bead", false);
  } else {
    UI_SetVisible ("mod_compass", true);
    UI_SetProperty ("BossInfo", "position.x", 0.5);
    cellsize = Stage_GetCellSize();
    if (cellsize == null) cellsize = 60.0;
    cellsize = cellsize.tofloat();
    local stage = Stage_GetFilename();
    if (stage != null) {
      local towers_nodes_count = DM_GetArrayNumberOfNodes ("dysmantle/towers.xml", stage);
      if (towers_nodes_count != null && towers_nodes_count > 0) {
        for (local towers_node_index = 0; towers_node_index < towers_nodes_count; towers_node_index++) {
          local tower_id = DM_GetArrayNodeValue ("dysmantle/towers.xml", stage, towers_node_index, "id");
          local chunkstr = DM_GetArrayNodeValue ("dysmantle/towers.xml", stage, towers_node_index, "chunks");
          if (tower_id != null && chunkstr != null) {
            areas.push( { "id": tower_id, "chunks": split (chunkstr, ","), "enemies": {} } );
          }
        }
      }
      if (stage.len() >= 10 && stage.slice(stage.len() - 10) == "/index.xml") {
        local pois = stage.slice(0, stage.len() - 10) + "/points-of-interest.xml";
        local pois_nodes_count = DM_GetArrayNumberOfNodes (pois, stage);
        if (pois_nodes_count != null && pois_nodes_count > 0) {
          local has_turrets_everywhere = NX_FileExists ("scripts/mods/mod-turrets-everywhere.nut");
          for (local pois_node_index = 0; pois_node_index < pois_nodes_count; pois_node_index++) {
            local poi_type = DM_GetArrayNodeValue (pois, stage, pois_node_index, "type");
            local poi_area = DM_GetArrayNodeValue (pois, stage, pois_node_index, "area");
            local poi_puid = DM_GetArrayNodeValue (pois, stage, pois_node_index, "puid");
            local poi_pos_str = DM_GetArrayNodeValue (pois, stage, pois_node_index, "pos");
            if (poi_type != null && poi_type.len() > 6 && poi_type.slice(0, 6) == "ENEMY_" && poi_type != "ENEMY_NIGHTTERROR"
            && poi_area != null && poi_area != "" && poi_puid != null && poi_pos_str != null && areas.len() > poi_area.tointeger()
            && (has_turrets_everywhere != true || poi_type == "ENEMY_BOSS" || (stage == "stages/dlc2/index.xml" && chitin_whitelist_puids.find(poi_puid.tointeger()) != null))) {
              areas[poi_area.tointeger()].enemies[poi_puid.tointeger()] <- split(poi_pos_str, ";").map(@(value) value.tointeger());
            }
          }
        }
      }
    }
  }
}


function Mod_Predator_OnEnter_Stage() {
  Mod_Predator_Toggle (Game_GetWorldStateAsInteger ("MODS", "predator_enabled", 0) == 1);
}


function Mod_Predator_OnScreenMessage_Stage (key, value) {
  if (key == "mod_predator_enabled_message") {
    Mod_Predator_Toggle (value == "1");
  }
}


function Mod_Predator_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_predator_enabled":
        local enabled = UI_GetProperty ("mod_predator_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "predator_enabled", enabled ? "1" : "0");
        UI_SendScreenMessage ("Stage", "mod_predator_enabled_message", enabled ? "1" : "0");
        break;
      case "mod_predator_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Predator"),
            LocalizeText("Shows direction to closest enemy in the same area for Ascensions (needs Monster Scanner and Scanner Radar), closest animal (needs Animal Friend 3), gatherable (needs Gatherer) and mana bead, on a compass and the edge of the minimap."));
        break;
    }
  }
}


function Mod_Predator_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_predator_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "predator_enabled", 0));
  UI_SetProperty ("mod_predator_enabled_title", "textbox.text", LocalizeText("Predator"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
