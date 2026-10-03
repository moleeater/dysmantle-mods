// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local cursor_ground_clearance = 20.0;
local default_distance = 60.0;
local distance_per_second = 600.0;
local distance_small_stage_divider = 4.0;
local cursor_radians_per_second = 0.1;
local player = null;
local trigger_down_at_stage_milliseconds = null;
local was_trigger_held_down = false;
local distance = null;
local cursor = null;
local cursor_angle = 0.0;
local is_small_stage = true;


Include ("scripts/mods/mods-info.nut");


function Mod_RiftForwards_OnMetadataRead_Item() {
  return {
      icon = "items/specials/mod-rift-forwards.png"
      name = "Rift forwards |img src='emojis/package.png' scale=1.3 offset=2|"
      description = "|img src='emojis/package.png' scale=0.7 offset=2| Open a rift at your feet to arrive a few steps forward."
      use_description = "Teleport players forward a few steps."
      use_description_long_press = "Teleport players forward farther, the longer you hold the button."
      destroy_after_owner_death = true
    };
}


function Mod_RiftForwards_OnTriggerDown_Item() {
  trigger_down_at_stage_milliseconds = Stage_GetTimeMilliseconds();
  is_small_stage = true;
  local stage = Stage_GetFilename();
  if (stage != null) {
    local stage_info = Stage_GetExternalStageInfo (stage);
    if (stage_info != null) {
      if (stage_info.rawin("width_in_cells") == true && stage_info.rawin("height_in_cells") == true
      && (stage_info.rawget("width_in_cells") > 400 || stage_info.rawget("height_in_cells") > 400)) {
        is_small_stage = false;
      }
    }
  }
}


function Mod_RiftForwards_OnTriggerHoldDown_Item() {
  was_trigger_held_down = true;
}


function Mod_RiftForwards_OnTriggerClick_Item() {
  was_trigger_held_down = false;
}


function Mod_RiftForwards_OnTriggerCancel_Item() {
  trigger_down_at_stage_milliseconds = null;
  was_trigger_held_down = false;
  if (cursor != null) {
    Stage_DeleteStageObjectQueued (cursor);
    cursor = null;
  }
}


function Mod_RiftForwards_OnUpdate_Item (tdelta) {
  if (trigger_down_at_stage_milliseconds != null) {
    distance = default_distance;
    if (was_trigger_held_down == true) {
      distance = (Stage_GetTimeMilliseconds() - trigger_down_at_stage_milliseconds) * distance_per_second / 1000.0;
    }
    if (is_small_stage == true) {
      distance = distance / distance_small_stage_divider;
    }
    local position = StageObject_GetStagePosition (player);
    local angle = StageObject_GetAngle (player);
    if (position != null && angle != null) {
      local radian = m_anglemod (angle * PI / 180.0);
      local destination_x = position[0] + cos(radian) * distance;
      local destination_y = position[1] + sin(radian) * distance;
      local ground_z = Stage_GetGroundZAtPosition (destination_x, destination_y);
      if (ground_z != null) {
        if (cursor == null) {
          cursor = Stage_CreateActor ("actors/mods/mod-rift-forwards-cursor.xml", destination_x, destination_y, ground_z - cursor_ground_clearance, false);
          cursor_angle = 0.0;
        } else {
          StageObject_SetPosition (cursor, destination_x, destination_y, ground_z - cursor_ground_clearance);
          cursor_angle += tdelta.tofloat() * cursor_radians_per_second * 1000.0;
          StageObject_SetAngle (cursor, cursor_angle);
        }
      }
    }
  }
}


function Mod_RiftForwards_OnTriggerUp_Item() {
  if (trigger_down_at_stage_milliseconds != null) {
    trigger_down_at_stage_milliseconds = null;
    was_trigger_held_down = false;
    if (cursor != null) {
      Stage_DeleteStageObjectQueued (cursor);
      cursor = null;
    }
    local position = StageObject_GetStagePosition (player);
    local angle = StageObject_GetAngle (player);
    if (position != null && angle != null) {
      local radian = m_anglemod (angle * PI / 180.0);
      Game_TeleportPlayers (position[0] + cos(radian) * distance, position[1] + sin(radian) * distance);
      Game_LogEvent ("MOD_RIFT_FORWARDS", round(distance).tostring());
    }
    distance = null;
  }
}


function Mod_RiftForwards_OnInitialize_Item (so_handle_owner, item_id) {
  player = so_handle_owner;
  return true;
}


function Mod_RiftForwards_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_rift_forwards_craft":
        if (Game_IsRecipeCrafted ("MOD_RIFT_FORWARDS") != true) {
          Game_CraftRecipe ("MOD_RIFT_FORWARDS", true);
        }
        UI_SetProperty ("mod_rift_forwards_craft", "active", false);
        break;
      case "mod_rift_forwards_title":
        Mods_Info_Popup (
            LocalizeText("Rift forwards"),
            LocalizeText("Teleport players forwards a few steps, or even half the map. Climb hills, descend cliffs, bypass doors, traverse seas."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-rift-forwards-video")}] );
        break;
    }
  }
}


function Mod_RiftForwards_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_rift_forwards_craft", "active", Game_IsRecipeCrafted ("MOD_RIFT_FORWARDS") == true ? false : true);
  UI_SetProperty ("mod_rift_forwards_craft", "button.text", LocalizeText("Craft"));
  UI_SetProperty ("mod_rift_forwards_title", "textbox.text", LocalizeText("Rift forwards"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
