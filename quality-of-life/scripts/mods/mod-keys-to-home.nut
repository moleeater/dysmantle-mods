// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_KeysToHome_OnGameStart_ShelterEntryHatch (hatch, same) {
  if (Game_IsRecipeCrafted ("CROWN") && StageObject_GetId (hatch) == "HOME_SHELTER" && StageObject_GetKeyValue (hatch, "cleared", false) != true) {
    StageObject_SetKeyValueBoolean (hatch, "cleared", true);
    Game_SetPlayerState ("SURREAL_SHELTER_ENTRY", "HATCH");
    Game_LogEvent ("MOD_KEYS_TO_HOME");
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
