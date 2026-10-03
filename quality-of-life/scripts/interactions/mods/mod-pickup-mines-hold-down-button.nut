// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-pickup-mines.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function IsInteractionAvailable (mine, player) {
  local is_available = false;
  if (this.rawin ("Mod_PickupMines_HoldDownButtonIsInteractionAvailable_ProximityMine") == true) {
    local ret = Mod_PickupMines_HoldDownButtonIsInteractionAvailable_ProximityMine (mine, player);
    if (ret != null) is_available = ret;
  }
  return is_available;
}


function OnInteraction (mine, player) {
  if (this.rawin ("Mod_PickupMines_HoldDownButton_ProximityMine") == true) Mod_PickupMines_HoldDownButton_ProximityMine (mine, player);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
