// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local distance = 5.0;


Include ("scripts/mods/mods-info.nut");


function Mod_AutoClimb_OnCollidedInto_Cliff (cliff, player) {
  if (Game_IsCinemaModeEnabled() != true && Game_GetWorldStateAsInteger ("MODS", "auto_climb_enabled", 0) == 1 && StageObject_HasTag (player, "PLAYER") == true) {
    local position = StageObject_GetStagePosition (player);
    local angle = StageObject_GetAngle (player);
    if (position != null && angle != null) {
      Actor_SetLinearVelocity (player, 0.0, 0.0, 0.0);
      local radian = m_anglemod (angle * PI / 180.0);
      StageObject_SetPositionByStackingOnTop (player, position[0] + cos(radian) * distance, position[1] + sin(radian) * distance);
    }
  }
}


function Mod_AutoClimb_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_auto_climb_enabled":
        local enabled = UI_GetProperty ("mod_auto_climb_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "auto_climb_enabled", enabled ? "1" : "0");
        Game_LogEvent ("MOD_AUTO_CLIMB", enabled ? "enabled" : "disabled");
        break;
      case "mod_auto_climb_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Automatic climbing"),
            LocalizeText("Climb cliffs automatically just by walking into them. Often puts you into walls and the ground, you will need to use Rift forwards sometimes."));
        break;
    }
  }
}


function Mod_AutoClimb_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_auto_climb_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "auto_climb_enabled", 0));
  UI_SetProperty ("mod_auto_climb_enabled_title", "textbox.text", LocalizeText("Automatic climbing"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
