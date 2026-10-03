// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_EatingHitpoints_OnUpdate_CarriedMaterials (tdelta) {
  local text = "|img src='hud/icon-hit-points.png' scale=0.3 offset=2| " + LocalizeText("Hit Points");
  foreach (player_index in [0,1]) {
    local player = Game_GetPlayerActor (player_index);
    if (player != null) {
      local health = Actor_GetAttributeHitPoints (player);
      local max_health = Actor_GetAttributeMaximumHitPoints (player);
      if (max_health != null) {
        text += "  " + (player_index == 0 && Game_GetPlayerActor (1) == null
                ? ""
                : " |#"
                  + (player_index == 1 ? "ff7f66" : "6699ff")
                  + "|")
            + round(health == null ? 0 : health).tostring() + "/" + round(max_health).tostring();
      }
    }
  }
  UI_SetProperty ("mod_eating_hitpoints", "textbox.text", text);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
