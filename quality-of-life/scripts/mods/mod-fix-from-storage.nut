// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_FixFromStorage_PressButtonUse_Fixable (fixable, player, required_materials) {
  if (Game_ThrowMaterialsToActorFromStorage (player, fixable, required_materials) == true) {
    required_materials = "";
  }
  return required_materials;
}


function Mod_FixFromStorage_HoldDownButton_ArenaObelisk (obelisk, player, required_materials) {
  local is_done = false;
  if (Game_ThrowMaterialsToActorFromStorage (player, obelisk, required_materials) == true) {
    is_done = true;
  }
  return is_done;
}


function Mod_FixFromStorage_PressButtonUseUse_WishingWell (well, player, required_materials) {
  local is_done = false;
  if (Game_ThrowMaterialsToActorFromStorage (player, well, required_materials) == true) {
    is_done = true;
  }
  return is_done;
}


function Mod_FixFromStorage_HoldDownButton_ManaChamber (chamber, player, cost) {
  local is_done = false;
  if (Game_ThrowMaterialsToActorFromStorage (player, chamber, cost) == true) {
    is_done = true;
  }
  return is_done;
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
