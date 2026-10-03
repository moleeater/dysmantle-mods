// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local is_activated = false;
local is_updated = false;


function Mod_CollapsiblePOIs_UpdateHeights() {
  local area = 0;
  local area_exists = false;
  do {
    local title = "AreaTitle_" + area.tostring() + "_POINTS_OF_INTEREST";
    area_exists = UI_GetProperty (title, "name") == title;
    if (area_exists) {
      local title_user_string = UI_GetProperty (title, "user_string");
      local collapsed = title_user_string == "collapsed" ? true : false;
      local area_user_string = UI_GetProperty ("Area_POINTS_OF_INTEREST_" + area.tostring(), "user_string");
      local marker_area_height = area_user_string == null ? UI_GetProperty ("Area_POINTS_OF_INTEREST_" + area.tostring(), "marker.area_height") : area_user_string.tointeger();
      UI_SetProperty ("Area_POINTS_OF_INTEREST_" + area.tostring(), "marker.area_height", collapsed ? 35 : marker_area_height);
    }
    area++;
  } while (area_exists);
}


function Mod_CollapsiblePOIs_OnClick_PauseMenu (clicked) {
  Mod_CollapsiblePOIs_UpdateHeights();
  if (clicked.len() > 29 && clicked.slice(0, 10) == "AreaTitle_" && clicked.slice(clicked.len() - 19) == "_POINTS_OF_INTEREST") {
    local captured = regexp("AreaTitle_([0-9]+)_POINTS_OF_INTEREST").capture(clicked);
    if (captured != null && captured[1] != null && captured[1].begin != 0 && captured[1].end != 0) {
      local area = clicked.slice(captured[1].begin, captured[1].end).tointeger();
      local title_user_string = UI_GetProperty (clicked, "user_string");
      local collapsed = title_user_string == "collapsed" ? true : false;
      local area_user_string = UI_GetProperty ("Area_POINTS_OF_INTEREST_" + area.tostring(), "user_string");
      local marker_area_height = area_user_string == null ? UI_GetProperty ("Area_POINTS_OF_INTEREST_" + area.tostring(), "marker.area_height") : area_user_string.tointeger();
      if (area_user_string == null) {
        UI_SetProperty ("Area_POINTS_OF_INTEREST_" + area.tostring(), "user_string", marker_area_height.tostring());
      }
      local item = 0;
      local item_exists = false;
      do {
        local icon = "Col_POINTS_OF_INTEREST_A_" + area.tostring() + "_I_" + item.tostring();
        item_exists = UI_GetProperty (icon, "name") == icon;
        if (item_exists) {
          UI_SetVisible (icon, collapsed);
        }
        item++;
      } while (item_exists);
      UI_SetProperty ("Area_POINTS_OF_INTEREST_" + area.tostring(), "marker.area_height", collapsed ? marker_area_height : 35);
      UI_SetProperty (clicked, "user_string", collapsed ? "" : "collapsed");
    }
  }
  is_updated = false;
}


function Mod_CollapsiblePOIs_OnUpdate_PauseMenu (tdelta) {
  if (! is_activated || ! is_updated) {
    local area = 0;
    local area_exists = false;
    do {
      local title = "AreaTitle_" + area.tostring() + "_POINTS_OF_INTEREST";
      area_exists = UI_GetProperty (title, "name") == title;
      if (area_exists) {
        if (! is_activated) {
          UI_SetProperty (title, "active", true);
        }
        if (! is_updated) {
          local title_user_string = UI_GetProperty (title, "user_string");
          local collapsed = title_user_string == "collapsed" ? true : false;
          local item = 0;
          local item_exists = false;
          do {
            local icon = "Col_POINTS_OF_INTEREST_A_" + area.tostring() + "_I_" + item.tostring();
            item_exists = UI_GetProperty (icon, "name") == icon;
            if (item_exists) {
              UI_SetVisible (icon, ! collapsed);
            }
            item++;
          } while (item_exists);
        }
      }
      area++;
    } while (area_exists);
    if (! is_activated && UI_GetProperty ("AreaTitle_0_POINTS_OF_INTEREST", "name") == "AreaTitle_0_POINTS_OF_INTEREST") {
      is_activated = true;
    }
    if (! is_updated && UI_GetProperty ("Col_POINTS_OF_INTEREST_A_0_I_0", "name") == "Col_POINTS_OF_INTEREST_A_0_I_0") {
      is_updated = true;
    }
  }
}


function Mod_CollapsiblePOIs_OnEnter_PauseMenu() {
  Mod_CollapsiblePOIs_UpdateHeights();
  is_updated = false;
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
