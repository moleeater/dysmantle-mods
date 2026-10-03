// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-ascend-shelter.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function IsInteractionAvailable (loudspeaker, player) {
  local is_available = false;
  if (this.rawin ("Mod_AscendShelter_HoldDownButtonIsInteractionAvailable_Loudspeaker") == true) {
    local ret = Mod_AscendShelter_HoldDownButtonIsInteractionAvailable_Loudspeaker (loudspeaker, player);
    if (ret != null) is_available = ret;
  }
  return is_available;
}


function OnInteraction (loudspeaker, player) {
  if (this.rawin ("Mod_AscendShelter_HoldDownButton_Loudspeaker") == true) Mod_AscendShelter_HoldDownButton_Loudspeaker (loudspeaker, player);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
