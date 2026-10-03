// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local teleporter_circles = {
    "FOREST" : "Complete the [GREEN]Forest[DEFAULT] teleporter circle.",
    "WINTER" : "Winter Circle",
    "ANCIENT": "Ancient Circle",
    "DESERT" : "Desert Circle",
    "DLC1"   : "[GREEN]Complete[DEFAULT] the [PURPLE]Underworld[DEFAULT] teleporter circle.",
    "DLC2"   : "[GREEN]Complete[DEFAULT] the [BLUE]Doomsday[DEFAULT] teleporter circle.",
  };
local obelisk_puids = {
    "Obelisk of Earth" : 5728148,
    "Obelisk of Fire"  : 7068074,
    "Obelisk of Water" : 3592090,
    "Obelisk of Summer": 8380050,
    "Obelisk of Wind"  : 3372084,
    "Obelisk of War"   : 5832157,
    "Obelisk of Winter": 3298101,
    "Obelisk of Life"  : 1876129,
    "Obelisk of Growth":  746069,
  };
local transmitters = [
    { "id": "TRANSMITTER_SCANNER"               , "title": "Scanner Radar" },
    { "id": "TRANSMITTER_ENEMY_RESPAWN_DISABLER", "title": "Deadly Transmission" },
    { "id": "TRANSMITTER_CAMP_FAST_TRAVEL"      , "title": "Campfire Triangulation" },
    { "id": "TRANSMITTER_SUBTERRANEAN_SONAR"    , "title": "Subterranean Sonar" },
  ];


function Mod_POIInfo_OnLeave_PointOfInterestInfo() {
  UI_SetProperty ("Desc", "textbox.text", "");
  UI_SetProperty ("Desc", "scale", 0.687938);
  UI_SetProperty ("Desc", "textbox.textbox_width", 681);
}


function Mod_POIInfoByCoordinates_OnEnter_PointOfInterestInfo () {
  local type_text = UI_GetProperty ("Type", "textbox.text");
  if (type_text != null) {
    local type_name = null;
    switch (type_text) {
      case LocalizeText("Teleporter"): type_name = "BURIED_TELEPORTER"; break;
      case LocalizeText("Fishing Spot"): type_name = "FISHING_SPOT"; break;
    }
    if (type_name != null) {
      local coordinates = UI_GetProperty ("Coordinates", "textbox.text");
      if (coordinates == null) coordinates = "";
      if (regexp(".+\\(1654[^0-9 ]+ 578[^0-9\\)]+\\)").match(coordinates) != true) {
        local stage = Stage_GetFilename();
        if (stage != null && stage.len() >= 10 && stage.slice(stage.len() - 10) == "/index.xml") {
          local pois = stage.slice(0, stage.len() - 10) + "/points-of-interest.xml";
          local found = false;
          for (local pois_node_index = 0; pois_node_index < DM_GetArrayNumberOfNodes (pois, stage); pois_node_index++) {
            if (found == true) break;
            if (DM_GetArrayNodeValue (pois, stage, pois_node_index, "type") == type_name) {
              local poi_pos = DM_GetArrayNodeValue (pois, stage, pois_node_index, "pos");
              if (poi_pos != null) {
                local poi_position = split(poi_pos, ";");
                if (poi_position != null && poi_position[0] != null && poi_position[1] != null) {
                  local poi_x = round(poi_position[0].tofloat() / 60.0);
                  local poi_y = round(poi_position[1].tofloat() / 60.0);
                  if (poi_x != null && poi_y != null
                  && regexp(".+\\(" + poi_x.tostring() + "[^0-9 ]+ " + poi_y.tostring() + "[^0-9\\)]+\\)").match(coordinates)) {
                    local new_desc = null;
                    switch (type_name) {
                      case "BURIED_TELEPORTER":
                        local teleporter_id = DM_GetArrayNodeValue (pois, stage, pois_node_index, "so_id");
                        if (teleporter_id != null) {
                          local pet_stage_set = DM_GetArrayNodeValue ("dysmantle/buried-teleporters.xml", "stages/pet-stages/pet-hub.stage", teleporter_id, "set");
                          if (pet_stage_set != null) {
                            new_desc = LocalizeText(teleporter_circles[pet_stage_set]);
                          }
                        }
                        break;
                      case "FISHING_SPOT":
                        local fishing_spot_type = DM_GetArrayNodeValue (pois, stage, pois_node_index, "parm");
                        if (fishing_spot_type != null) {
                          local fishing_spot_puid = DM_GetArrayNodeValue (pois, stage, pois_node_index, "puid");
                          if (Game_IsStagePointOfInterestPUIDCompleted (fishing_spot_puid.tointeger()) != true) {
                            foreach (i in [1,2,3]) {
                              new_desc = (new_desc == null ? "" : new_desc) + "|img src='controller-art/wasdmouse/button-question.png' scale=0.7|";
                            }
                          } else {
                            for (local catch_node_index = 0; catch_node_index < DM_GetArrayNumberOfNodes ("dysmantle/fishing-probabilities.xml", fishing_spot_type); catch_node_index++) {
                              local material = DM_GetArrayNodeValue ("dysmantle/fishing-probabilities.xml", fishing_spot_type, catch_node_index, "material_id");
                              if (material != null && material != "") {
                                local stored = Game_GetNumberOfMaterialsStoredAllTime (material);
                                new_desc = (new_desc == null ? "" : new_desc + " ")
                                  + (stored != null && stored > 0 ? "[MATERIAL_ICON=" + material + "]" : "|img src='controller-art/wasdmouse/button-question.png' scale=0.7 offset=2|");
                              }
                            }
                          }
                        }
                        break;
                    }
                    if (new_desc != null) {
                      UI_SetProperty ("Desc", "textbox.textbox_width", 0);
                      UI_SetProperty ("Desc", "scale", 1);
                      UI_SetProperty ("Desc", "localize", false);
                      UI_SetProperty ("Desc", "textbox.text", Game_GetConvertedString (new_desc));
                    }
                    found = true;
                  }
                }
              }
            }
          }
          if (found != true) {
            Engine_Warning("mod-poi-info is missing data, Stage: " + stage.tostring() + ", Coordinates:" + coordinates.tostring());
          }
        }
      }
    }
  }
}


