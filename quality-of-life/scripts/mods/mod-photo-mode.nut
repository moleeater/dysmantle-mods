// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_PhotoMode_OnEnter_Stage() {
  local engine_kvs = Engine_GetKeyValueStore();
  local show_fps_enabled = KeyValueStore_GetKeyValue (engine_kvs, "show_fps", false);
  if (show_fps_enabled != true) {
    show_fps_enabled = Game_GetWorldStateAsInteger ("MODS", "show_fps_enabled", 0) == 1 ? true : false;
  }
  KeyValueStore_SetKeyValueBoolean (engine_kvs, "show_fps", show_fps_enabled);
  Game_SetWorldState ("MODS", "show_fps_enabled", show_fps_enabled ? "1" : "0");
}


function Mod_PhotoMode_OnClick_OptionsUnified (clicked) {
  local engine_kvs = Engine_GetKeyValueStore();
  if (clicked != null) {
    switch (clicked) {
      case "mod_show_fps_enabled":
        local show_fps_enabled = UI_GetProperty (clicked, "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "show_fps_enabled", show_fps_enabled ? "1" : "0");
        KeyValueStore_SetKeyValueBoolean (engine_kvs, "show_fps", show_fps_enabled);
        UI_SetVisible ("mod_show_fps_enabled_warning", false);
        UI_SetVisible ("mod_photo_mode_enabled_warning", false);
        if (show_fps_enabled) {
          if (UI_GetProperty ("mod_photo_mode_enabled", "checkbox.value") == 1) {
            UI_SetProperty ("mod_photo_mode_enabled", "checkbox.value", 0);
            UI_SetVisible ("mod_photo_mode_enabled_warning", show_fps_enabled);
            UI_SetProperty ("mod_photo_mode_enabled_warning", "textbox.text", LocalizeText("Turned off by Show FPS."));
          }
          KeyValueStore_SetKeyValueBoolean (engine_kvs, "draw_ui", true);
          KeyValueStore_SetKeyValueBoolean (engine_kvs, "draw_interaction_tooltips", true);
        }
        break;
      case "mod_photo_mode_enabled":
        local photo_mode_enabled = UI_GetProperty (clicked, "checkbox.value") == 1 ? true : false;
        KeyValueStore_SetKeyValueBoolean (engine_kvs, "draw_ui", photo_mode_enabled ? false : true);
        KeyValueStore_SetKeyValueBoolean (engine_kvs, "draw_interaction_tooltips", photo_mode_enabled ? false : true);
        UI_SetVisible ("mod_show_fps_enabled_warning", false);
        UI_SetVisible ("mod_photo_mode_enabled_warning", false);
        if (photo_mode_enabled) {
          if (UI_GetProperty ("mod_show_fps_enabled", "checkbox.value") == 1) {
            UI_SetProperty ("mod_show_fps_enabled", "checkbox.value", 0);
            UI_SetVisible ("mod_show_fps_enabled_warning", photo_mode_enabled);
            UI_SetProperty ("mod_show_fps_enabled_warning", "textbox.text", LocalizeText("Turned off by Photo mode."));
          }
          Game_SetWorldState ("MODS", "show_fps_enabled", "0");
          KeyValueStore_SetKeyValueBoolean (engine_kvs, "show_fps", false);
        }
        break;
      case "mod_show_fps_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Show FPS"),
            LocalizeText("Show in-game FPS without activating developer mode."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-show-fps-video")}] );
        break;
      case "mod_photo_mode_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Photo mode"),
            LocalizeText("Hide all UI element on the HUD with the Photo mode, so you can take a pretty screenshot."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-photo-mode-video")}] );
        break;
    }
  }
}


function Mod_PhotoMode_OnEnter_OptionsUnified (stage_in_stack) {
  local engine_kvs = Engine_GetKeyValueStore();
  local photo_mode_enabled = KeyValueStore_GetKeyValue (engine_kvs, "draw_ui", true);
  if (photo_mode_enabled == false) {
    UI_SetProperty ("mod_photo_mode_enabled", "checkbox.value", 1);
  }
  UI_SetProperty ("mod_show_fps_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "show_fps_enabled", 0));
  UI_SetProperty ("mod_show_fps_enabled_title", "textbox.text", LocalizeText("Show FPS"));
  UI_SetProperty ("mod_photo_mode_enabled_title", "textbox.text", LocalizeText("Photo mode"));
  UI_SetVisible ("mod_show_fps_enabled_warning", false);
  UI_SetVisible ("mod_photo_mode_enabled_warning", false);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
