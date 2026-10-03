// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_ConsoleDupes_OnEnter_MainMenu() {
  local engine_kvs = Engine_GetKeyValueStore();
  if (engine_kvs != null) {
    KeyValueStore_SetKeyValueBoolean (engine_kvs, "console_hide_duplicates", false);
  }
}


function Mod_ConsoleDupes_OnEnter_Stage() {
  local engine_kvs = Engine_GetKeyValueStore();
  if (engine_kvs != null) {
    KeyValueStore_SetKeyValueBoolean (engine_kvs, "console_hide_duplicates", false);
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
