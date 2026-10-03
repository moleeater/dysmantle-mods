// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local camera_distance_min = -300.0;
local camera_distance_max = 4000.0;
local snow_tile_types = [
    "snow",
    "snow-dirt",
    "snow-moss",
  ];
local tile_types = {};
local snowfall_angle = 0.0;


function Mod_Snowfall_OnEnter_Stage() {
  snowfall_angle = m_randf() * 360.0;
  local files = NX_FindFiles ("ground-tiles", "*.xml", false);
  if (files != null && files.len() > 0) {
    foreach (file in files) {
      if (file.len() > 4) {
        local tile_type = file.slice(13, file.len() - 4);
        local tile_type_num = GroundTileType_GetTypeById (tile_type);
        if (tile_type_num != null) {
          tile_types[tile_type_num] <- tile_type;
        }
      }
    }
  }
}


function Mod_Snowfall_OnUpdate_Stage (tdelta) {
  if (UI_IsScreenInStack ("PauseMenu") != true) {
    local stage_kvs = Stage_GetKeyValueStore();
    local camera_distance_modifier = 0.0;
    if (stage_kvs != null) {
      camera_distance_modifier = KeyValueStore_GetKeyValue (stage_kvs, "camera_distance_modifier", 0.0);
    }
    if (m_randf() < (camera_distance_modifier * 0.2 - camera_distance_min + 190.0) / (camera_distance_max - camera_distance_min)) {
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
        local cellsize = Stage_GetCellSize();
        local cell_x = floor(center_position[0].tofloat() / cellsize.tofloat() + (m_randf() - 0.5) * 6.0);
        local cell_y = floor(center_position[1].tofloat() / cellsize.tofloat() + (m_randf() - 0.5) * 6.0);
        local tile_type_num = Stage_GetGroundTileType (cell_x, cell_y);
        local tile_type = tile_types.rawin(tile_type_num) == true ? tile_types.rawget(tile_type_num) : null;
        if (snow_tile_types.find(tile_type) != null) {
          local snowfall_position = [
              center_position[0] + (m_randf() - 0.5) * (camera_distance_modifier - camera_distance_min) * 1.5,
              center_position[1] + (m_randf() - 0.5) * (camera_distance_modifier - camera_distance_min) * 1.5,
              center_position[2] - (camera_distance_modifier - camera_distance_min) / 2.0 - m_randf() * (camera_distance_modifier - camera_distance_min) / 2.0,
              m_randf() * 45.0 + snowfall_angle
            ];
          Stage_SpawnEffect ("effects/mods/mod-snowfall.xml", snowfall_position[0], snowfall_position[1], snowfall_position[2], snowfall_position[3]);
        }
      }
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
