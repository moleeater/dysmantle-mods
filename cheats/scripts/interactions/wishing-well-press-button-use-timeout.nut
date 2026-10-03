// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-free-wells.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-well-prepared.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function IsInteractionAvailable(so_self, so_activator)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_FreeWells_PressButtonUseIsInteractionAvailable_WishingWell") == true) Mod_FreeWells_PressButtonUseIsInteractionAvailable_WishingWell (so_self, so_activator);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_WellPrepared_PressButtonUseTimeoutIsInteractionAvailable_WishingWell") == true) {
    local ret = Mod_WellPrepared_PressButtonUseTimeoutIsInteractionAvailable_WishingWell (so_self, so_activator);
    if (ret != null) return ret;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  local time_now = Game_GetWorldTimeSecondsAsRealTimeSeconds();
  local time_used = StageObject_GetKeyValue(so_self, "time_used");
  local TIME_TO_WAIT = StageObject_GetKeyValue(so_self, "time_to_wait");
  if (time_used != null)
  {
    local time_waited = time_now - time_used;
    if (time_waited < TIME_TO_WAIT)
      return true;

  }
  return false;
}


function OnInteraction(so_self, so_activator)
{
  if (Game_IsShowingActorNotification(so_self))
    return;

  local time_now = Game_GetWorldTimeSecondsAsRealTimeSeconds();
  local time_used = StageObject_GetKeyValue(so_self, "time_used");
  local TIME_TO_WAIT = StageObject_GetKeyValue(so_self, "time_to_wait");

  if (time_used != null)
  {
    local time_left = TIME_TO_WAIT - (time_now - time_used);
    local minutes = floor(time_left / 60).tointeger();
    local seconds = time_left - minutes * 60;
    local time_string = format("%.2d:%.2d", minutes, seconds);
    Game_AddActorNotification(so_self, "[EMOJI=hourglass not done] " + time_string);
  }
}
