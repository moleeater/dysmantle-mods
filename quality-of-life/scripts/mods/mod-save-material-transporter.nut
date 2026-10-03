// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_SaveMaterialTransporter_OnTriggerDown_MaterialTransporter (player) {
  if (this.rawin("Game_GetMaterialsCarried") == true) {
    local carried = Game_GetMaterialsCarried();
    if (carried != null && carried.len() > 0) {
      foreach (slot in carried) {
        if (slot.id != "FUEL_CELL" && slot.amount > 0) {
          return false;
        }
      }
    }
    if (Actor_IsAnimationPlaying (player, "not_here") != true) {
      Actor_QueueActionPlayAnimationWithParameters (player, "not_here", 1.0, 0.0, true);
    }
    return true;
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
