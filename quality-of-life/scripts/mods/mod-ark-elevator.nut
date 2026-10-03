// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local stages = [
    "stages/island/index.xml",
    "stages/special/the-ark.stage",
    "stages/special/the-ark-level-2.stage",
    "stages/special/the-ark-level-3.stage",
    "stages/special/the-ark-level-4.stage",
  ];
local entrances = {
    "0d": "ark",
    "1u": "entrance_1",
    "1d": "entrance_level_2",
    "2u": "entrance_1",
    "2d": "entrance_level_2_secret",
    "3u": "entrance_1",
    "3d": "entrance_level_4",
    "4u": "entrance_1",
  };
local from_to = {
    "0d": [ "1u", "2u", "3u", "4u" ],
    "2u": [ "0d" ],
    "2d": [ "3u", "4u" ],
    "3u": [ "0d", "2d" ],
    "4u": [ "0d", "2d", "3d" ],
  };
local is_elevator_screen = false;
local platform_id = null;


function Mod_ArkElevator_PressButton_ArkEntrance (ark, player) {
  if (Game_IsStageDiscovered ("stages/special/the-ark.stage") != true) {
    return null;
  }
  return Mod_ArkElevator_PressButton_ElevatorLiftPlatform (ark, player);
}


function Mod_ArkElevator_PressButton_ElevatorLiftPlatform (platform, player) {
  local stage = Stage_GetFilename();
  if (stage != null) {
    local level = stages.find(stage);
    platform_id = StageObject_GetId (platform);
    if (level != null && platform_id != null) {
      local platform_code = null;
      foreach (entrance_code, entrance_id in entrances) {
        if (entrance_code.slice(0, 1) == level.tostring() && entrance_id == platform_id) {
          platform_code = entrance_code;
          break;
        }
      }
      if (platform_code != null && from_to.rawin(platform_code) == true) {
        local destination_codes = from_to[platform_code].filter(@(index, code) Game_IsStageDiscovered (stages[code.slice(0, 1).tointeger()]));
        if (destination_codes != null && destination_codes.len() > 0) {
          if (destination_codes.len() == 1) {
            local kvs = StageObject_GetKeyValueStore (platform);
            if (kvs != null) {
              KeyValueStore_SetKeyValueStage (kvs, "stage", stages[destination_codes[0].slice(0, 1).tointeger()]);
              KeyValueStore_SetKeyValueString (kvs, "travel_to_entrance_id", entrances[destination_codes[0]]);
            }
          } else {
            local floors = [ null, null, null, null, null ];
            foreach (floor_num, value in floors) {
              local destination_code = null;
              foreach (code in destination_codes) {
                if (code.slice(0, 1).tointeger() == floor_num) {
                  destination_code = code;
                }
              }
              floors[floor_num] = destination_code == null ? floor_num.tostring() + "x" : destination_code;
            }
            UI_SendScreenMessage ("PopupMessage", "Mode", "MOD_ARK_ELEVATOR");
            local floorstr = floors.reduce(@(first, next) (first == null ? "" : first) + (next == null ? "" : "," + next));
            UI_ShowPopup ("", "", floorstr == null ? "" : floorstr);
            UI_SendScreenMessage ("PopupMessage", "mod_ark_elevator_platform_id", platform_id);
            return true;
          }
        }
      }
    }
  }
}


