// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_KeepRunning_OnUpdate_Stage (tdelta) {
  if (Game_IsCinemaModeEnabled() != true
  && UI_IsScreenInStack ("PauseMenu") != true
  && Game_GetWorldStateAsInteger ("MODS", "keep_running_enabled", 0) == 1
  && Game_GetPrimaryPlayerControllerTypeAsAsString() != "TOUCH") {
    foreach (player_index in [0,1]) {
      local player = Game_GetPlayerActor (player_index);
      if (player != null) {
        StageObject_SetKeyValueBoolean (player, "is_running", true);
        Stage_SendStageObjectCommandWord (player, "update_attributes");
        if (Game_IsRecipeCrafted ("MOD_MORE_ITEM_SLOTS") != true) {
          local pet = StageObject_GetKeyValueStageObjectReference (player, "ref_pet");
          if (pet != null) {
            StageObject_SetKeyValueBoolean (pet, "is_running", true);
            Stage_SendStageObjectCommandWord (pet, "update_attributes");
          }
        }
      }
    }
    if (Game_IsRecipeCrafted ("MOD_MORE_ITEM_SLOTS") == true) {
      local pets = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, "PET");
      if (pets != null && pets.len() > 0) {
        foreach (pet in pets) {
          StageObject_SetKeyValueBoolean (pet, "is_running", true);
          Stage_SendStageObjectCommandWord (pet, "update_attributes");
        }
      }
    }
  }
}


function Mod_KeepRunning_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_keep_running_enabled":
        local enabled = UI_GetProperty ("mod_keep_running_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "keep_running_enabled", enabled ? "1" : "0");
        UI_SetProperty ("mod_keep_running_enabled_warning", "textbox.text", LocalizeText("To trigger the change, you need to reload your save."));
        UI_SetVisible ("mod_keep_running_enabled_warning", enabled ? false : true);
        if (enabled != true) {
          foreach (player_index in [0,1]) {
            local player = Game_GetPlayerActor (player_index);
            if (player != null) {
              StageObject_SetKeyValueBoolean (player, "is_running", false);
              StageObject_SetKeyValueBoolean (player, "should_keep_running", false);
              Stage_SendStageObjectCommandWord (player, "update_attributes");
            }
          }
          local pets = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, "PET");
          if (pets != null && pets.len() > 0) {
            foreach (pet in pets) {
              StageObject_SetKeyValueBoolean (pet, "is_running", false);
              Stage_SendStageObjectCommandWord (pet, "update_attributes");
            }
          }
        }
        break;
      case "mod_keep_running_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Keep running"),
            LocalizeText("Turn on running every 15 milliseconds, so you don't have to use the run button anymore."));
        break;
    }
  }
}


function Mod_KeepRunning_OnEnter_OptionsUnified (stage_in_stack) {
  local enabled = Game_GetWorldStateAsInteger ("MODS", "keep_running_enabled", 0) == 1 ? true : false;
  UI_SetVisible ("mod_keep_running_enabled_warning", false);
  UI_SetProperty ("mod_keep_running_enabled", "checkbox.value", enabled && Game_GetPrimaryPlayerControllerTypeAsAsString() != "TOUCH" ? 1 : 0);
  UI_SetProperty ("mod_keep_running_enabled_title", "textbox.text", LocalizeText("Keep running"));
  UI_SetProperty ("mod_keep_running_enabled", "active", Game_GetPrimaryPlayerControllerTypeAsAsString() != "TOUCH");
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
