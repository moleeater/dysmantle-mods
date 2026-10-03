// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local multiplier_maximum = 3600.0;
local nonlinearity_power = 3.1;


Include ("scripts/mods/mods-info.nut");


function Mod_WorldTimeMultiplier_OnUpdate_Campfire (tdelta) {
  local multiplier = Game_GetWorldStateAsInteger ("MODS", "world_time_multiplier", 20);
  local is_sleeping = UI_GetProperty ("Time", "visible");
  if (is_sleeping == true) {
    multiplier = 20;
  }
  local engine_kvs = Engine_GetKeyValueStore();
  if (engine_kvs != null) {
    KeyValueStore_SetKeyValueFloat (engine_kvs, "world_time_multiplier", multiplier);
  }
}


function Mod_WorldTimeMultiplier_OnEnter_Stage() {
  local multiplier = Game_GetWorldStateAsInteger ("MODS", "world_time_multiplier", 20);
  local engine_kvs = Engine_GetKeyValueStore();
  if (engine_kvs != null) {
    KeyValueStore_SetKeyValueFloat (engine_kvs, "world_time_multiplier", multiplier);
  }
}


function Mod_WorldTimeMultiplier_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_world_time_multiplier_slider":
        local slider_value = UI_GetProperty ("mod_world_time_multiplier_slider", "slider.value");
        local multiplier = 20;
        if (slider_value != null) {
          multiplier = round(pow(slider_value.tofloat(), nonlinearity_power.tofloat()) * (multiplier_maximum.tofloat() - 1.0)) + 1;
        }
        Game_SetWorldState ("MODS", "world_time_multiplier", multiplier.tostring());
        local multiplier_text = multiplier == 3600 ? "1h" : (multiplier < 60 ? multiplier.tostring() + "s" : round(multiplier / 60.0).tostring() + "m");
        UI_SetProperty ("mod_world_time_multiplier", "editbox.text", " " + multiplier_text);
        local engine_kvs = Engine_GetKeyValueStore();
        if (engine_kvs != null) {
          KeyValueStore_SetKeyValueFloat (engine_kvs, "world_time_multiplier", multiplier);
        }
        break;
      case "mod_world_time_multiplier_title":
        Mods_Info_Popup (
            LocalizeText("World time multiplier"),
            LocalizeText("Adjust how many in-game seconds pass during a real life second. Vanilla value is 20."));
        break;
    }
  }
}


function Mod_WorldTimeMultiplier_OnEnter_OptionsUnified (stage_in_stack) {
  local multiplier = Game_GetWorldStateAsInteger ("MODS", "world_time_multiplier", 20);
  local slider_value = pow((multiplier.tofloat() - 1.0) / (multiplier_maximum.tofloat() - 1.0), 1.0 / nonlinearity_power.tofloat());
  if (slider_value > 1) slider_value = 1.0;
  UI_SetProperty ("mod_world_time_multiplier_slider", "slider.value", slider_value);
  local multiplier_text = multiplier == 3600 ? "1h" : (multiplier < 60 ? multiplier.tostring() + "s" : round(multiplier / 60.0).tostring() + "m");
  UI_SetProperty ("mod_world_time_multiplier", "editbox.text", " " + multiplier_text);
  UI_SetProperty ("mod_world_time_multiplier_title", "textbox.text", LocalizeText("World time multiplier"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
