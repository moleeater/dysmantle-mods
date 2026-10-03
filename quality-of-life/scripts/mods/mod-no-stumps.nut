// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_NoStumps_OnGameStart_Tree (tree, same) {
  local enabled = Game_GetWorldStateAsInteger ("MODS", "no_stumps_enabled", 0) == 1 ? true : false;
  if (Actor_HasActorFlag (tree, "DELETE_ACTOR_AFTER_DEATH") != enabled) {
    Actor_SetActorFlag (tree, "DELETE_ACTOR_AFTER_DEATH", enabled);
  }
}


function Mod_NoStumps_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_no_stumps_enabled":
        local enabled = UI_GetProperty ("mod_no_stumps_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "no_stumps_enabled", enabled ? "1" : "0");
        local trees = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, "TREE");
        if (trees != null && trees.len() > 0) {
          foreach (tree in trees) {
            if (Actor_HasInteraction (tree, "mod_no_stumps_on_game_start") == true && Actor_HasActorFlag (tree, "DELETE_ACTOR_AFTER_DEATH") != enabled) {
              Actor_SetActorFlag (tree, "DELETE_ACTOR_AFTER_DEATH", enabled);
              if (enabled) {
                local health = Actor_GetAttributeHitPoints (tree);
                if (health == null || health <= 0.0) {
                  Stage_DeleteStageObjectQueued (tree);
                }
              }
            }
          }
        }
        break;
      case "mod_no_stumps_enabled_title":
        Mods_Info_Popup (
            LocalizeText("No stumps"),
            LocalizeText("Remove big tree stumps when you cut the tree, so you won't get stuck on them."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-no-stumps-video")}] );
        break;
    }
  }
}


function Mod_NoStumps_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_no_stumps_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "no_stumps_enabled", 0));
  UI_SetProperty ("mod_no_stumps_enabled_title", "textbox.text", LocalizeText("No stumps"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
