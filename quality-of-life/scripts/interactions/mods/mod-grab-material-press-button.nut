// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-grab-material.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function IsInteractionAvailable (material, player) {
  local is_available = false;
  if (this.rawin ("Mod_GrabMaterial_PressButtonIsInteractionAvailable_Material") == true) {
    local ret = Mod_GrabMaterial_PressButtonIsInteractionAvailable_Material (material, player);
    if (ret != null) is_available = ret;
  }
  return is_available;
}


function OnInteraction (material, player) {
  if (this.rawin ("Mod_GrabMaterial_PressButton_Material") == true) Mod_GrabMaterial_PressButton_Material (material, player);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
