// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local increase_seconds = 50000000.0;
local increase_maximum = 900;


Include ("scripts/mods/mods-info.nut");


function Mod_PowerWalking_OnClick_Stage (clicked) {
  if (clicked == "mod_power_walking") {
    local slider_value = UI_GetProperty ("mod_power_walking", "slider.value");
    local increase = slider_value == null ? 0 : round(slider_value.tofloat() * increase_maximum.tofloat());
    Game_SetWorldState ("MODS", "power_walking_increase", increase.tostring());
    foreach (player_index in [0,1]) {
      local player = Game_GetPlayerActor (player_index);
      if (player != null) {
        local correction = 0.0 - increase.tofloat() / (increase.tofloat() + 100.0) * 100.0;
        Game_SetTemporaryModifier (player, "mod_power_walking", increase_seconds, "move_speed_percentage_increase", increase.tofloat());
        Game_SetTemporaryModifier (player, "mod_power_walking", increase_seconds, "running_speed_percentage_increase", correction);
      }
    }
  }
}


function Mod_PowerWalking_OnEnter_Stage() {
  UI_SetVisible ("mod_power_walking", false);
  if (Game_GetWorldStateAsInteger ("MODS", "power_walking_hud", 0) == 1 && NX_ProductFeatureExists ("MOBILE_UI") != true) {
    local increase = Game_GetWorldState ("MODS", "power_walking_increase");
    increase = increase == null ? 0.0 : increase.tofloat();
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
        increase = 0.0;
      }
    }
    foreach (player_index in [0,1]) {
      local player = Game_GetPlayerActor (player_index);
      if (player != null) {
        local correction = 0.0 - increase / (increase + 100.0) * 100.0;
        Game_SetTemporaryModifier (player, "mod_power_walking", increase_seconds, "move_speed_percentage_increase", increase);
        Game_SetTemporaryModifier (player, "mod_power_walking", increase_seconds, "running_speed_percentage_increase", correction);
      }
    }
    local slider_value = increase / increase_maximum.tofloat();
    if (slider_value > 1.0) slider_value = 1.0;
    UI_SetProperty ("mod_power_walking", "slider.value", slider_value.tofloat());
    UI_SetVisible ("mod_power_walking", true);
  }
}


function Mod_PowerWalking_OnScreenMessage_Stage (key, value) {
  if (key != null) {
    switch (key) {
      case "mod_power_walking_hud_message":
        UI_SetVisible ("mod_power_walking", value == "1" ? true : false);
        break;
      case "mod_power_walking_increase_message":
        UI_SetProperty ("mod_power_walking", "slider.value", value.tofloat());
        break;
    }
  }
}


function Mod_PowerWalking_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_power_walking_increase":
        local slider_value = UI_GetProperty ("mod_power_walking_increase", "slider.value");
        local increase = slider_value == null ? 0 : round(slider_value.tofloat() * increase_maximum.tofloat());
        Game_SetWorldState ("MODS", "power_walking_increase", increase.tostring());
        foreach (player_index in [0,1]) {
          local player = Game_GetPlayerActor (player_index);
          if (player != null) {
            local correction = 0.0 - increase.tofloat() / (increase.tofloat() + 100.0) * 100.0;
            Game_SetTemporaryModifier (player, "mod_power_walking", increase_seconds, "move_speed_percentage_increase", increase.tofloat());
            Game_SetTemporaryModifier (player, "mod_power_walking", increase_seconds, "running_speed_percentage_increase", correction);
          }
        }
        if (NX_ProductFeatureExists ("MOBILE_UI") != true) {
          UI_SendScreenMessage ("Stage", "mod_power_walking_increase_message", slider_value.tostring());
        }
        break;
      case "mod_power_walking_hud":
        local hud = UI_GetProperty ("mod_power_walking_hud", "checkbox.value");
        Game_SetWorldState ("MODS", "power_walking_hud", hud.tostring());
        UI_SendScreenMessage ("Stage", "mod_power_walking_hud_message", hud.tostring());
        break;
      case "mod_power_walking_increase_title":
        Mods_Info_Popup (
            LocalizeText("Power walking"),
            LocalizeText("Walk up to 10x faster. Walking becomes running, so you don't have to use the run button anymore.")
              + (NX_ProductFeatureExists ("MOBILE_UI") != true
                ? "\n\n" + LocalizeText("HUD") + ": " + LocalizeText("Adjust power walking speed increase with a slider below the tools UI on the bottom right of the screen.") : ""),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-power-walking-video")}] );
        break;
    }
  }
}


function Mod_PowerWalking_OnEnter_OptionsUnified (stage_in_stack) {
  local increase = Game_GetWorldState ("MODS", "power_walking_increase");
  if (increase == null) increase = 0;
  local slider_value = increase.tofloat() / increase_maximum.tofloat();
  if (slider_value > 1.0) slider_value = 1.0;
  UI_SetProperty ("mod_power_walking_increase", "slider.value", slider_value);
  UI_SetProperty ("mod_power_walking_hud", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "power_walking_hud", 0));
  UI_SetVisible ("mod_power_walking_hud", NX_ProductFeatureExists ("MOBILE_UI") != true ? true : false);
  UI_SetProperty ("mod_power_walking_increase_title", "textbox.text", LocalizeText("Power walking"));
  UI_SetProperty ("mod_power_walking_hud_title", "textbox.text", LocalizeText("HUD") + ":");
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
