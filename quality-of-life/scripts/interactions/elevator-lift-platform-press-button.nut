// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-ark-elevator.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function IsInteractionAvailable(so_self, so_activator)
{
  return Actor_HasActorFlag(so_self, "STATIC");
}


function OnInteraction(so_self, so_activator)
{
  NX_StopMusic(5);

  StageObject_SetParentButRetainStageTransform(so_activator, so_self);
  local pos = StageObject_GetPosition(so_activator);
  Game_SetStagePointOfInterestCompleted(so_self);

  local so_pet = StageObject_GetKeyValueStageObjectReference(so_activator, "ref_pet");
  if (so_pet != null)
  {
    StageObject_SetParentButRetainStageTransform(so_pet, so_self);
    if (Actor_GetActorStandingOn(so_pet) != so_self)
      StageObject_SetPosition(so_pet, pos[0]+30, pos[1], pos[2]);

  }

  for (local i = 0; i < 4; i++)
  {
    local user = "user_" + i;
    local player_actor = Game_GetPlayerActor(i);
    if (player_actor != null)
    {
      StageObject_SetKeyValueStageObjectReference(so_self, user, player_actor);
      if (player_actor != so_activator)
      {
        StageObject_SetParentButRetainStageTransform(player_actor, so_self);
        if (Actor_GetActorStandingOn(player_actor) != so_self)
          StageObject_SetPosition(player_actor, pos[0]+30, pos[1], pos[2]);

        so_pet = StageObject_GetKeyValueStageObjectReference(player_actor, "ref_pet");
        if (so_pet != null)
        {
          StageObject_SetParentButRetainStageTransform(so_pet, so_self);
          if (Actor_GetActorStandingOn(so_pet) != so_self)
            StageObject_SetPosition(so_pet, pos[0]+30, pos[1], pos[2]);

        }
      }
    }
  }

// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_ArkElevator_PressButton_ElevatorLiftPlatform") == true) {
    local ret = Mod_ArkElevator_PressButton_ElevatorLiftPlatform (so_self, so_activator);
    if (ret != null) return ret;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Actor_PlayAnimation(so_self, StageObject_GetKeyValue(so_self, "leave_animation"));
  Game_SetCinemaMode(true);
  Game_SetScreenFadeOutWithCommand(0.5, "travel_to_stage", so_self, 1.0);
}
