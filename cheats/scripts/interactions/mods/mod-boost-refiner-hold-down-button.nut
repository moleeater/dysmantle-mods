// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-boost-refiner.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function IsInteractionAvailable (refiner, player) {
  local is_available = false;
  if (this.rawin ("Mod_BoostRefiner_HoldDownButtonIsInteractionAvailable_Refiner") == true) {
    local ret = Mod_BoostRefiner_HoldDownButtonIsInteractionAvailable_Refiner (refiner, player);
    if (ret != null) is_available = ret;
  }
  return is_available;
}


function OnInteraction (refiner, player) {
  if (this.rawin ("Mod_BoostRefiner_HoldDownButton_Refiner") == true) Mod_BoostRefiner_HoldDownButton_Refiner (refiner, player);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
