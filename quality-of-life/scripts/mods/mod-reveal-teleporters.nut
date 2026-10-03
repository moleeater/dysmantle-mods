// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_RevealTeleporters_OnGameStart_Teleporter (teleporter, same) {
  local id = StageObject_GetId (teleporter);
  local state = Game_GetWorldState ("BURIED_TELEPORTERS", id);
  if ((Game_IsRecipeCrafted ("PET_CORGI") == true || Game_IsRecipeCrafted ("PET_PERSIAN") == true)
  && Stage_GetFilename() != "stages/pet-stages/pet-hub.stage"
  && StageObject_GetKeyValue (teleporter, "unlocked", false) != true
  && id != null && Game_IsBuriedTeleporterFound (id) != true
  && (state == null || state == "")
  && Game_IsBuriedTeleporterDiggable (id) == true) {
    Actor_InteractWithInteraction (teleporter, teleporter, "pet_digged");
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