function Mod_POIInfoObelisks_OnEnter_PointOfInterestInfo () {
  if (UI_GetProperty ("Type", "textbox.text") == LocalizeText("Obelisk")) {
    local target_obelisk_title = UI_GetProperty ("Name", "textbox.text");
    if (target_obelisk_title != null) {
      local found = false;
      foreach (obelisk_title, obelisk_puid in obelisk_puids) {
        if (LocalizeText(obelisk_title) == target_obelisk_title) {
          local new_desc = "";
          local old_desc = UI_GetProperty ("Desc", "textbox.text");
          if (old_desc != null && old_desc != "") {
            new_desc += old_desc + "\n\n";
          }
          local images = "";
          local level = Game_GetWorldState ("COMBAT_ALTARS", "puid" + obelisk_puid.tostring());
          if (level == null || level == "") {
            images = "|img src='emojis/cross mark.png' scale=0.7 offset=2|";
          } else {
            for (local pos = 0; pos < level.len(); pos++) {
              images += "|img src='controller-art/wasdmouse/button-" + level.slice(pos, pos + 1) + ".png' scale=0.7 offset=2|";
            }
          }
          new_desc += string_replace (LocalizeText("Level [LEVEL]"), "[LEVEL]", images);
          UI_SetProperty ("Desc", "textbox.textbox_width", 468);
          UI_SetProperty ("Desc", "scale", 1);
          UI_SetProperty ("Desc", "localize", false);
          UI_SetProperty ("Desc", "textbox.text", new_desc);
          found = true;
          break;
        }
      }
      if (found != true) {
        Engine_Warning("mod-poi-info is missing obelisk data, target_obelisk_title:" + target_obelisk_title.tostring());
      }
    }
  }
}


function Mod_POIInfoTowers_OnEnter_PointOfInterestInfo () {
  if (UI_GetProperty ("Type", "textbox.text") == LocalizeText("Link Tower")) {
    local coordinates = UI_GetProperty ("Coordinates", "textbox.text");
    if (coordinates == null) coordinates = "";
    local found = false;
    for (local towers_array_index = 0; towers_array_index < DM_GetNumberOfArrays ("dysmantle/towers.xml"); towers_array_index++) {
      if (found == true) break;
      for (local towers_node_index = 0; towers_node_index < DM_GetArrayNumberOfNodes ("dysmantle/towers.xml", towers_array_index); towers_node_index++) {
        if (found == true) break;
        local tower_id = DM_GetArrayNodeValue ("dysmantle/towers.xml", towers_array_index, towers_node_index, "id");
        local tower_title = DM_GetArrayNodeValue ("dysmantle/towers.xml", towers_array_index, towers_node_index, "name");
        local tower_loc = LocalizeText(tower_title);
        local tower_loc_len = tower_loc.len();
        if (coordinates != "" && coordinates.len() >= tower_loc_len && coordinates.slice(0, tower_loc_len) == tower_loc
        && regexp(" \\([0-9]+[^0-9 ]+ [0-9]+[^0-9\\)]+\\)").match(coordinates.slice(tower_loc_len))) {
          local new_desc = "";
          foreach (transmitter in transmitters) {
            new_desc += (new_desc == "" ? "" : "\n")
              + (Game_IsRecipeCrafted (transmitter.id) == true ? LocalizeText(transmitter.title) : "???") + " "
              + (Game_IsTransmitterInstalled (tower_id, transmitter.id) == true
                ? "|img src='emojis/thumbs up.png' scale=0.7 offset=2|"
                : "|img src='emojis/cross mark.png' scale=0.7 offset=2|");
          }
          UI_SetProperty ("Desc", "textbox.textbox_width", 0);
          UI_SetProperty ("Desc", "scale", 1);
          UI_SetProperty ("Desc", "localize", false);
          UI_SetProperty ("Desc", "textbox.text", new_desc);
          found = true;
        }
      }
    }
    if (found != true) {
      Engine_Warning("mod-poi-info is missing tower data, Coordinates:" + coordinates.tostring());
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
