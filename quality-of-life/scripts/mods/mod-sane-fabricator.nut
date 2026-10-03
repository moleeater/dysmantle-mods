// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local fabricator_puid = 1192407;


function Mod_SaneFabricator_OnLeave_Craft() {
  if (Stage_GetFilename() == "stages/dlc2/index.xml" && Game_IsStagePointOfInterestPUIDCompleted (fabricator_puid) != true) {
    local fabricator = Stage_GetStageObjectByPUID (fabricator_puid);
    if (fabricator != null) {
      local recipestr = StageObject_GetKeyValue (fabricator, "recipes", "");
      local recipes = split (recipestr, ",");
      if (recipes.len() > 0) {
        local recipe_missing = false;
        foreach (recipe in recipes) {
          local words = split (recipe, "_");
          local lastword = words[words.len() - 1];
          if (lastword == "" || regexp("[0-9]+").match(lastword) != true || lastword == "1") {
            if (Game_IsRecipeCrafted (recipe) != true) {
              recipe_missing = true;
              break;
            }
          }
        }
        if (! recipe_missing) {
          Game_SetStagePointOfInterestCompletedByPUID (fabricator_puid);
        }
      }
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
