// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local sunrise = 8;
local sunset = 19;


Include ("scripts/mods/mods-info.nut");


function Mod_Moonlight (hours, minutes) {
  local moonlight = Stage_GetStageObjectById ("mod_moonlight", STAGE_OBJECT_TYPE_LIGHT);
  local stage = Stage_GetFilename();
  local is_stage_with_sunlight = false;
  if (stage != null && stage.len() >= 4 && stage.slice(stage.len() - 4) == ".xml"
  && DM_GetArrayNodeValue (stage, "INFO", "key_values", "key.BOOLEAN.simulate_time_of_day") == "true") {
    is_stage_with_sunlight = true;
  }
  if (stage != null && is_stage_with_sunlight == true && (hours < sunrise || hours >= sunset)) {
    if (moonlight == null) {
      moonlight = Stage_CreateLight (LIGHT_TYPE_DIRECTIONAL, 1, 1, -200);
      StageObject_SetId (moonlight, "mod_moonlight");
    }
    local brightness = Game_GetWorldState ("MODS", "moonlight_brightness");
    if (brightness == null) brightness = 0.0;
    brightness = brightness.tofloat();
    switch (hours) {
      case sunset:
        brightness = brightness.tofloat() * minutes.tofloat() / 60.0;
        break;
      case sunrise - 1:
        brightness = brightness.tofloat() * (60.0 - minutes.tofloat()) / 60.0;
        break;
    }
    if (Light_GetIntensity (moonlight) != brightness) {
      Light_SetIntensity (moonlight, brightness);
    }
  }
  if (moonlight != null && (stage == null || is_stage_with_sunlight == false || (hours >= sunrise && hours < sunset))) {
    Stage_DeleteStageObjectQueued (moonlight);
  }
}


function Mod_Moonlight_OnLeave_LinkTower() {
  local daytime = Game_GetWorldTimeRelativeDayBetween0And1AfterMidnight();
  local hours = floor(daytime * 24.0);
  local minutes = round((daytime * 24.0 * 60.0) % 60);
  Mod_Moonlight (hours, minutes);
}


function Mod_Moonlight_OnEnter_Stage() {
  local daytime = Game_GetWorldTimeRelativeDayBetween0And1AfterMidnight();
  local hours = floor(daytime * 24.0);
  local minutes = round((daytime * 24.0 * 60.0) % 60);
  Mod_Moonlight (hours, minutes);
}


function Mod_Moonlight_OnTimeOfDay_ProtagonistReactions (player, hours, minutes) {
  if (Game_GetPlayerIndexByActor (player) == 0) {
    Mod_Moonlight (hours, minutes);
  }
}


function Mod_Moonlight_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_moonlight_brightness":
        local brightness = UI_GetProperty ("mod_moonlight_brightness", "slider.value");
        brightness = brightness.tofloat();
        Game_SetWorldState ("MODS", "moonlight_brightness", brightness.tostring());
        local moonlight = Stage_GetStageObjectById ("mod_moonlight", STAGE_OBJECT_TYPE_LIGHT);
        if (moonlight != null) {
          if (Light_GetIntensity (moonlight) != brightness) {
            Light_SetIntensity (moonlight, brightness);
          }
        }
        break;
      case "mod_moonlight_brightness_title":
        Mods_Info_Popup (
            LocalizeText("Moonlight brightness"),
            LocalizeText("Light up the nights with a full moon, if you find the Flashlight too dark. Now with adjustable brightness."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-moonlight-video")}] );
        break;
    }
  }
}


function Mod_Moonlight_OnEnter_OptionsUnified (stage_in_stack) {
  local brightness = Game_GetWorldState ("MODS", "moonlight_brightness");
  if (brightness == null) brightness = 0.0;
  UI_SetProperty ("mod_moonlight_brightness", "slider.value", brightness.tofloat());
  UI_SetProperty ("mod_moonlight_brightness_title", "textbox.text", LocalizeText("Moonlight brightness"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
