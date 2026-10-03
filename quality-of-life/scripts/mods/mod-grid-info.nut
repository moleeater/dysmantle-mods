// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_GridInfo_OnUpdate_Stage (tdelta) {
  if (UI_IsScreenInStack ("PauseMenu") != true) {
    local grid = "";
    local stage = Stage_GetFilename();
    if (stage != null) {
      local stage_info = Stage_GetExternalStageInfo (stage);
      if (stage_info != null) {
        local cellsize = null;
        if (stage_info.rawin("width_in_cells") == true && stage_info.rawin("height_in_cells") == true
        && (stage_info.rawget("width_in_cells") > 400 || stage_info.rawget("height_in_cells") > 400)) {
          cellsize = Stage_GetCellSize();
        }
        local player = Game_GetPrimaryPlayerActor();
        if (cellsize != null && player != null) {
          local position = StageObject_GetStagePosition (player);
          if (position != null) {
            local grid_x = "??";
            local x = floor(position[0].tofloat() / cellsize.tofloat() / 20.0 / 2.0) + 1;
            if (x >= 1 && x <= 99) {
              grid_x = format ("%02u", x);
            }
            local grid_y = "?";
            local y = floor(position[1].tofloat() / cellsize.tofloat() / 20.0 / 2.0);
            if (y >= 0 && y < 26) {
              grid_y = (y + 65).tochar();
            }
            grid = grid_y + grid_x;
          }
        }
      }
    }
    UI_SetProperty ("mod_grid_info", "textbox.text", grid);
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
