// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-ark-elevator.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function OnInteraction(so_self, so_activator)
{
  Game_SetCinemaMode(true);

  local script_start = @"
    Game_SetCinemaMode(true);
    Actor_SetActorFlag($so_activator, ""SOLID"", false);
    ";

  script_start = string_replace(script_start, "$so_activator", so_activator.tostring());

  Actor_QueueActionRunScript(so_activator, script_start);

  Game_SetStagePointOfInterestCompleted(so_self);

  Actor_QueueActionPlayAnimation(so_activator, "tool_unequip", false);

  local pos_from = StageObject_GetPositionWithOffset(so_self, 160, 0, 0);
  local pos_to = StageObject_GetPositionWithOffset(so_self, 60, 0, 0);
  Actor_QueueActionMove(so_activator, pos_from[0], pos_from[1], pos_from[2]);
  Actor_QueueActionMove(so_activator, pos_to[0], pos_to[1], pos_to[2]);

  local script_end = @"
    //Game_SetCinemaMode(false);
    //Actor_SetActorFlag($so_activator, ""SOLID"", true);
    ";

  script_end = string_replace(script_end, "$so_activator", so_activator.tostring());

  Actor_QueueActionRunScript(so_activator, script_end);

// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_ArkElevator_PressButton_ArkEntrance") == true) {
    local ret = Mod_ArkElevator_PressButton_ArkEntrance (so_self, so_activator);
    if (ret != null) return ret;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Game_SetScreenFadeOutWithCommand(0.6, "travel_to_stage", so_self, 0.65);
}
