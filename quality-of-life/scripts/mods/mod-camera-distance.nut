// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local scroll_power = 100.0;
local distance_min = -300.0;
local distance_max_mobile = 1500.0;
local distance_max = 4000.0;
local prev_scroll = 0;


Include ("scripts/mods/mods-info.nut");


function Mod_CameraDistance_OnDeathStart_BossMain (boss, same) {
  local distance = Game_GetWorldState ("MODS", "camera_distance");
  return distance == null ? 0.0 : distance.tofloat();
}


function Mod_CameraDistance_OnClick_Stage (clicked) {
  if (clicked == "mod_camera_distance") {
    local slider_value = UI_GetProperty ("mod_camera_distance", "slider.value");
    local distance = (distance_max - distance_min) * slider_value + distance_min;
    Game_SetWorldState ("MODS", "camera_distance", distance.tostring());
    local stage_kvs = Stage_GetKeyValueStore();
    if (stage_kvs != null) {
      KeyValueStore_SetKeyValueFloat (stage_kvs, "camera_distance_modifier", distance.tofloat());
    }
  }
}


function Mod_CameraDistance_OnUpdate_Stage (tdelta) {
  if (NX_IsDeveloperModeEnabled() != true) {
    if (UI_GetNumberOfScreensInStack() > 1 || Game_IsCinemaModeEnabled() == true) {
      prev_scroll = NX_GetKeyStatei (507);
    } else {
      local scroll = NX_GetKeyStatei (507);
      if (scroll != prev_scroll) {
        local distance = Game_GetWorldState ("MODS", "camera_distance");
        distance = distance == null ? 0.0 : distance.tofloat();
        distance = distance + (prev_scroll.tofloat() - scroll.tofloat()) * scroll_power;
        if (distance > distance_max) distance = distance_max;
        if (distance < distance_min) distance = distance_min;
        Game_SetWorldState ("MODS", "camera_distance", distance.tostring());
        local stage_kvs = Stage_GetKeyValueStore();
        if (stage_kvs != null) {
          KeyValueStore_SetKeyValueFloat (stage_kvs, "camera_distance_modifier", distance);
        }
        if (Game_GetWorldStateAsInteger ("MODS", "camera_distance_hud", 0) == 1 && NX_ProductFeatureExists ("MOBILE_UI") != true) {
          local slider_value = (distance.tofloat() - distance_min.tofloat()) / (distance_max.tofloat() - distance_min.tofloat());
          if (slider_value > 1) slider_value = 1.0;
          UI_SetProperty ("mod_camera_distance", "slider.value", slider_value.tofloat());
        }
        prev_scroll = NX_GetKeyStatei (507);
      }
    }
  }
}


function Mod_CameraDistance_OnEnter_Stage() {
  if (NX_IsDeveloperModeEnabled() != true) {
    prev_scroll = NX_GetKeyStatei (507);
  }
  if (NX_ProductFeatureExists ("MOBILE_UI") == true) {
    distance_max = distance_max_mobile;
  }
  UI_SetVisible ("mod_camera_distance", false);
  local distance = Game_GetWorldState ("MODS", "camera_distance");
  if (distance == null) distance = 0.0;
  local stage = Stage_GetFilename();
  local stage_info = null;
  if (stage != null) {
    stage_info = Stage_GetExternalStageInfo (stage);
    local is_small_stage = false;
    if (stage_info == null) {
      is_small_stage = true;
    } else if (stage_info.rawin("width_in_cells") != true || stage_info.rawin("height_in_cells") != true
    || (stage_info.rawget("width_in_cells") < 400 && stage_info.rawget("height_in_cells") < 400)) {
      is_small_stage = true;
    }
    if (is_small_stage == true) {
      distance = 0.0;
    }
  }
  local stage_kvs = Stage_GetKeyValueStore();
  if (stage_kvs != null) {
    KeyValueStore_SetKeyValueFloat (stage_kvs, "camera_distance_modifier", distance.tofloat());
  }
  if (Game_GetWorldStateAsInteger ("MODS", "camera_distance_hud", 0) == 1 && NX_ProductFeatureExists ("MOBILE_UI") != true) {
    local slider_value = (distance.tofloat() - distance_min.tofloat()) / (distance_max.tofloat() - distance_min.tofloat());
    if (slider_value > 1) slider_value = 1.0;
    UI_SetProperty ("mod_camera_distance", "slider.value", slider_value.tofloat());
    UI_SetVisible ("mod_camera_distance", true);
  }
}


function Mod_CameraDistance_OnScreenMessage_Stage (key, value) {
  if (key != null) {
    switch (key) {
      case "mod_camera_distance_hud_message":
        UI_SetVisible ("mod_camera_distance", value == "1" ? true : false);
        if (value == "1") {
          local distance = Game_GetWorldState ("MODS", "camera_distance");
          distance = distance == null ? 0.0 : distance.tofloat();
          local slider_value = (distance.tofloat() - distance_min.tofloat()) / (distance_max.tofloat() - distance_min.tofloat());
          if (slider_value > 1) slider_value = 1.0;
          UI_SetProperty ("mod_camera_distance", "slider.value", slider_value.tofloat());
        }
        break;
      case "mod_camera_distance_message":
        UI_SetProperty ("mod_camera_distance", "slider.value", value.tofloat());
        break;
    }
  }
}


