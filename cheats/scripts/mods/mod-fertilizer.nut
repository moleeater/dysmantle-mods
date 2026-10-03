// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local multiplier_maximum = 100.0;
local nonlinearity_power = 3.0;


Include ("scripts/mods/mods-info.nut");


function Mod_Fertilizer_OnDeathStart_Harvestable (farmable, same) {
  local multiplier = Game_GetWorldStateAsInteger ("MODS", "fertilizer_multiplier", 1);
  if (multiplier > 1) {
    local drop = StageObject_GetKeyValue (farmable, "drops_material_id");
    if (drop != null) {
      local material_id = drop.tostring();
      local captured = regexp("([0-9]+)x([A-Z_]+)").capture(drop.tostring());
      if (captured != null && captured[1] != null && captured[1].end != 0
      && captured[2] != null && captured[2].begin != 0 && captured[2].end != 0) {
        material_id = drop.tostring().slice(captured[2].begin, captured[2].end);
        drop = (drop.tostring().slice(captured[1].begin, captured[1].end).tointeger() * multiplier).tostring() + "x" + material_id;
      } else {
        drop = multiplier.tostring() + "x" + drop.tostring();
      }
      StageObject_SetKeyValueString (farmable, "drops_material_id", drop);
    }
  }
}


function Mod_Fertilizer_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_fertilizer_multiplier_slider":
        local slider_value = UI_GetProperty ("mod_fertilizer_multiplier_slider", "slider.value");
        local multiplier = 1;
        if (slider_value != null) {
          multiplier = round(pow(slider_value.tofloat(), nonlinearity_power.tofloat()) * (multiplier_maximum.tofloat() - 1.0)) + 1;
        }
        Game_SetWorldState ("MODS", "fertilizer_multiplier", multiplier.tostring());
        UI_SetProperty ("mod_fertilizer_multiplier", "editbox.text", " " + multiplier.tostring() + "x");
        break;
      case "mod_fertilizer_multiplier_title":
        Mods_Info_Popup (
            LocalizeText("Fertilizer multiplier"),
            LocalizeText("Multiply farm crop yield up to 100x."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-fertilizer-video")}] );
        break;
    }
  }
}


function Mod_Fertilizer_OnEnter_OptionsUnified (stage_in_stack) {
  local multiplier = Game_GetWorldStateAsInteger ("MODS", "fertilizer_multiplier", 1);
  local slider_value = pow((multiplier.tofloat() - 1.0) / (multiplier_maximum.tofloat() - 1.0), 1.0 / nonlinearity_power.tofloat());
  if (slider_value > 1) slider_value = 1.0;
  UI_SetProperty ("mod_fertilizer_multiplier_slider", "slider.value", slider_value);
  UI_SetProperty ("mod_fertilizer_multiplier", "editbox.text", " " + multiplier.tostring() + "x");
  UI_SetProperty ("mod_fertilizer_multiplier_title", "textbox.text", LocalizeText("Fertilizer multiplier"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