function Mod_ArkElevator_OnScreenMessage_PopupMessage (key, value) {
  if (key != null) {
    switch (key) {
      case "Mode":
        if (value == "MOD_ARK_ELEVATOR") {
          is_elevator_screen = true;
          UI_SetProperty ("panel", "ninepatch.automatic_content_padding", 30);
          UI_SetProperty ("panel", "ninepatch.automatic_content_width", true);
          UI_SetProperty ("panel", "shader_effect", "");
          UI_SetProperty ("panel", "color", 0.33, 0.33, 0.33, 1);
          UI_SetProperty ("panel", "scale", 1.1);
          UI_SetProperty ("aligner_2", "scale", 1);
          UI_SetProperty ("aligner_2", "position.y", 0);
          UI_SetProperty ("aligner_2", "aligner.automatic_area_width", true);
          UI_SetVisible ("marker_1", false);
          UI_SetProperty ("aligner_1", "aligner.layout", 1);
          UI_SetProperty ("aligner_1", "aligner.min_padding", 10);
          UI_SetProperty ("aligner_1", "aligner.fixed_num_columns", 1);
          UI_SetProperty ("aligner_1", "aligner.fixed_num_rows", 0);
          UI_SetProperty ("aligner_1", "aligner.align_x_axis", true);
          UI_SetProperty ("aligner_1", "scale", 1);
          UI_SetProperty ("aligner_1", "aligner.automatic_area_width", true);
          UI_SetProperty ("aligner_1", "aligner.automatic_area_height", true);
          UI_SetVisible ("marker_2", false);
        }
        break;
      case "mod_ark_elevator_platform_id":
        platform_id = value;
        break;
    }
  }
}


function Mod_ArkElevator_OnEnter_PopupMessage() {
  if (is_elevator_screen == true) {
    UI_SetVisible ("Title", false);
    UI_SetVisible ("Text", false);
    foreach (button_num in [0,1,2,3,4]) {
      local code = UI_GetProperty ("Button_" + button_num.tostring(), "user_string");
      if (code != null) {
        UI_SetProperty ("Button_" + button_num.tostring(), "button.text", "");
        UI_SetProperty ("Button_" + button_num.tostring(), "button.bm_idle", "!NONE");
        UI_SetProperty ("Button_" + button_num.tostring(), "button.bm_over", "!NONE");
        UI_SetProperty ("Button_" + button_num.tostring(), "button.bm_pressed", "!NONE");
        UI_SetProperty ("Button_" + button_num.tostring(), "button.bm_disabled", "!NONE");
        UI_SetProperty ("Button_" + button_num.tostring(), "button.draw_mode", 0);
        UI_SetProperty ("Button_" + button_num.tostring(), "button.scale_over", 1.3);
        UI_SetProperty ("Button_" + button_num.tostring(), "button.scale_pressed", 1.1);
        UI_SetProperty ("Button_" + button_num.tostring(), "button.bm_icon", "controller-art/wasdmouse/button-" + code.slice(0, 1) + ".png");
        local act = code.slice(1, 2) == "x" ? false : true;
        UI_SetProperty ("Button_" + button_num.tostring(), "button.icon_color", act ? 1 : 0.33, act ? 1 : 0.33, act ? 1 : 0.33, 1);
        UI_SetProperty ("Button_" + button_num.tostring(), "active", act);
      }
    }
  }
}


function Mod_ArkElevator_OnClick_PopupMessage (clicked) {
  if (is_elevator_screen == true && clicked != null && clicked.len() > 7 && clicked.slice(0, 7) == "Button_") {
    local destination_code = UI_GetProperty (clicked, "user_string");
    local platform = Stage_GetStageObjectById (platform_id, STAGE_OBJECT_TYPE_ACTOR);
    local kvs = StageObject_GetKeyValueStore (platform);
    if (kvs != null) {
      local destination_level = destination_code.slice(0, 1).tointeger();
      KeyValueStore_SetKeyValueStage (kvs, "stage", stages[destination_level]);
      KeyValueStore_SetKeyValueString (kvs, "travel_to_entrance_id", entrances[destination_code]);
      local stage = Stage_GetFilename();
      if (stage != null) {
        local current_level = stages.find(stage);
        if (current_level != null) {
          Game_LogEvent ("MOD_ARK_ELEVATOR", current_level.tostring() + ">" + destination_level.tostring());
        }
      }
    }
    switch (Actor_GetActorType (platform)) {
      case "actors/interactives/elevator-lift-platform.xml":
        local animation = StageObject_GetKeyValue (platform, "leave_animation");
        Actor_PlayAnimation (platform, animation);
        Game_SetCinemaMode (true);
        Game_SetScreenFadeOutWithCommand (0.5, "travel_to_stage", platform, 1.0);
        break;
      case "actors/objects/ark-entrance.xml":
        Game_SetScreenFadeOutWithCommand (0.6, "travel_to_stage", platform, 0.65);
        break;
    }
  }
}


