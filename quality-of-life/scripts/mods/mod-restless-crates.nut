// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local fadeout_seconds = 2;


function Mod_RestlessCrates_OnActorLeavesRadius_Campfire (campfire, player) {
  if (StageObject_HasTag (player, "PLAYER") == true && this.rawin("Game_GetPlayerPersistentKeyValueStore") == true) {
    local player_kvs = Game_GetPlayerPersistentKeyValueStore (Game_GetPlayerIndexByActor (player));
    KeyValueStore_SetKeyValueInteger (player_kvs, "mod_restless_crates_left_worldrealtime", Game_GetWorldTimeSecondsAsRealTimeSeconds());
    local kvp = KeyValueStore_GetKeyValueAsPointer (player_kvs, "mod_restless_crates_left_worldrealtime");
    if (kvp != null) {
      KeyValueStore_SetFlagForKeyValue (kvp, "SAVE_STATE", true);
    }
  }
}


function Mod_RestlessCrates_PressButtonUse_TimedCrate (timed_crate, player) {
  local time_still_open = null;
  local crates_opened = Game_GetMedalProgressAmount ("TIMED_CRATES_OPENED");
  if (crates_opened == null) crates_opened = 0;
  if (crates_opened > 0) {
    if (this.rawin("Game_GetPlayerPersistentKeyValueStore") != true) {
      Engine_Warning("mod ERROR: update your game to at least v1.4.0.35");
    } else {
      local player_kvs = Game_GetPlayerPersistentKeyValueStore (Game_GetPlayerIndexByActor (player));
      local left_worldtime = KeyValueStore_GetKeyValue (player_kvs, "restless_crates_left_worldrealtime", 1);
      if (left_worldtime != 1) {
        local worldtime_diff = Game_GetWorldTimeSecondsAsRealTimeSeconds() - left_worldtime;
        time_still_open = StageObject_GetKeyValue (timed_crate, "time_available", 0) - fadeout_seconds - 1 - worldtime_diff;
      }
    }
  }
  return time_still_open;
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
