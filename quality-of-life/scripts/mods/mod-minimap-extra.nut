// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_MinimapExtra_OnDeathStart_Actor (actor, same) {
  if (Game_IsStagePointOfInterestCompleted (actor) != true) {
    Game_SetStagePointOfInterestCompleted (actor);
  }
}


function Mod_MinimapExtra_OnActorEntersRadius_Terror (terror, player) {
  if (Game_GetWorldTimeDay() >= 24) {
    Game_RevealActorOnMap (terror);
    local id = StageObject_GetId (terror);
    if (id == null) {
      local puid = StageObject_GetPersistentUniqueId (terror);
      id = "puid" + puid.tostring();
    }
    Game_RevealPointOfInterestOnMap (id);
  }
}


function Mod_MinimapExtra_OnActorEntersRadius_Searchable (actor, player) {
  local search_reward_recipe = StageObject_GetKeyValue (actor, "search_reward_recipe", "");
  local search_reward_key = StageObject_GetKeyValue (actor, "search_reward_key", "");
  if (search_reward_recipe != "" || search_reward_key != "") {
    local poi_type = search_reward_key != "" ? "KEY" : (search_reward_recipe.len() > 5 && search_reward_recipe.slice(0,5) == "DISH_" ? "RECIPE_DISH" : "RECIPE");
    StageObject_SetKeyValueString (actor, "poi_type", poi_type);
    Game_RevealActorOnMap (actor);
    local id = StageObject_GetId (actor);
    if (id == null) {
      local puid = StageObject_GetPersistentUniqueId (actor);
      id = "puid" + puid.tostring();
    }
    Game_RevealPointOfInterestOnMap (id);
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
