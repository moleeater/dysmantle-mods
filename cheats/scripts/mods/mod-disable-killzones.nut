// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_DisableKillzones_OnGameStart_Killzone (killzone, same) {
  local enabled = Game_GetWorldStateAsInteger ("MODS", "disable_killzones_enabled", 0) == 1;
  local set_flag = enabled ? false : true;
  if (Actor_HasActorFlag (killzone, "SOLID") != set_flag) {
    Actor_SetActorFlag (killzone, "SOLID", set_flag);
  }
}


function Mod_DisableKillzones_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_disable_killzones_enabled":
        local enabled = UI_GetProperty ("mod_disable_killzones_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "disable_killzones_enabled", enabled ? "1" : "0");
        local killzones = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, "MOD_DISABLE_KILLZONES");
        if (killzones != null && killzones.len() > 0) {
          local set_flag = enabled ? false : true;
          foreach (killzone in killzones) {
            if (Actor_HasActorFlag (killzone, "SOLID") != set_flag) {
              Actor_SetActorFlag (killzone, "SOLID", set_flag);
            }
          }
        }
        Game_LogEvent ("MOD_DISABLE_KILLZONES", enabled ? "enabled" : "disabled");
        break;
      case "mod_disable_killzones_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Disable killzones"),
            LocalizeText("Disable death zones where the player is forcibly killed, no matter what their health is."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-disable-killzones-video")}] );
        break;
    }
  }
}


function Mod_DisableKillzones_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_disable_killzones_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "disable_killzones_enabled", 0));
  UI_SetProperty ("mod_disable_killzones_enabled_title", "textbox.text", LocalizeText("Disable killzones"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
