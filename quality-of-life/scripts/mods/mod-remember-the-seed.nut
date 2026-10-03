// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_RememberTheSeed_OnUnequipped_SeedBag (player, item) {
  local selected_seed = Game_GetSelectedFarmingSeedForActor (player);
  local player_index = Game_GetPlayerIndexByActor (player);
  Profile_SetValue ("PLAYER_" + player_index + "_STATE", "selected_seed", "value", selected_seed == null ? "" : selected_seed);
}


function Mod_RememberTheSeed_OnEquipped_SeedBag (player, item) {
  if (this.rawin("Game_SetSelectedFarmingSeedForActor") == true) {
    local player_index = Game_GetPlayerIndexByActor (player);
    local selected_seed = Profile_GetValue ("PLAYER_" + player_index + "_STATE", "selected_seed", "value");
    Game_SetSelectedFarmingSeedForActor (player, selected_seed == null ? "TOMATO" : selected_seed);
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
