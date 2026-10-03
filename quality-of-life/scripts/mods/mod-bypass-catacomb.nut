// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_BypassCatacomb_OnGameStart_Exit (exit, same) {
  if (StageObject_GetId (exit) == "entrance_underworld") {
    local kvs = StageObject_GetKeyValueStore (exit);
    if (kvs != null) {
      KeyValueStore_SetKeyValueStage (kvs, "stage", "stages/island/index.xml");
      KeyValueStore_SetKeyValueString (kvs, "travel_to_entrance_id", "dlc_1_entrance");
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
