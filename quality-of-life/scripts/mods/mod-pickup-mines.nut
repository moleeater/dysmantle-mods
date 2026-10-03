// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_PickupMines_HoldDownButtonIsInteractionAvailable_ProximityMine (mine, player) {
  Actor_SetInteractionText (mine, "mod_pickup_mines_hold_down_button", LocalizeText("Pick Up"));
  local actor_type = Actor_GetActorType (mine);
  if (actor_type != null) {
    switch (actor_type) {
      case "actors/tools/proximity-mine.xml":
        local level = Game_GetRecipeUpgradeLevel ("PROXIMITY_MINE");
        if (level == null) level = 0;
        if (level >= 2) return true;
        break;
      case "actors/tools/bear-trap.xml":
        local level = Game_GetRecipeUpgradeLevel ("BEAR_TRAP");
        if (level == null) level = 0;
        if (level >= 2) return true;
        break;
    }
  }
}


function Mod_PickupMines_HoldDownButton_ProximityMine (mine, player) {
  if (Actor_IsAnimationPlaying (player, "pet_animal_low") != true) {
    Actor_QueueActionPlayAnimationWithParameters (player, "pet_animal_low", 2.0, 0.0, true);
  }
  local position = StageObject_GetStagePosition (mine);
  if (position != null) {
    Stage_SpawnEffect ("effects/digging-flying-dirt.xml", position[0], position[1], position[2] - 30.0, 90.0);
    Stage_SpawnEffect ("effects/digging-flying-dirt.xml", position[0], position[1], position[2] - 30.0, 90.0);
    Stage_SpawnEffect ("effects/digging-flying-dirt.xml", position[0], position[1], position[2] - 30.0, 90.0);
    Stage_SpawnEffect ("effects/digging-flying-dirt.xml", position[0], position[1], position[2] - 30.0, 90.0);
  }
  local actor_type = Actor_GetActorType (mine);
  Stage_DeleteStageObjectQueued (mine);
  local item_id = null;
  if (actor_type != null) {
    switch (actor_type) {
      case "actors/tools/proximity-mine.xml":
        item_id = "items/specials/proximity-mine.nut";
        break;
      case "actors/tools/bear-trap.xml":
        item_id = "items/specials/bear-trap.nut";
        break;
    }
  }
  if (item_id != null) {
    Game_IncreaseItemUses (player, item_id, 1);
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
