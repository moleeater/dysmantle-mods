// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_CloneDeer_OnGameStart_Animal (deer) {
  local actor_type = Actor_GetActorType (deer);
  if (actor_type != null && actor_type.len() > 15 && actor_type.slice(0, 15) == "actors/animals/") {
    local health = Actor_GetAttributeHitPoints (deer);
    local max_health = Actor_GetAttributeMaximumHitPoints (deer);
    local player = Game_GetPrimaryPlayerActor();
    if (health != null && max_health != null && health > max_health && player != null) {
      Stage_DealDamage (player, deer, health - max_health, "EXPLOSIVE");
    }
    if (Game_GetWorldStateAsInteger ("MODS", "clone_deer_enabled", 0) == 1) {
      if (health == null || health <= 0.0) {
        local position = StageObject_GetStagePosition (deer);
        if (position != null) {
          local valid_position = Game_GetValidPosition (position[0], position[1], position[2], 120.0, 60.0);
          if (valid_position == null) valid_position = position;
          local clone_deer = Stage_CreateActor (actor_type, valid_position[0], valid_position[1], valid_position[2], false);
          StageObject_SetKeyValueBoolean (clone_deer, "mod_clone_deer", true);
        }
      }
    }
  }
}


function Mod_CloneDeer_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_clone_deer_enabled":
        local enabled = UI_GetProperty (clicked, "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "clone_deer_enabled", enabled ? "1" : "0");
        UI_SetVisible ("mod_clone_deer_enabled_notice", enabled);
        local animals = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, "ANIMAL");
        if (animals != null && animals.len() > 0) {
          foreach (animal in animals) {
            if (enabled) {
              local actor_type = Actor_GetActorType (animal);
              if (actor_type != null && actor_type.len() > 15 && actor_type.slice(0, 15) == "actors/animals/") {
                local health = Actor_GetAttributeHitPoints (animal);
                if (health == null || health <= 0.0) {
                  local position = StageObject_GetStagePosition (animal);
                  if (position != null) {
                    local valid_position = Game_GetValidPosition (position[0], position[1], position[2], 120.0, 60.0);
                    if (valid_position == null) valid_position = position;
                    local clone_deer = Stage_CreateActor (actor_type, valid_position[0], valid_position[1], valid_position[2], false);
                    StageObject_SetKeyValueBoolean (clone_deer, "mod_clone_deer", true);
                  }
                }
              }
            } else if (StageObject_GetKeyValue (animal, "mod_clone_deer") != null) {
              Stage_DeleteStageObjectQueued (animal);
            }
          }
        }
        Game_LogEvent ("MOD_CLONE_DEER", enabled ? "enabled" : "disabled");
        break;
      case "mod_clone_deer_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Clone deer"),
            LocalizeText("Clone dead deer to a living one where they spawn, so you can complete both the Animal Friend medal and the Hunter medal any time."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
                "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-clone-deer-video")}] );
        break;
    }
  }
}


function Mod_CloneDeer_OnEnter_OptionsUnified (stage_in_stack) {
  local enabled = Game_GetWorldStateAsInteger ("MODS", "clone_deer_enabled", 0) == 1 ? true : false;
  UI_SetProperty ("mod_clone_deer_enabled", "checkbox.value", enabled ? 1 : 0);
  UI_SetProperty ("mod_clone_deer_enabled_title", "textbox.text", LocalizeText("Clone deer"));
  UI_SetVisible ("mod_clone_deer_enabled_notice", enabled);
  UI_SetProperty ("mod_clone_deer_enabled_notice", "textbox.text", LocalizeText("Notice: causes lag spikes!"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
