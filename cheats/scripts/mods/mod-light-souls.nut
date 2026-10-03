// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_LightSouls_OnDeath (player) {
  if (Game_GetWorldStateAsInteger ("MODS", "light_souls_enabled", 0) == 1) {
    StageObject_SetKeyValueBoolean (player, "keep_materials_on_death", true);
  }
}


function Mod_LightSouls_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_light_souls_enabled":
        Game_SetWorldState ("MODS", "light_souls_enabled", UI_GetProperty ("mod_light_souls_enabled", "checkbox.value") == 1 ? "1" : "0");
        break;
      case "mod_light_souls_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Light Souls"),
            LocalizeText("Keep materials in your backpack upon death. Nothing lost when you die."));
        break;
    }
  }
}


function Mod_LightSouls_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_light_souls_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "light_souls_enabled", 0));
  UI_SetProperty ("mod_light_souls_enabled_title", "textbox.text", LocalizeText("Light Souls"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
