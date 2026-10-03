// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local nonlinearity_power = 4.0;
local targets = {
    "mod_nonlinear_volume_sound": "VolSound",
    "VolSound"                  : "mod_nonlinear_volume_sound",
    "mod_nonlinear_volume_music": "VolMusic",
    "VolMusic"                  : "mod_nonlinear_volume_music",
  };  


Include ("scripts/mods/mods-info.nut");


function Mod_NonlinearVolume_Set (source) {
  local power = nonlinearity_power;
  switch (source) {
    case "VolSound":
    case "VolMusic":
      power = 1.0 / power;
  }
  local source_value = UI_GetProperty (source, "slider.value");
  if (source_value != null) {
    local target_value = pow(source_value, power);
    switch (source) {
      case "mod_nonlinear_volume_sound":
      case "mod_nonlinear_volume_music":
        target_value += 0.0099999;
        if (target_value > 1.0) target_value = 1.0;
    }
    UI_SetProperty (targets[source], "slider.value", target_value);
  }
}


function Mod_NonlinearVolume_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_nonlinear_volume_sound_title":
      case "mod_nonlinear_volume_music_title":
        Mods_Info_Popup (
            LocalizeText("Non-linear volume"),
            LocalizeText("Easier to fine-tune adjust low volume ranges on the non-linear scaled volume sliders in the Audio Settings."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-nonlinear-volume-video")}] );
        break;
    }
    if (targets.rawin(clicked) == true) {
      Mod_NonlinearVolume_Set (clicked);
    }
  }
}


function Mod_NonlinearVolume_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_nonlinear_volume_sound_title", "textbox.text", "|img src='emojis/package.png' scale=0.7 offset=2| " + LocalizeText("Sound Volume non-linear"));
  UI_SetVisible ("mod_nonlinear_volume_sound", true);
  UI_SetProperty ("mod_nonlinear_volume_music_title", "textbox.text", "|img src='emojis/package.png' scale=0.7 offset=2| " + LocalizeText("Music Volume non-linear"));
  UI_SetVisible ("mod_nonlinear_volume_music", true);
  Mod_NonlinearVolume_Set ("VolSound");
  Mod_NonlinearVolume_Set ("VolMusic");
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
