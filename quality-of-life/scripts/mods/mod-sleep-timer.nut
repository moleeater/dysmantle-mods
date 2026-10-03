// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_SleepTimer_OnUpdate_Campfire (tdelta) {
  if (this.rawin("Game_GetLastTimeSlept") == true) {
    local time_slept_last = Game_GetLastTimeSlept();
    if (time_slept_last == null) time_slept_last = 0;
    local minutes = null;
    if (time_slept_last == 0
    || (Game_GetWorldStateAsInteger ("MODS", "sleep_anytime_enabled", 0) == 1 && NX_FileExists ("scripts/mods/mod-sleep-anytime.nut") == true)) {
      minutes = 0;
    } else {
      local world_time_multiplier = 20.0;
      local engine_kvs = Engine_GetKeyValueStore();
      if (engine_kvs != null) {
        world_time_multiplier = KeyValueStore_GetKeyValue (engine_kvs, "world_time_multiplier", 20.0);
      }
      minutes = (time_slept_last.tofloat() + 18.0 * 60.0 * 60.0 - Game_GetWorldTimeInSeconds()).tofloat() / world_time_multiplier.tofloat() / 60.0;
      local player = Game_GetPrimaryPlayerActor();
      if (player != null) {
        local modifiers_kvs = Game_GetAllPlayerModifiersAsKeyValueStore (player);
        local time_modifier_percentage_increase = 0.0;
        if (modifiers_kvs != null) {
          time_modifier_percentage_increase = KeyValueStore_GetKeyValue (modifiers_kvs, "time_modifier_percentage_increase");
          if (time_modifier_percentage_increase == null) time_modifier_percentage_increase = 0.0;
          minutes = minutes.tofloat() * 100.0 / (100.0 + time_modifier_percentage_increase);
        }
      }
      minutes = ceil(minutes);
    }
    local text = LocalizeText("|img src='dysmantle/gear/sleeping-bag.png'| Sleep")
        + "   |img src='emojis/hourglass not done.png' scale=1.5 offset=1|" + (minutes > 0 ? minutes.tostring() + "min" : "|img src='emojis/thumbs up.png' scale=1.5|");
    UI_SetProperty ("Sleep", "localize", false);
    UI_SetProperty ("Sleep", "button.text", text);
    UI_SetProperty ("Sleep", "localize", true);
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
