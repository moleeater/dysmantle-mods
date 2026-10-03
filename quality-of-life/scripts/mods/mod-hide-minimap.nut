// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_HideMinimap_OnDraw_Stage() {
  local enabled = Game_GetWorldStateAsInteger ("MODS", "hide_minimap_enabled", 0) == 1;
  local camera = Stage_GetActiveCamera();
  local angle = null;
  if (camera != null) {
    angle = StageObject_GetAngle (camera);
  }
  if (! enabled || angle == null) {
    UI_SetVisible ("mod_hide_minimap_compass", false);
    UI_SetVisible ("mod_hide_minimap_interactive", false);
    UI_SetProperty ("marker_map", "ui_scale_modifier", 0.2);
    UI_SetProperty ("marker_map", "scale", 1.0);
  } else {
    UI_SetProperty ("mod_hide_minimap_compass", "angle.z", 0.0 - m_anglemod ((angle + 90.0) * PI / 180.0));
    if (enabled) {
      UI_SetVisible ("mod_hide_minimap_compass", true);
      UI_SetVisible ("mod_hide_minimap_interactive", true);
      UI_SetProperty ("marker_map", "ui_scale_modifier", 0.0);
      UI_SetProperty ("marker_map", "scale", 0.8);
    }
  }
}


function Mod_HideMinimap_OnClick_Stage (clicked) {
  if (clicked == "mod_hide_minimap_interactive") {
    local enable = Game_GetWorldStateAsInteger ("MODS", "hide_minimap_enabled", 0) == 1 ? false : true;
    Game_SetWorldState ("MODS", "hide_minimap_enabled", enable ? "1" : "0");
  }
}


function Mod_HideMinimap_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_hide_minimap_enabled":
        local enabled = UI_GetProperty ("mod_hide_minimap_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "hide_minimap_enabled", enabled ? "1" : "0");
        break;
      case "mod_hide_minimap_enabled_title":
        Mods_Info_Popup (LocalizeText("Hide minimap"), LocalizeText("Cover minimap with a compass to help your immersion in the game world."));
        break;
    }
  }
}


function Mod_HideMinimap_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_hide_minimap_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "hide_minimap_enabled", 0));
  UI_SetProperty ("mod_hide_minimap_enabled_title", "textbox.text", LocalizeText("Hide minimap"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
