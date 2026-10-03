// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_PetPointer_OnGameStart_Teleporter (teleporter, same) {
  if (Game_IsRecipeCrafted ("LINK_TOWER_SONAR_TOOLKIT") == true) {
    local recipe = StageObject_GetKeyValue (teleporter, "recipe", null);
    if (recipe != null && Stage_GetFilename() == "stages/pet-stages/pet-hub.stage") {
      Actor_SetInteractionText (teleporter, "use", Game_GetConvertedString ("[RECIPE_ICON=" + recipe + "]  [RECIPE_NAME=" + recipe + "]"));
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
