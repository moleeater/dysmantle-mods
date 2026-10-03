// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local minimap_cellsize = 0.39;
local minimap_radius = 75.0;


Include ("scripts/mods/mods-info.nut");


function Mod_ThickGridlines_OnDraw_Stage() {
  local player = Game_GetPrimaryPlayerActor();
  local stage_cellsize = null;
  local stage = Stage_GetFilename();
  if (stage != null) {
    local stage_info = Stage_GetExternalStageInfo (stage);
    if (stage_info != null) {
      if (stage_info.rawin("width_in_cells") == true && stage_info.rawin("height_in_cells") == true
      && (stage_info.rawget("width_in_cells") > 400 || stage_info.rawget("height_in_cells") > 400)) {
        stage_cellsize = Stage_GetCellSize();
      }
    }
  }
  if (Game_GetWorldStateAsInteger ("MODS", "thick_gridlines_enabled", 0) != 1 || stage_cellsize == null || player == null) {
    UI_SetVisible ("mod_thick_gridlines", false);
  } else {
    UI_SetVisible ("mod_thick_gridlines", true);
    local position = StageObject_GetStagePosition (player);
    if (position != null) {
      local lines = {
          "pos": { "x": [ null, null, null ], "y": [ null, null, null ] },
          "size": { "x": [ null, null, null ], "y": [ null, null, null ] },
        };
      foreach (axis in ["x","y"]) {
        local position_cell = position[axis == "x" ? 0 : 1] / stage_cellsize.tofloat() / 20.0;
        local minimap_cell = (position_cell - floor(position_cell)) * minimap_cellsize;
        lines.pos[axis][0] = 0.0 - minimap_cell;
        if (minimap_cell < minimap_cellsize / 2) lines.pos[axis][0] -= minimap_cellsize;
        lines.pos[axis][1] = lines.pos[axis][0] + minimap_cellsize;
        lines.pos[axis][2] = lines.pos[axis][1] + minimap_cellsize;
        foreach (num in [1,2,3]) {
          local line_id = "mod_thick_gridlines_" + axis + num.tostring();
          local pos = lines.pos[axis][num - 1];
          if (pos != null) {
            UI_SetProperty (line_id, "position." + axis, pos);
          }
          local size = "0";
          if ((num == 1 && pos < -0.5) || (num == 3 && pos > 0.5)) {
            size = "0";
          } else {
            size = round(sqrt(pow(minimap_radius.tofloat(), 2) - pow(pos * 2 * minimap_radius.tofloat(), 2))).tostring();
          }
          lines.size[axis][num - 1] = size;
          UI_SetProperty (line_id, "path.points", axis == "x" ? "0,-" + size + ";0," + size : "-" + size + ",0;" + size + ",0");
        }
      }
      local angle = null;
      local engine_kvs = Engine_GetKeyValueStore();
      if (engine_kvs != null && KeyValueStore_GetKeyValue (engine_kvs, "minimap_rotated_based_on_camera", false) == true) {
        local camera = Stage_GetActiveCamera();
        if (camera != null) {
          angle = StageObject_GetAngle (camera);
        }
      }
      UI_SetProperty ("mod_thick_gridlines", "angle.z", angle == null ? 0.0 : 0.0 - m_anglemod ((angle + 90.0) * PI / 180.0));
    }
  }
}


function Mod_ThickGridlines_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_thick_gridlines_enabled":
        Game_SetWorldState ("MODS", "thick_gridlines_enabled", UI_GetProperty ("mod_thick_gridlines_enabled", "checkbox.value") == 1 ? "1" : "0");
        break;
      case "mod_thick_gridlines_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Thick grid lines"),
            LocalizeText("Save your eyesight! The grid lines on the mini map are much thicker, to reduce eye-strain."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-thick-gridlines-video")}] );
        break;
    }
  }
}


function Mod_ThickGridlines_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_thick_gridlines_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "thick_gridlines_enabled", 0));
  UI_SetProperty ("mod_thick_gridlines_enabled_title", "textbox.text", LocalizeText("Thick grid lines"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
