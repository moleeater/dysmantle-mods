// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local cooldown_gameseconds = 34000;
local cooldown_realseconds = 1700;
local last_gameseconds = null;
local last_realseconds = null;


function Mod_Yawning_OnTimeOfDay_ProtagonistReactions (player, hours, minutes) {
  if (this.rawin("Game_GetLastTimeSlept") == true
  && Game_IsCinemaModeEnabled() != true
  && (Game_GetWorldStateAsInteger ("MODS", "sleep_anytime_enabled", 0) != 1 || NX_FileExists ("scripts/mods/mod-sleep-anytime.nut") != true)
  && Game_GetPlayerIndexByActor (player) == 0) {
    local player_kvs = Game_GetPlayerPersistentKeyValueStore (0);
    if (last_gameseconds == null) {
      last_gameseconds = KeyValueStore_GetKeyValue (player_kvs, "mod_yawning_last_gameseconds", 147600);
      last_realseconds = KeyValueStore_GetKeyValue (player_kvs, "mod_yawning_last_realseconds", 1);
    }
    local time_slept_last = Game_GetLastTimeSlept();
    if (time_slept_last == null || time_slept_last == 0) time_slept_last == 0 - 24 * 60 * 60;
    local now_gameseconds = Game_GetWorldTimeInSeconds();
    local now_realseconds = NX_GetTimeSecondsElapsedSinceEpoch();
    if (time_slept_last + 18 * 60 * 60 <= now_gameseconds
    && last_gameseconds + cooldown_gameseconds <= now_gameseconds
    && last_realseconds + cooldown_realseconds <= now_realseconds) {
      last_gameseconds = now_gameseconds;
      last_realseconds = now_realseconds;
      KeyValueStore_SetKeyValueInteger (player_kvs, "mod_yawning_last_gameseconds", last_gameseconds);
      local kvp = KeyValueStore_GetKeyValueAsPointer (player_kvs, "mod_yawning_last_gameseconds");
      if (kvp != null) {
        KeyValueStore_SetFlagForKeyValue (kvp, "SAVE_STATE", true);
      }
      KeyValueStore_SetKeyValueInteger (player_kvs, "mod_yawning_last_realseconds", last_realseconds);
      kvp = KeyValueStore_GetKeyValueAsPointer (player_kvs, "mod_yawning_last_realseconds");
      if (kvp != null) {
        KeyValueStore_SetFlagForKeyValue (kvp, "SAVE_STATE", true);
      }
      foreach (player_index in [0,1]) {
        local player = Game_GetPlayerActor (player_index);
        if (player != null) {
          Game_AddFloaterNotification (player, "|img src='emojis/yawning face.png'|", 3, player_index == 0 ? 0 : 2.0 + m_randf() * 2.0);
        }
      }
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
