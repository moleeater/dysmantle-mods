// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local velocity_threshold = 200.0;
local velocity_damping = 10.0;


Include ("scripts/mods/mods-info.nut");


function Mod_NoFallDamage_OnUpdate_Stage (tdelta) {
  if (Game_IsCinemaModeEnabled() != true && UI_IsScreenInStack ("PauseMenu") != true && Game_GetWorldStateAsInteger ("MODS", "no_fall_damage_enabled", 0) == 1) {
    foreach (player_index in [0,1]) {
      local player = Game_GetPlayerActor (player_index);
      if (player != null) {
        local velocity = Actor_GetLinearVelocity (player);
        if (velocity[2] > velocity_threshold) {
          Actor_SetLinearVelocity (player, velocity[0] / velocity_damping, velocity[1] / velocity_damping, 0.0);
        }
      }
    }
  }
}


function Mod_NoFallDamage_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_no_fall_damage_enabled":
        local enabled = UI_GetProperty ("mod_no_fall_damage_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "no_fall_damage_enabled", enabled ? "1" : "0");
        Game_LogEvent ("MOD_NO_FALL_DAMAGE", enabled ? "enabled" : "disabled");
        break;
      case "mod_no_fall_damage_enabled_title":
        Mods_Info_Popup (
            LocalizeText("No fall damage"),
            LocalizeText("No fall damage, you can fall off cliffs 960+ units high without dying. You will still die if you fall into a kill-zone."));
        break;
    }
  }
}


function Mod_NoFallDamage_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_no_fall_damage_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "no_fall_damage_enabled", 0));
  UI_SetProperty ("mod_no_fall_damage_enabled_title", "textbox.text", LocalizeText("No fall damage"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
