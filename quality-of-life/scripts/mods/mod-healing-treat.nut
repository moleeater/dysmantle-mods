// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local base_radius = 50.0;
local upgrade_radius = 25.0;
local heal_amount = 20.0;


function Mod_HealingTreat_OnInterval_AnimalTreat (treat, same) {
  local position = StageObject_GetStagePosition (treat);
  if (position != null) {
    local level = Game_GetRecipeUpgradeLevel ("ANIMAL_TREATS");
    if (level == null) level = 0;
    local objects = Stage_QueryStageObjectsInRadius (position[0], position[1], position[2], base_radius.tofloat() + upgrade_radius.tofloat() * level);
    if (objects != null && objects.len() > 0) {
      foreach (object in objects) {
        if (StageObject_GetType (object) == STAGE_OBJECT_TYPE_ACTOR && StageObject_HasTag (object, "TAMED") == true) {
          local health = Actor_GetAttributeHitPoints (object);
          local max_health = Actor_GetAttributeMaximumHitPoints (object);
          if (health != null &&  health > 0.0 && max_health != null && health < max_health) {
            local position = StageObject_GetStagePosition (object);
            if (position != null) {
              Stage_SpawnEffect ("effects/heal.xml", position[0], position[1], position[2] - 25.0, 0.0);
            }
            Stage_HealActor (treat, object, heal_amount);
          }
        }
      }
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
