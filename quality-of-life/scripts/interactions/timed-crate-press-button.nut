local mods_include_path = "";
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
mods_include_path = "scripts/mods/mod-bullet-time.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-restless-crates.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
// MODS by DarthNemesis vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
mods_include_path = "scripts/mods/mod-timed-crate-cheat.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by DarthNemesis ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function IsInteractionAvailable(so_self, so_activator)
{
  return !Game_IsShowingActorNotification(so_self);
}


function OnInteraction(so_self, so_activator)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_BulletTime_PressButtonUse_TimedCrate") == true) {
    if (Mod_BulletTime_PressButtonUse_TimedCrate (so_self, so_activator) == true) return false;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  local home_portal_state = Game_GetPlayerState("used_home_portal");
// MODS by DarthNemesis vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_TimedCrateCheat_PressButtonUse_TimedCrate_HomePortalState") == true) {
    home_portal_state = Mod_TimedCrateCheat_PressButtonUse_TimedCrate_HomePortalState (so_self, so_activator);
  }
// MODS by DarthNemesis ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  if (home_portal_state == "1")
  {
    Actor_PlayAnimation(so_self, "locked");
    //Game_AddActorNotificationWithDelay(so_activator, "[EMOJI=thinking face]", 2);
    Game_AddActorNotificationWithDelay(so_self, "|img src='items/specials/home-portal-device.png' scale=0.65| |img src='emojis/cross mark.png' scale=0.95|", 0.5);
    //Actor_SetInteractionEnabled(so_self, "open", false);
    return;
  }

  local puid_as_string = "puid" + StageObject_GetPersistentUniqueId(so_self).tostring();
  local state = Game_GetWorldState("TIMED_CHESTS", puid_as_string);
  if (state != "open") // This interaction shouldn't be enabled if open in any case
  {
    local time_still_open = StageObject_GetKeyValue(so_self, "time_available") - Game_GetSecondsSinceRested();
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    if (this.rawin ("Mod_RestlessCrates_PressButtonUse_TimedCrate") == true) {
      local ret = Mod_RestlessCrates_PressButtonUse_TimedCrate (so_self, so_activator);
      if (ret != null) time_still_open = ret;
    }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
// MODS by DarthNemesis vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    if (this.rawin ("Mod_TimedCrateCheat_PressButtonUse_TimedCrate_TimeStillOpen") == true) {
      time_still_open = Mod_TimedCrateCheat_PressButtonUse_TimedCrate_TimeStillOpen (so_self, so_activator);
    }
// MODS by DarthNemesis ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    if (time_still_open >= -1)
    {
      Game_SetWorldState("TIMED_CHESTS", puid_as_string, "open");
      Actor_PlayAnimation(so_self, "open");
      Actor_SetInteractionEnabled(so_self, "open", false);

      local reward_materials = StageObject_GetKeyValue(so_self, "reward_materials");
      Game_LogEvent("TIMED_CRATE", "OPEN");
      Game_SpawnMaterials(so_self, so_activator, reward_materials);
      if (time_still_open < 1)
        time_still_open = 1;
      local text = LOC_TEXT("Granting access. Time left: [AMOUNT] seconds.");
      text = string_replace(text, "[AMOUNT]", format("[GREEN]%d[WHITE]", time_still_open));
      Game_AddActorNotification(so_self, text);
      Game_SetStagePointOfInterestCompleted(so_self);
      Game_ChangeMedalProgressAmount("TIMED_CRATES_OPENED", 1);
    }
    else
    {
      Actor_PlayAnimation(so_self, "locked");

      local seconds_closed = -time_still_open;
      Game_LogEvent("TIMED_CRATE", "TOO_LATE", "" + seconds_closed);
      local text = LOC_TEXT("Locked [AMOUNT] seconds ago.");
      text = string_replace(text, "[AMOUNT]", format("[RED]%d[WHITE]", seconds_closed));
      Game_AddActorNotification(so_self, text);

      local tried = Game_GetWorldState("TIMED_CHESTS", "tried_open") != null;
      if (!tried)
      {
        //TODO: could show only when out of danger...
        Game_AddActorNotificationWithDelay(so_activator, LOC_TEXT("Locked since what? When does it reset? [EMOJI=thinking face]"), 2);
        Game_SetWorldState("TIMED_CHESTS", "tried_open", "1");
      }
      else
      {
        if (seconds_closed < 3)
        {
          Game_AddActorNotificationWithDelay(so_activator, "[EMOJI=loudly crying face]", 2);
        }
        else
        {
          Game_AddActorNotificationWithDelay(so_activator, "[EMOJI=thinking face]", 2);
        }
      }
    }
  }
}
