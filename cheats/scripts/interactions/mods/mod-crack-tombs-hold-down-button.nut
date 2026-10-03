// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-crack-tombs.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function IsInteractionAvailable (exit, player) {
  local is_available = false;
  if (this.rawin ("Mod_CrackTombs_HoldDownButtonIsInteractionAvailable_Exit") == true) {
    local ret = Mod_CrackTombs_HoldDownButtonIsInteractionAvailable_Exit (exit, player);
    if (ret != null) is_available = ret;
  }
  return is_available;
}


function OnInteraction (exit, player) {
  if (this.rawin ("Mod_CrackTombs_HoldDownButton_Exit") == true) Mod_CrackTombs_HoldDownButton_Exit (exit, player);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
