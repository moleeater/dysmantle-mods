// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_DefeatHorde_HoldDownButtonUseActivate_EvacShelterLoudspeaker (loudspeaker, player, num_waves = 999) {
  if (Game_GetWorldStateAsInteger ("MODS", "defeat_horde_enabled", 0) == 1) {
    local num_waves_done = (num_waves == null ? 999 : num_waves) - 1;
    local kvs = StageObject_GetKeyValueStore (loudspeaker);
    if (kvs == null) {
      num_waves_done++;
    } else {
      local num_bursts = KeyValueStore_GetKeyValue (kvs, "wave_" + (num_waves - 1).tostring() + "_num_bursts");
      StageObject_SetKeyValueInteger (loudspeaker, "num_bursts_done", num_bursts == null ? 999 : num_bursts);
    }
    StageObject_SetKeyValueInteger (loudspeaker, "num_waves_done", num_waves_done);
    Game_LogEvent ("MOD_DEFEAT_HORDE");
  }
}


function Mod_DefeatHorde_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_defeat_horde_enabled":
        Game_SetWorldState ("MODS", "defeat_horde_enabled", UI_GetProperty ("mod_defeat_horde_enabled", "checkbox.value") == 1 ? "1" : "0");
        break;
      case "mod_defeat_horde_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Defeat shelter hordes"),
            LocalizeText("Cheat shelter defense minigames, you auto-win the fight on activation."));
        break;
    }
  }
}


function Mod_DefeatHorde_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_defeat_horde_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "defeat_horde_enabled", 0));
  UI_SetProperty ("mod_defeat_horde_enabled_title", "textbox.text", LocalizeText("Defeat shelter hordes"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
