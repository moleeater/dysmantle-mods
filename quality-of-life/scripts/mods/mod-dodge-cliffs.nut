// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_DodgeCliffs_OnCollidedInto_Cliff (cliff, player) {
  if (Game_IsCinemaModeEnabled() != true && StageObject_HasTag (player, "PLAYER") == true && Game_GetCurrentAction (player) == "DodgeAction") {
    local cliff_position = StageObject_GetStagePosition (cliff);
    local player_position = StageObject_GetStagePosition (player);
    if (cliff_position == null || player_position == null || cliff_position[2] > player_position[2] + 10.0) {
      Game_StopAnimationByAction (player, "DodgeAction");
      Actor_SetLinearVelocity (player, 0.0, 0.0, 0.0);
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
