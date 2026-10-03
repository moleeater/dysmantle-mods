// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_PocketPetsForever_OnThink_PetBall (petball, pet, tdelta) {
  local level = Game_GetRecipeUpgradeLevel ("THROWABLE_PET_SUMMONER");
  if (level == null) level = 0;
  local ttl = 20.0;
  switch (level) {
    case 1: ttl = 40.0; break;
    case 2: ttl = 60.0; break;
    case 3: ttl = 80.0; break;
    case 4: ttl = -1.0; break;
  }
  StageObject_SetKeyValueFloat (pet, "time_to_live", ttl);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
