// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local interval_realseconds = 3.0;
local draw_distance = 3;
local update_in_realseconds = 0.0;


Include ("scripts/mods/mods-info.nut");


function Mod_GridRays_OnUpdate_Stage (tdelta) {
  update_in_realseconds -= tdelta;
  if (update_in_realseconds < 0.0) {
    update_in_realseconds = interval_realseconds;
    if (Game_GetWorldStateAsInteger ("MODS", "grid_rays_enabled", 0) == 1) {
      local stage = Stage_GetFilename();
      if (stage != null) {
        local stage_info = Stage_GetExternalStageInfo (stage);
        if (stage_info != null) {
          if (stage_info.rawin("width_in_cells") == true && stage_info.rawin("height_in_cells") == true
          && (stage_info.rawget("width_in_cells") > 400 || stage_info.rawget("height_in_cells") > 400)) {
            local cellsize = Stage_GetCellSize();
            local player = Game_GetPrimaryPlayerActor();
            if (player != null) {
              local player_position = StageObject_GetStagePosition (player);
              if (player_position != null) {
                local player_chunk_x = floor(player_position[0].tofloat() / cellsize.tofloat() / 20.0);
                local player_chunk_y = floor(player_position[1].tofloat() / cellsize.tofloat() / 20.0);
                for (local chunk_x = player_chunk_x - draw_distance; chunk_x <= player_chunk_x + draw_distance + 1; chunk_x++) {
                  for (local chunk_y = player_chunk_y - draw_distance; chunk_y <= player_chunk_y + draw_distance + 1; chunk_y++) {
                    local ray_id = "mod_grid_ray_" + chunk_x + "_" + chunk_y;
                    local ray = Stage_GetStageObjectById (ray_id, STAGE_OBJECT_TYPE_ACTOR);
                    if (ray == null) {
                      ray = Stage_CreateActor ("actors/mods/mod-grid-ray.xml", chunk_x * cellsize * 20, chunk_y * cellsize * 20, 0.0, false);
                      StageObject_SetId (ray, ray_id);
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}


function Mod_GridRays_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_grid_rays_enabled":
        local enabled = UI_GetProperty ("mod_grid_rays_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "grid_rays_enabled", enabled ? "1" : "0");
        if (enabled) {
          update_in_realseconds = interval_realseconds;
        } else {
          local rays = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, "MOD_GRID_RAY");
          if (rays != null && rays.len() > 0) {
            foreach (ray in rays) {
              Stage_DeleteStageObjectQueued (ray);
            }
          }
        }
        break;
      case "mod_grid_rays_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Grid rays"),
            LocalizeText("Draw sky rays at map grid crossings, to help you navigate in a straight line."));
        break;
    }
  }
}


function Mod_GridRays_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_grid_rays_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "grid_rays_enabled", 0));
  UI_SetProperty ("mod_grid_rays_enabled_title", "textbox.text", LocalizeText("Grid rays"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