function Mod_ArkElevator_OnLeave_PopupMessage() {
  is_elevator_screen = false;
  UI_SetVisible ("marker_1", true);
  UI_SetVisible ("Title", true);
  UI_SetVisible ("Text", true);
  UI_SetVisible ("marker_2", true);
  foreach (button_num in [0,1,2,3,4]) {
    UI_SetProperty ("Button_" + button_num.tostring(), "active", true);
    UI_SetProperty ("Button_" + button_num.tostring(), "button.bm_icon", "!NONE");
    UI_SetProperty ("Button_" + button_num.tostring(), "button.bm_idle", "ui/gfx/button-idle-ninepatch.png");
    UI_SetProperty ("Button_" + button_num.tostring(), "button.bm_over", "ui/gfx/button-idle-ninepatch.png");
    UI_SetProperty ("Button_" + button_num.tostring(), "button.bm_pressed", "ui/gfx/button-idle-ninepatch.png");
    UI_SetProperty ("Button_" + button_num.tostring(), "button.bm_disabled", "ui/gfx/button-idle-ninepatch.png");
    UI_SetProperty ("Button_" + button_num.tostring(), "button.icon_color", 1, 1, 1, 1);
    UI_SetProperty ("Button_" + button_num.tostring(), "button.scale_over", 1.001);
    UI_SetProperty ("Button_" + button_num.tostring(), "button.scale_pressed", 0.99);
    UI_SetProperty ("Button_" + button_num.tostring(), "button.draw_mode", 1);
  }
  UI_SetProperty ("aligner_1", "aligner.layout", 0);
  UI_SetProperty ("aligner_1", "aligner.min_padding", 0.1);
  UI_SetProperty ("aligner_1", "aligner.fixed_num_columns", 0);
  UI_SetProperty ("aligner_1", "aligner.fixed_num_rows", 1);
  UI_SetProperty ("aligner_1", "aligner.align_x_axis", true);
  UI_SetProperty ("aligner_1", "scale", 0.92);
  UI_SetProperty ("aligner_1", "aligner.automatic_area_width", false);
  UI_SetProperty ("aligner_1", "aligner.automatic_area_height", false);
  UI_SetProperty ("aligner_2", "scale", 0.9);
  UI_SetProperty ("aligner_2", "position.y", -0.04);
  UI_SetProperty ("aligner_2", "aligner.automatic_area_width", false);
  UI_SetProperty ("panel", "shader_effect", "DecayPanel");
  UI_SetProperty ("panel", "color", 1, 1, 1, 1);
  UI_SetProperty ("panel", "scale", 1);
  UI_SetProperty ("panel", "ninepatch.automatic_content_padding", 14);
  UI_SetProperty ("panel", "ninepatch.automatic_content_width", false);
}


function Mod_ArkElevator_OnBackAction_PopupMessage() {
  if (is_elevator_screen == true && platform_id != null) {
    local platform = Stage_GetStageObjectById (platform_id, STAGE_OBJECT_TYPE_ACTOR);
    switch (Actor_GetActorType (platform)) {
      case "actors/interactives/elevator-lift-platform.xml":
        local animation = StageObject_GetKeyValue (platform, "leave_animation");
        Actor_PlayAnimation (platform, animation);
        Game_SetCinemaMode (true);
        Game_SetScreenFadeOutWithCommand (0.5, "travel_to_stage", platform, 1.0);
        break;
      case "actors/objects/ark-entrance.xml":
        Game_SetScreenFadeOutWithCommand (0.6, "travel_to_stage", platform, 0.65);
        break;
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