function Mod_CameraDistance_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_camera_distance":
        local slider_value = UI_GetProperty ("mod_camera_distance", "slider.value");
        local distance = (distance_max - distance_min) * slider_value + distance_min;
        Game_SetWorldState ("MODS", "camera_distance", distance.tostring());
        local stage_kvs = Stage_GetKeyValueStore();
        if (stage_kvs != null) {
          KeyValueStore_SetKeyValueFloat (stage_kvs, "camera_distance_modifier", distance.tofloat());
        }
        if (NX_ProductFeatureExists ("MOBILE_UI") != true) {
          UI_SendScreenMessage ("Stage", "mod_camera_distance_message", slider_value.tostring());
        }
        UI_SetProperty ("mod_camera_distance_notice", "textbox.text", distance.tofloat() > 1500.0 && NX_CallExtension ("PlatformInfo", "PlatformId") == "WINDOWS" ? LocalizeText("Download 'CE hacks' from NexusMods!") : LocalizeText("Install separate Disable fog mod."));
        UI_SetVisible ("mod_camera_distance_notice", (NX_FileExists ("mod-disable-fog-canary.txt") != true && distance.tofloat() > 0.0) || distance.tofloat() > 1500.0);
        break;
      case "KeyValue_FLOAT_camera_distance":
        UI_SetProperty ("mod_camera_distance_vanilla_clone", "slider.value", UI_GetProperty ("KeyValue_FLOAT_camera_distance", "slider.value"));
        break;
      case "mod_camera_distance_vanilla_clone":
        UI_SetProperty ("KeyValue_FLOAT_camera_distance", "slider.value", UI_GetProperty ("mod_camera_distance_vanilla_clone", "slider.value"));
        break;
      case "mod_camera_distance_hud":
        local enabled = UI_GetProperty ("mod_camera_distance_hud", "checkbox.value");
        Game_SetWorldState ("MODS", "camera_distance_hud", enabled.tostring());
        UI_SendScreenMessage ("Stage", "mod_camera_distance_hud_message", enabled.tostring());
        break;
      case "mod_camera_distance_title":
      case "mod_camera_distance_vanilla_clone_title":
        Mods_Info_Popup (
            LocalizeText("Camera distance modifier"),
            LocalizeText("Zoom the camera up closer or way up far. Fog can be removed by a standalone mod.") + " " + LocalizeText("Mouse wheel is also supported.")
              + (NX_ProductFeatureExists ("MOBILE_UI") != true ? "\n\n" + LocalizeText("Extreme far distances only work if you use\n'CE hacks' from NexusMods!") : "")
              + "\n\n" + LocalizeText("HUD") + ": " + LocalizeText("Zoom the camera up closer or way up far, with an always on-screen slider, left to the minimap.")
              + "\n\n" + LocalizeText("Camera Distance:") + " " + LocalizeText("This slider is a copy of the vanilla Camera Distance slider under the Graphics tab."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-camera-distance-video")}] );
        break;
    }
  }
}


function Mod_CameraDistance_OnEnter_OptionsUnified (stage_in_stack) {
  if (NX_ProductFeatureExists ("MOBILE_UI") == true) {
    distance_max = distance_max_mobile;
  }
  local distance = Game_GetWorldState ("MODS", "camera_distance");
  if (distance == null) distance = 0.0;
  local slider_value = (distance.tofloat() - distance_min.tofloat()) / (distance_max.tofloat() - distance_min.tofloat());
  if (slider_value > 1) slider_value = 1.0;
  UI_SetProperty ("mod_camera_distance_title", "textbox.text", LocalizeText("Camera distance modifier"));
  UI_SetProperty ("mod_camera_distance", "slider.value", slider_value.tofloat());
  UI_SetProperty ("mod_camera_distance_hud_title", "textbox.text", LocalizeText("HUD") + ":");
  UI_SetProperty ("mod_camera_distance_hud", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "camera_distance_hud", 0));
  UI_SetProperty ("mod_camera_distance_vanilla_clone", "slider.value", UI_GetProperty ("KeyValue_FLOAT_camera_distance", "slider.value"));
  UI_SetProperty ("mod_camera_distance_vanilla_clone_title", "textbox.text", LocalizeText("Camera Distance:"));
  UI_SetProperty ("mod_camera_distance_notice", "textbox.text", distance.tofloat() > 1500.0 && NX_CallExtension ("PlatformInfo", "PlatformId") == "WINDOWS" ? LocalizeText("Download 'CE hacks' from NexusMods!") : LocalizeText("Install separate Disable fog mod."));
  UI_SetVisible ("mod_camera_distance_notice", (NX_FileExists ("mod-disable-fog-canary.txt") != true && distance.tofloat() > 0.0) || distance.tofloat() > 1500.0);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
