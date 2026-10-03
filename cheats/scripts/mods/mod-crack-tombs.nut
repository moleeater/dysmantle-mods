// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local dlc2_altar_puid = 1588061;
local dlc2_door_puids = [ 1590075, 1590071, 1588052, 1590078, 1590077, 1588056, 1588007, ];
local altar_actortypes = [
    "actors/interactives/tomb-altar.xml",
    "actors/interactives/pet-stage-end-altar.xml",
    "actors/interactives/pet-stage-end-altar-cat.xml",
  ];


Include ("scripts/mods/mods-info.nut");


function Mod_CrackTombs_OnEnter_Stage() {
  local is_tomb = false;
  if (Game_GetWorldStateAsInteger ("MODS", "crack_tombs_enabled", 0) == 1) {
    local stage = Stage_GetFilename();
    if (stage != null) {
      is_tomb = Game_IsTombStage (stage) == true;
    }
  }
  foreach (player_index in [0,1]) {
    local player = Game_GetPlayerActor (player_index);
    if (player != null) {
      Game_SetTemporaryModifier (player, "mod_crack_tombs_magnet", is_tomb ? 50000000.0 : 0.0, "material_collect_distance_percentage_increase", is_tomb ? 4000.0 : 0.0);
    }
  }
}


function Mod_CrackTombs_OnEnter_PointOfInterestInfo () {
  UI_SetProperty ("mod_crack_tombs", "button.text", "|#c0c0c0||img src='emojis/package.png' scale=1.5 offset=2||#000000|  " + LocalizeText("Cheat"));
  local stage = Stage_GetFilename();
  local active = stage != null && Game_IsTombCompleted (stage) == true ? false : true;
  if (stage == "stages/dlc2/index.xml") {
    local is_looted = true;
    local altar = Stage_GetStageObjectByPUID (dlc2_altar_puid);
    if (altar != null) {
      is_looted = StageObject_GetKeyValue (altar, "looted", false);
    }
    active = is_looted == true ? false : true;
  }
  UI_SetProperty ("mod_crack_tombs", "active", active);
  local has_altar = stage != null && (Game_IsTombStage (stage) || Game_IsPetStage (stage)) && UI_GetProperty ("Type", "textbox.text") == LocalizeText("Entryway") ? true : false;
  if (stage == "stages/dlc2/index.xml" && UI_GetProperty ("Type", "textbox.text") == LocalizeText("Tomb")) {
    has_altar = true;
  }
  UI_SetVisible ("mod_crack_tombs", has_altar && Game_GetWorldStateAsInteger ("MODS", "crack_tombs_enabled", 0) == 1);
}


function Mod_CrackTombs_OnClick_PointOfInterestInfo (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "Back":
        OnBackAction();
        break;
      case "mod_crack_tombs":
        local altar = null;
        local stage = Stage_GetFilename();
        if (stage != "stages/dlc2/index.xml") {
          foreach (actortype in altar_actortypes) {
            altar = Stage_QueryNearestActorWithType (0.0, 0.0, 0.0, 10000.0, actortype);
            if (altar != null) break;
          }
        } else {
          altar = Stage_GetStageObjectByPUID (dlc2_altar_puid);
          if (altar != null) {
            foreach (puid in dlc2_door_puids) {
              local door = Stage_GetStageObjectByPUID (puid);
              if (door != null) {
                Stage_SendStageObjectCommandWord (door, "activate");
              }
            }
          }
        }
        if (altar != null) {
          Actor_InteractWithInteraction (altar, Game_GetPrimaryPlayerActor(), "use");
          Game_LogEvent ("MOD_CRACK_TOMBS");
        }
        UI_PopScreen ("PointOfInterestInfo");
        UI_PopScreen ("PauseMenu");
        break;
    }
  }
}


function Mod_CrackTombs_OnLeave_PointOfInterestInfo () {
  UI_SetVisible ("mod_crack_tombs", false);
  UI_SetProperty ("mod_crack_tombs", "active", false);
}


function Mod_CrackTombs_HoldDownButtonIsInteractionAvailable_Exit (exit, player) {
  local stage = Stage_GetFilename();
  local is_available = Game_GetPrimaryPlayerControllerTypeAsAsString() != "TOUCH"
      && Game_GetWorldStateAsInteger ("MODS", "crack_tombs_enabled", 0) == 1
      && stage != null && Game_IsTombCompleted (stage) != true
      && ((Actor_GetActorType (exit) == "actors/objects/tomb-exit.xml" && Game_IsTombStage (stage)) || Game_IsPetStage (stage))
        ? true
        : false;
  if (is_available) {
    Actor_SetInteractionText (exit, "mod_crack_tombs_hold_down_button", "|img src='emojis/package.png' scale=0.5 offset=2| " + LocalizeText("Cheat"));
  }
  return is_available;
}


function Mod_CrackTombs_HoldDownButton_Exit (exit, player) {
  local altar = null;
  foreach (actortype in altar_actortypes) {
    altar = Stage_QueryNearestActorWithType (0.0, 0.0, 0.0, 10000.0, actortype);
    if (altar != null) break;
  }
  if (altar != null) {
    if (Actor_IsAnimationPlaying (player, "activate_material_transporter") != true) {
      Actor_QueueActionPlayAnimationWithParameters (player, "activate_material_transporter", 1.0, 0.0, true);
    }
    Actor_InteractWithInteraction (altar, player == null ? Game_GetPrimaryPlayerActor() : player, "use");
    local position = StageObject_GetStagePosition (altar);
    if (position != null) {
      Stage_SpawnEffect ("effects/absorb.xml", position[0], position[1], position[2] - 10.0, 0.0);
    }
    Game_LogEvent ("MOD_CRACK_TOMBS");
  }
}


function Mod_CrackTombs_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_crack_tombs_enabled":
        Game_SetWorldState ("MODS", "crack_tombs_enabled", UI_GetProperty ("mod_crack_tombs_enabled", "checkbox.value") == 1 ? "1" : "0");
        break;
      case "mod_crack_tombs_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Crack tomb puzzles"),
            LocalizeText("Cheat the tomb, pet dungeon stage you are in, if you want. Long press the Target Lock button when near the exit.")
                + " " + LocalizeText("Or on mobile UI, it also shows a button on the Entryway POI on the map screen."));
        break;
    }
  }
}


function Mod_CrackTombs_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_crack_tombs_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "crack_tombs_enabled", 0));
  UI_SetProperty ("mod_crack_tombs_enabled_title", "textbox.text", LocalizeText("Crack tomb puzzles"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
