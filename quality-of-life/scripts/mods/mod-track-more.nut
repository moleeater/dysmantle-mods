// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local interval_realseconds = 3.0;
local mattrack_magic_number_big = 1050.0;
local mattrack_magic_number_small = 90.0;
local quests_magic_number_big = 970.0;
local quests_magic_number_small = 25.0;
local update_in_realseconds = 0.0;
local prev_ui_scale_modifier = null;
local prev_screen_width = null;
local prev_screen_height = null;
local prev_tools_height_multiplier = null;


Include ("scripts/mods/mods-info.nut");


function Mod_TrackMore_OnUpdate_Stage (tdelta) {
  update_in_realseconds -= tdelta;
  if (NX_ProductFeatureExists ("MOBILE_UI") != true && Game_GetWorldStateAsInteger ("MODS", "track_more_enabled", 0) == 1) {
    if (update_in_realseconds < 0.0) {
      update_in_realseconds = interval_realseconds;
      local screen_width = UI_GetVirtualScreenWidth();
      local screen_height = UI_GetVirtualScreenHeight();
      local engine_kvs = Engine_GetKeyValueStore();
      local tools_height = UI_GetProperty ("Player_0_Tools", "height");
      local minimap_height = UI_GetProperty ("marker_map", "height");
      if (screen_width != null && screen_height != null && engine_kvs != null && tools_height != null && minimap_height != null) {
        local ui_scale_modifier = KeyValueStore_GetKeyValue (engine_kvs, "ui_scale_modifier", 0.0);
        local tools_height_multiplier = Game_GetPlayerActor (1) == null ? 1.0 : 2.0;
        if (prev_screen_width != screen_width || prev_screen_height != screen_height || ui_scale_modifier != prev_ui_scale_modifier || tools_height_multiplier != prev_tools_height_multiplier) {
          local mattrack_ui_scale_modifier = UI_GetProperty ("MaterialTracking", "ui_scale_modifier");
          if (mattrack_ui_scale_modifier == null) mattrack_ui_scale_modifier = 0.0;
          local mattrack_scale = UI_GetProperty ("MaterialTracking", "scale");
          if (mattrack_scale == null) mattrack_scale = 1.0;
          local mattrack_scale_multiplier = UI_GetProperty ("MaterialTracking", "scale_multiplier");
          if (mattrack_scale_multiplier == null) mattrack_scale_multiplier = 1.0;
          local mattrack_scale_modifier = (ui_scale_modifier.tofloat() * mattrack_ui_scale_modifier.tofloat() + 1.0) * mattrack_scale.tofloat() * mattrack_scale_multiplier.tofloat() * screen_width.tofloat() / screen_height.tofloat();
          local mattrack_area_height = (mattrack_magic_number_big - mattrack_magic_number_small * mattrack_scale_modifier - tools_height.tofloat() * tools_height_multiplier) / (mattrack_scale_modifier * 0.95);
          UI_SetProperty ("MaterialTracking", "marker.area_height", mattrack_area_height);
          KeyValueStore_SetKeyValueInteger (engine_kvs, "max_tracked_recipes", 12);
          local quests_ui_scale_modifier = UI_GetProperty ("Quests", "ui_scale_modifier");
          if (quests_ui_scale_modifier == null) quests_ui_scale_modifier = 0.0;
          local quests_scale = UI_GetProperty ("Quests", "scale");
          if (quests_scale == null) quests_scale = 1.0;
          local quests_scale_multiplier = UI_GetProperty ("Quests", "scale_multiplier");
          if (quests_scale_multiplier == null) quests_scale_multiplier = 1.0;
          local quests_scale_modifier = (ui_scale_modifier.tofloat() * quests_ui_scale_modifier.tofloat() + 1.0) * quests_scale.tofloat() * quests_scale_multiplier.tofloat() * screen_width.tofloat() / screen_height.tofloat();
          local quests_area_height = (quests_magic_number_big - quests_magic_number_small * quests_scale_modifier - minimap_height.tofloat()) / (quests_scale_modifier * 0.95);
          UI_SetProperty ("Quests", "marker.area_height", quests_area_height);
          KeyValueStore_SetKeyValueInteger (engine_kvs, "max_tracked_quests", 10);
          prev_screen_width = screen_width;
          prev_screen_height = screen_height;
          prev_ui_scale_modifier = ui_scale_modifier;
          prev_tools_height_multiplier = tools_height_multiplier;
        }
      }
    }
  }
}


function Mod_TrackMore_OnEnter_Stage() {
  if (NX_ProductFeatureExists ("MOBILE_UI") != true) {
    if (Game_GetWorldStateAsInteger ("MODS", "track_more_enabled", 0) == 1) {
      prev_ui_scale_modifier = null;
      prev_screen_width = null;
      prev_screen_height = null;
      prev_tools_height_multiplier = null;
    } else {
      local engine_kvs = Engine_GetKeyValueStore();
      if (engine_kvs != null) {
        KeyValueStore_SetKeyValueInteger (engine_kvs, "max_tracked_recipes", 4);
        KeyValueStore_SetKeyValueInteger (engine_kvs, "max_tracked_quests", 4);
      }
    }
  }
}


function Mod_TrackMore_OnScreenMessage_Stage (key, value) {
  if (key == "mod_track_more_ui_update") {
    Mod_TrackMore_OnEnter_Stage();
  }
}


function Mod_TrackMore_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_track_more_enabled":
        local enabled = UI_GetProperty ("mod_track_more_enabled", "checkbox.value") == 1;
        Game_SetWorldState ("MODS", "track_more_enabled", enabled ? "1" : "0");
        UI_SendScreenMessage ("Stage", "mod_track_more_ui_update", "1");
        if (enabled) {
          UI_SetProperty ("mod_track_more_enabled_warning", "textbox.text", LocalizeText("To trigger the change, you might need to move the UI scale slider a bit."));
        }
        UI_SetVisible ("mod_track_more_enabled_warning", enabled);
      break;
      case "mod_track_more_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Track more"),
            LocalizeText("Monitor more quests on screen and recipes for the materials required."));
        break;
    }
  }
}


function Mod_TrackMore_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetVisible ("mod_track_more_enabled_warning", false);
  UI_SetProperty ("mod_track_more_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "track_more_enabled", 0));
  UI_SetProperty ("mod_track_more_enabled_title", "textbox.text", LocalizeText("Track more"));
  UI_SetVisible ("mod_track_more_enabled_title", NX_ProductFeatureExists ("MOBILE_UI") != true);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
