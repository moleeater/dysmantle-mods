// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local interval_realseconds = 1.0;
local update_in_realseconds = 0.0;


Include ("scripts/mods/mods-info.nut");


function Mod_InfiniteItems_OnUpdate_Stage (tdelta) {
  update_in_realseconds -= tdelta;
  if (update_in_realseconds < 0.0) {
    update_in_realseconds = interval_realseconds;
    if (Game_IsCinemaModeEnabled() != true && UI_IsScreenInStack ("PauseMenu") != true && Game_GetWorldStateAsInteger ("MODS", "infinite_items_enabled", 0) == 1) {
      foreach (player_index in [0,1]) {
        local player = Game_GetPlayerActor (player_index);
        if (player != null) {
          Game_ReplenishAllItemUses (player, true, true);
        }
      }
    }
  }
}


function Mod_InfiniteItems_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_infinite_items_enabled":
        local enabled = UI_GetProperty ("mod_infinite_items_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "infinite_items_enabled", enabled ? "1" : "0");
        if (enabled) {
          update_in_realseconds = interval_realseconds;
        }
        break;
      case "mod_infinite_items_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Infinite items"),
            LocalizeText("Replenish ammo, throwables and item uses continuously to get unlimited consumables."));
        break;
    }
  }
}


function Mod_InfiniteItems_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_infinite_items_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "infinite_items_enabled", 0));
  UI_SetProperty ("mod_infinite_items_enabled_title", "textbox.text", LocalizeText("Infinite items"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
