// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_FlowerPower_OnEnter_Stage() {
  if (IAP_IsItemPurchased ("DLC2") == true && Game_IsFeatureAvailable ("GATHERER") == true && Game_IsRecipeCrafted ("SKILL_FLOWER_POWER_1") != true) {
    Game_CraftRecipe ("SKILL_FLOWER_POWER_1", false);
  }
}


function Mod_FlowerPower_OnLeave_Campfire() {
  Mod_FlowerPower_OnEnter_Stage();
}


function Mod_FlowerPower_OnTimeOfDay_ProtagonistReactions (player, hours, minutes) {
  Mod_FlowerPower_OnEnter_Stage();
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
