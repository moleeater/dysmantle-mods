function OnInteraction(so_self, so_activator)
{
  local puid = StageObject_GetPersistentUniqueId(so_self);
  local state = Game_GetWorldState("TIMED_CHESTS", "puid" + puid.tostring());
  if (state == "open")
  {
    Actor_PlayAnimationWithDelayPlaybackSpeedAndPosition(so_self, "open", 0, 2, 1);
    Actor_SetInteractionEnabled(so_self, "open", false);
    Game_SetStagePointOfInterestCompleted(so_self);
  }
}
