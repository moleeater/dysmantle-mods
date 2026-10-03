// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local poi_stages = {
    "stages/island"    : {},
    "stages/undercrown": {},
    "stages/dlc1"      : { "dlc": "DLC1" },
    "stages/dlc2"      : { "dlc": "DLC2" },
    "stages/dlc3"      : { "dlc": "DLC3" },
  };
local rift_puids = {
    "Sunburn Desert": [ 5492052 ], // O30
    "Vulcan": [
        5014116, // N6
        4826114, // M7
      ],
    "pyramid": [ 5492052 ], // O30
  };
local blacklist_poi_types = [
    "ENEMY_NORMAL",
    "ENEMY_STATIONARY",
    "ENEMY_BOSS",
    "FISHING_SPOT",
    "FIXABLE",
    "FAKE_FIXABLE",
  ];
local start_campfire_puid = 5316108; // N34 campfire
local tabularasa_campfire_puid = 4384029; // L41 campfire
local crown_launchpad_puid = 4902014;
local launchpad_key_puid = 4504020;
local steel_block_puids = [ 402226, 402238, 402239 ];
local evacuation_wall_puid = 5154038; // N41 wall
local pyramid_tomb_puids = [ 1832, 1833, 1834 ];
local ark_door_puid = 2196123;
local harbor_box_puid = 4832040; // M9 door box
local blocking_puids = [
    1294139, // D36 table
    5198163, // N4 vendingmachine
    4330166, // L27 fence
    4330378, // L27 barrier
  ];
local central_gascloud_puids = [
    3146032, // I19 gascloud
    3144018, // I19 gascloud
    3144019, // I19 gascloud
    3536052, // J21 gascloud
    3538033, // J21 gascloud
    3538040, // J21 gascloud
    3538038, // J21 gascloud
  ];


Include ("scripts/mods/mods-info.nut");


function Mod_StartingStage_PressButtonIsInteractionAvailable_DogHouse (doghouse, player) {
  local start = Game_GetWorldState ("MODS", "mod_starting_stage_initializing");
  if (start == null || start == "") {
    start = Game_GetWorldState ("MODS", "mod_starting_stage_active");
  }
  if (start != null) {
    return false;
  }
}


function Mod_StartingStage_PressButtonIsInteractionAvailable_TombEntranceOnGround (entrance, player) {
  local start = Game_GetWorldState ("MODS", "mod_starting_stage_initializing");
  if (start == null || start == "") {
    start = Game_GetWorldState ("MODS", "mod_starting_stage_active");
  }
  if (start != null) {
    switch (start) {
      case "Sunburn Desert":
      case "Frore":
      case "Polaris":
      case "Vulcan":
      case "fortress":
      case "pyramid":
      case "ark":
      case "random":
        return false;
    }
  }
}


function Mod_StartingStage_OnClick_PopupMessage (return_to_home_shelter_campfire = null) {
  if (return_to_home_shelter_campfire == false) {
    return null;
  }
  local active = Game_GetWorldState ("MODS", "mod_starting_stage_active");
  if (active == null) {
    active = Game_GetWorldState ("MODS", "mod_starting_stage_initializing");
  }
  local is_limited = false;
  if (active != null) {
    switch (active) {
      case "Hedgefield":
      case "Arcturus":
      case "Everglade":
      case "Borealis":
      case "Sunburn Desert":
      case "Frore":
      case "Polaris":
      case "Vulcan":
      case "fortress":
      case "pyramid":
      case "ark":
      case "random":
        is_limited = Stage_GetFilename() == "stages/island/index.xml" && Game_IsStagePointOfInterestPUIDCompleted (start_campfire_puid) == true ? false : true;
        break;
      case "DLC1":
        is_limited = Game_IsQuestPhaseCompleted ("quests/dlc_1_main.nut", "PHASE_LAST") == true ? false : true;
        break;
      case "DLC2":
        is_limited = Game_IsQuestCompleted ("quests/hidden-archipelago.nut") == true ? false : true;
        break;
      case "DLC3":
        is_limited = Game_IsQuestCompleted ("quests/dlc_3_main.nut") == true ? false : true;
        break;
    }
  }
  if (is_limited == true) {
    switch (active) {
      case "Hedgefield":
        Game_FastTravelToExternalStagePointOfInterest ("stages/island/index.xml", "shelter_hedgefield_topside");
        break;
      case "Arcturus":
        Game_FastTravelToExternalStagePointOfInterest ("stages/island/index.xml", "shelter_arcturus_topside");
        break;
      case "Everglade":
        Game_FastTravelToExternalStagePointOfInterest ("stages/island/index.xml", "shelter_everglade_topside");
        break;
      case "Borealis":
        Game_FastTravelToExternalStagePointOfInterest ("stages/island/index.xml", "shelter_borealis_topside");
        break;
      case "Sunburn Desert":
        Game_FastTravelToExternalStagePointOfInterest ("stages/island/index.xml", "shelter_sunburn-desert_topside");
        break;
      case "Frore":
        Game_FastTravelToExternalStagePointOfInterest ("stages/island/index.xml", "shelter_frore_topside");
        break;
      case "Polaris":
        Game_FastTravelToExternalStagePointOfInterest ("stages/island/index.xml", "shelter_polaris_topside");
        break;
      case "Vulcan":
        Game_FastTravelToExternalStagePointOfInterest ("stages/island/index.xml", "shelter_vulcan_topside");
        break;
      case "DLC1":
        local stage = Stage_GetFilename();
        if (stage != null) {
          switch (stage) {
            case "stages/special/catacombs-midway-1.stage":
            case "stages/special/catacombs-1.stage":
              Game_FastTravelToExternalStagePointOfInterest ("stages/special/catacombs-midway-1.stage", "catacombs_entrance");
              break;
            case "stages/dlc1/index.xml":
              Game_FastTravelToExternalStagePointOfInterest ("stages/dlc1/index.xml", "underworld_start_campfire");
              break;
          }
        }
        break;
      case "DLC2":
        Game_FastTravelToExternalStagePointOfInterest ("stages/dlc2/index.xml", "DLC2_CAMPFIRE_1");
        break;
      case "DLC3":
        Game_FastTravelToExternalStagePointOfInterest ("stages/dlc3/index.xml", "SHELTER_DESOLATUM_ENTRANCE");
        break;
      case "fortress":
        Game_FastTravelToExternalStagePosition ("stages/island/index.xml", 52650.0, 30090.0, -840.0);
        break;
      case "pyramid":
        Game_FastTravelToExternalStagePosition ("stages/special/pyramid-tomb.stage", 1800.0, 3630.0, 120.0);
        break;
      case "ark":
        Game_FastTravelToExternalStagePosition ("stages/special/the-ark-level-2.stage", 1425.0, 2220.0, 10.0);
        break;
      case "random":
        local global_kvs = Game_GetGlobalKeyValueStore ("MODS");
        local stage = KeyValueStore_GetKeyValue (global_kvs, "starting_stage_respawn_stage", null);
        local position = KeyValueStore_GetKeyValue (global_kvs, "starting_stage_respawn_position", null);
        if (stage != null && position != null) {
          Game_FastTravelToExternalStagePosition (stage, position[0], position[1], position[2]);
        }
        break;
    }
    return false;
  }
}


function Mod_StartingStage_OnTriggerDown_HomePortalDevice (player) {
  local active = Game_GetWorldState ("MODS", "mod_starting_stage_active");
  if (active == null) {
    active = Game_GetWorldState ("MODS", "mod_starting_stage_initializing");
  }
  local is_limited = false;
  if (active != null) {
    switch (active) {
      case "Hedgefield":
      case "Arcturus":
      case "Everglade":
      case "Borealis":
      case "Sunburn Desert":
      case "Frore":
      case "Polaris":
      case "Vulcan":
      case "fortress":
      case "pyramid":
      case "ark":
      case "random":
        is_limited = Stage_GetFilename() == "stages/island/index.xml" && Game_IsStagePointOfInterestPUIDCompleted (tabularasa_campfire_puid) == true ? false : true;
        break;
      case "DLC1":
        is_limited = Game_IsQuestPhaseCompleted ("quests/dlc_1_main.nut", "PHASE_LAST") == true ? false : true;
        break;
      case "DLC2":
        is_limited = Game_IsQuestCompleted ("quests/hidden-archipelago.nut") == true ? false : true;
        break;
      case "DLC3":
        is_limited = Game_IsQuestCompleted ("quests/dlc_3_main.nut") == true ? false : true;
        break;
    }
  }
  if (is_limited == true) {
    Game_AddActorNotification (player, LocalizeText("I can't use this here."));
    return false;
  }
}


function Mod_StartingStage_OnGameStart_ManaRiftTeleport (rift, same) {
  local start = Game_GetWorldState ("MODS", "mod_starting_stage_initializing");
  if (start == null || start == "") {
    start = Game_GetWorldState ("MODS", "mod_starting_stage_active");
  }
  local puid = StageObject_GetPersistentUniqueId (rift);
  if (start != null && puid != null && rift_puids.rawin(start) == true && rift_puids.rawget(start).find(puid) != null) {
    StageObject_SetKeyValueBoolean (rift, "open", true);
    return true;
  }
}


function Mod_StartingStage_OnActorEntersRadiusIsInteractionAvailable_ManaRiftTeleport (rift, player) {
  if (StageObject_HasTag (player, "PLAYER") == true) {
    local start = Game_GetWorldState ("MODS", "mod_starting_stage_active");
    local puid = StageObject_GetPersistentUniqueId (rift);
    if (start != null && puid != null && rift_puids.rawin(start) == true && rift_puids.rawget(start).find(puid) != null) {
      return true;
    }
  }
}


function Mod_StartingStage_HoldDownButtonIsInteractionAvailable_ManaRiftTeleport (rift, player) {
  local start = Game_GetWorldState ("MODS", "mod_starting_stage_active");
  local puid = StageObject_GetPersistentUniqueId (rift);
  if (start != null && puid != null && rift_puids.rawin(start) == true && rift_puids.rawget(start).find(puid) != null) {
    return false;
  }
}


function Mod_StartingStage_HoldDownButton_CollectibleObject (collectible, player) {
  Game_DisableMovementForPlayer (player, 1.5, true);
  if (Actor_IsAnimationPlaying (player, "acquired_new_tool") != true) {
    Actor_QueueActionPlayAnimationWithParameters (player, "acquired_new_tool", 1.0, 0.0, false);
  }
  local recipe = StageObject_GetKeyValue (collectible, "recipe_id", "");
  if (recipe != "") {
    Game_CraftRecipe (recipe);
  }
}


function Mod_StartingStage_OnGameStart_EscapepodLaunchpad (pad, same) {
  local start = Game_GetWorldState ("MODS", "mod_starting_stage_initializing");
  if (start == null || start == "") {
    start = Game_GetWorldState ("MODS", "mod_starting_stage_active");
  }
  if (start == "fortress" && Stage_GetFilename() == "stages/island/index.xml" && StageObject_GetPersistentUniqueId (pad) == crown_launchpad_puid
  && Game_IsQuestGoalCompleted ("quests/main.nut", "ENTER_UNDERCROWN", "ENTER") != true) {
    local pod = Stage_CreateActor ("actors/mods/mod-starting-stage-escape-pod.xml", 0.0, 0.0, -4.0, false);
    StageObject_SetAngle (pod, 180.0);
    StageObject_SetParent (pod, pad);
  }
}


function Mod_StartingStage_HoldDownButton_EscapePod (pod, player) {
  Actor_QueueActionSetSolid (player, false);
  Actor_QueueActionPlayAnimation (player, "tool_unequip", true);
  Actor_QueueActionPlayAnimation (player, "emote.thinking");
  Actor_QueueActionWaitForCommandWord (player, "wait");
  local notification = Game_AddActorNotification (player, LocalizeText("Well, goodbye. [EMOJI=neutral face]"));
  local notification_script = @"function OnFinished(so_self) { Stage_SendStageObjectCommandWord ($player, ""wait""); }";
  notification_script = string_replace(notification_script, "$player", player);
  Game_SetActorNotificationOnFinishedScript (notification, notification_script);
  Actor_QueueActionMoveToBone (player, pod, "snap");
  local enter_script = @"Actor_PlayAnimation ($pod, ""enter_escapepod"");";
  enter_script = string_replace(enter_script, "$pod", pod);
  Actor_QueueActionRunScript (player, enter_script);
  Actor_QueueActionPlayAnimation (player, "enter_escapepod", true);
  Actor_QueueActionSetVisible (player, false);
  local engine_script = @"
      Actor_PlayAnimationWithDelayPlaybackSpeedAndPosition ($pod, ""engine_warmup_start"", 1.0, 1.0, 0.0);
      Actor_PlayAnimationWithDelayPlaybackSpeedAndPosition ($pod, ""engine_warmup_fail"", 5.5, 1.0, 0.0);
      Actor_PlayAnimationWithDelayPlaybackSpeedAndPosition ($pod, ""disappear"", 7.5, 1.0, 0.0);
    ";
  engine_script = string_replace (engine_script, "$pod", pod);
  engine_script = string_replace (engine_script, "$player", player);
  Actor_QueueActionRunScript (player, engine_script);
}


function Mod_StartingStage_OnActorEntersRadius_TombChest (chest, player) {
  if (Game_GetWorldState ("MODS", "mod_starting_stage_active") == "fortress"
  && Stage_GetFilename() == "stages/island/index.xml"
  && StageObject_GetPersistentUniqueId (chest) == launchpad_key_puid
  && StageObject_GetKeyValue (chest, "searched", false) != true) {
    Actor_SetInteractionEnabled (chest, "search", true);
  }
}


function Mod_StartingStage_OnInterval_SuburbFuseBox (fuse, same) {
  local start = Game_GetWorldState ("MODS", "mod_starting_stage_initializing");
  if (start == null || start == "") {
    start = Game_GetWorldState ("MODS", "mod_starting_stage_active");
  }
  if (start == "fortress" && StageObject_GetId (fuse) == "CROWN_DRONE_RECALL_BUTTON") {
    local drone = Stage_GetStageObjectById ("CROWN_DRONE", STAGE_OBJECT_TYPE_ACTOR);
    if (drone != null && StageObject_IsEnabled (drone) != true) {
      StageObject_SetEnabled (drone, true);
      Actor_SetInteractionEnabled (fuse, "mod_starting_stage_on_interval_suburb_fuse_box", false);
    }
  } else {
    Actor_SetInteractionEnabled (fuse, "mod_starting_stage_on_interval_suburb_fuse_box", false);
  }
}


function Mod_StartingStage_OnGameStart_CargoDroneLow (drone, same) {
  local start = Game_GetWorldState ("MODS", "mod_starting_stage_initializing");
  if (start == null || start == "") {
    start = Game_GetWorldState ("MODS", "mod_starting_stage_active");
  }
  if (start == "DLC2" && StageObject_GetId (drone) == "DLC2_DRONE_TO_MAIN_ISLAND") {
    if (Game_IsQuestCompleted ("quests/hidden-archipelago.nut") == true) {
      Game_RemoveWorldState ("MODS", "mod_starting_stage_active");
      Actor_SetInteractionEnabled (drone, "use", true);
      StageObject_SetEnabled (drone, true);
    } else {
      Actor_SetInteractionEnabled (drone, "use", false);
      StageObject_SetEnabled (drone, false);
    }
  }
}


function Mod_StartingStage_PressButtonIsInteractionAvailable_PetStageExit (pet_stage_exit, same) {
  local is_quest_caughtup = true;
  if (Game_GetWorldState ("MODS", "mod_starting_stage_active") == "DLC3") {
    is_quest_caughtup = false;
    if (Game_IsQuestGoalCompleted ("quests/dlc_3_main.nut", "PHASE_COMPLETE_ALL_STAGES", "ANCIENT") == true
    && Game_IsQuestGoalCompleted ("quests/dlc_3_main.nut", "PHASE_COMPLETE_ALL_STAGES", "WINTER") == true
    && Game_IsQuestGoalCompleted ("quests/dlc_3_main.nut", "PHASE_COMPLETE_ALL_STAGES", "DESERT") == true) {
      is_quest_caughtup = true;
    }
  }
  return is_quest_caughtup;
}


function Mod_StartingStage_OnGameStart_PetStageExit_Main (pet_stage_exit, same) {
  local start = Game_GetWorldState ("MODS", "mod_starting_stage_initializing");
  if (start == null || start == "") {
    start = Game_GetWorldState ("MODS", "mod_starting_stage_active");
  }
  if (start == "DLC3" && Stage_GetFilename() == "stages/pet-stages/pet-hub.stage" && StageObject_GetId (pet_stage_exit) == "entrance_default") {
    if (Game_IsQuestCompleted ("quests/dlc_3_main.nut") == true) {
      Game_RemoveWorldState ("MODS", "mod_starting_stage_active");
      StageObject_SetEnabled (pet_stage_exit, true);
    } else {
      StageObject_SetEnabled (pet_stage_exit, false);
    }
  }
}


function Mod_StartingStage_OnGameStart_PetStageExit_Circle (pet_stage_exit, same) {
  if (Game_GetWorldState ("MODS", "mod_starting_stage_used") == "DLC3") {
    local target = null;
    local id = StageObject_GetId (pet_stage_exit);
    if (id != null) {
      switch (id) {
        case "entrance_dlc1":
          if (IAP_IsItemPurchased ("DLC1") == true) {
            target = 0;
          }
          break;
        case "entrance_dlc2":
          if (IAP_IsItemPurchased ("DLC2") == true) {
            target = 0;
          }
          break;
        default:
          target = 0;
      }
    }
    return target;
  }
}


function Mod_StartingStage_OnGameStart_BuriedTeleporter (teleporter, same) {
  if (Game_GetWorldState ("MODS", "mod_starting_stage_used") == "DLC3" && Stage_GetFilename() == "stages/pet-stages/pet-hub.stage") {
    return true;
  }
}


function Mod_StartingStage_OnEnter_Stage() {
  local player = Game_GetPrimaryPlayerActor();
  local stage = Stage_GetFilename();
  if (player != null && stage != null) {
    local initializing = Game_GetWorldState ("MODS", "mod_starting_stage_initializing");
    if (initializing != null) {
      switch (initializing) {
        case "Hedgefield":
          Game_RemoveWorldState ("MODS", "mod_starting_stage_initializing");
          Game_SetRespawnPoint (77080.0, 41100.0, 0.0);
          Game_SetWorldState ("MODS", "mod_starting_stage_active", initializing);
          Game_SaveGame();
          break;
        case "Arcturus":
          Game_RemoveWorldState ("MODS", "mod_starting_stage_initializing");
          Game_CraftRecipe ("DISH_CURRY");
          Game_CraftRecipe ("HOT_WATER_BOTTLE");
          Game_SetRespawnPoint (104160.0, 17240.0, 0.0);
          Game_SetWorldState ("MODS", "mod_starting_stage_active", initializing);
          Game_SaveGame();
          break;
        case "Everglade":
          Game_RemoveWorldState ("MODS", "mod_starting_stage_initializing");
          Game_CraftRecipe ("DISH_STEAKHOUSE_SALAD");
          Game_SetRespawnPoint (101680.0, 43620.0, 0.0);
          Game_SetWorldState ("MODS", "mod_starting_stage_active", initializing);
          Game_SaveGame();
          break;
        case "Borealis":
          Game_RemoveWorldState ("MODS", "mod_starting_stage_initializing");
          Game_CraftRecipe ("DISH_CURRY");
          Game_CraftRecipe ("HOT_WATER_BOTTLE");
          Game_SetRespawnPoint (72190.0, 10260.0, 0.0);
          Game_SetWorldState ("MODS", "mod_starting_stage_active", initializing);
          Game_SaveGame();
          break;
        case "Sunburn Desert":
          Game_RemoveWorldState ("MODS", "mod_starting_stage_initializing");
          Game_SetRespawnPoint (49980.0, 43960.0, 0.0);
          Game_SetWorldState ("MODS", "mod_starting_stage_active", initializing);
          Game_SetWorldState ("TOMBS", "activated", "1");
          Game_SaveGame();
          break;
        case "Frore":
          Game_RemoveWorldState ("MODS", "mod_starting_stage_initializing");
          Game_SetRespawnPoint (47720.0, 21240.0, 0.0);
          Game_SetWorldState ("MODS", "mod_starting_stage_active", initializing);
          Game_SetWorldState ("TOMBS", "activated", "1");
          Game_SaveGame();
          break;
        case "Polaris":
          Game_RemoveWorldState ("MODS", "mod_starting_stage_initializing");
          Game_CraftRecipe ("DISH_CURRY");
          Game_CraftRecipe ("HOT_WATER_BOTTLE");
          Game_CraftRecipe ("FUR_HAT");
          Stage_RunScriptDelayed (@"Game_CraftRecipe (""OUTFIT_WINTER_COAT"", true);", 10, player);
          Stage_RunScriptDelayed (@"Game_SaveGame (true);", 18, player);
          Game_SetRespawnPoint (30340.0, 15060.0, 0.0);
          Game_SetWorldState ("MODS", "mod_starting_stage_active", initializing);
          Game_SetWorldState ("TOMBS", "activated", "1");
          break;
        case "Vulcan":
          Game_RemoveWorldState ("MODS", "mod_starting_stage_initializing");
          Game_CraftRecipe ("DISH_STEAKHOUSE_SALAD");
          Game_CraftRecipe ("ICE_BRICK");
          Stage_RunScriptDelayed (@"Game_CraftRecipe (""OUTFIT_SAFARI"", true);", 10, player);
          Stage_RunScriptDelayed (@"Game_SaveGame (true);", 18, player);
          Game_SetRespawnPoint (7100.0, 33195.0, 0.0);
          Game_SetWorldState ("MODS", "mod_starting_stage_active", initializing);
          Game_SetWorldState ("TOMBS", "activated", "1");
          break;
        case "DLC1":
          if (stage == "stages/special/catacombs-midway-1.stage") {
            Game_RemoveWorldState ("MODS", "mod_starting_stage_initializing");
            Game_SetQuestAvailable ("quests/dlc_1_main.nut");
            Game_SetQuestTracked ("quests/dlc_1_main.nut", true, true);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_1_main.nut"", ""PHASE_GO_TO_LINK_TOWER"", ""GOAL_SCAN_ANOMALIES"");", 16, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_1_main.nut"", ""PHASE_GO_TO_ENTRANCE"", ""GOAL_INVESTIGATE"");", 24, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_1_main.nut"", ""PHASE_USE_ENTRANCE"", ""GOAL_USE_ENTRANCE"");", 32, player);
            Stage_RunScriptDelayed (@"Game_ShowQuestInfoDialog (""quests/dlc_1_main.nut"");", 40, player);
            Stage_RunScriptDelayed (@"Game_SaveGame (true);", 48, player);
            Game_SetRespawnPoint (420.0, 1430.0, -240.0);
            Game_SetWorldState ("MODS", "mod_starting_stage_active", initializing);
          }
          break;
        case "DLC2":
          if (stage == "stages/dlc2/index.xml") {
            Game_RemoveWorldState ("MODS", "mod_starting_stage_initializing");
            Game_SetQuestAvailable ("quests/hidden-archipelago.nut");
            Game_SetQuestTracked ("quests/hidden-archipelago.nut", true, true);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/hidden-archipelago.nut"", ""PHASE_INVESTIGATE_SIGNAL"", ""INVESTIGATE_SIGNAL"");", 16, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/hidden-archipelago.nut"", ""PHASE_GO_TO_DRONE_DEPOT"", ""GO_TO_DRONE_DEPOT"");", 24, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/hidden-archipelago.nut"", ""PHASE_BOARD_THE_DRONE"", ""BOARD_THE_DRONE"");", 32, player);
            Stage_RunScriptDelayed (@"Game_ShowQuestInfoDialog (""quests/hidden-archipelago.nut"");", 40, player);
            Stage_RunScriptDelayed (@"Game_SaveGame (true);", 48, player);
            Game_SetRespawnPoint (9100.0, 13830.0, 0.0);
            Game_SetWorldState ("MODS", "mod_starting_stage_active", initializing);
          }
          break;
        case "DLC3":
          if (stage == "stages/dlc3/index.xml") {
            Game_RemoveWorldState ("MODS", "mod_starting_stage_initializing");
            foreach (puid in steel_block_puids) {
              local steel_block = Stage_GetStageObjectByPUID (puid);
              if (steel_block != null) {
                Stage_DealDamage (player, steel_block, 420.0, "EXPLOSIVE");
              }
            }
            Game_CraftRecipe ("DISH_STEAKHOUSE_SALAD");
            Game_CraftRecipe ("PET_PERSIAN");
            Game_UpgradeRecipe ("PET_PERSIAN");
            Game_UpgradeRecipe ("PET_PERSIAN");
            Game_UpgradeRecipe ("PET_PERSIAN");
            Game_CraftRecipe ("CHEW_TOY");
            Game_CraftRecipe ("CALLING_WHISTLE");
            Game_SetQuestAvailable ("quests/dlc_3_main.nut");
            Game_SetQuestTracked ("quests/dlc_3_main.nut", true, true);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_INVESTIGATE_DOGHOUSES"", ""GOAL_DOGHOUSES"");", 16, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_INVESTIGATE_HUB_TELEPORTER"", ""GOAL_INVESTIGATE"");", 24, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_DIG_UP_TELEPORTER"", ""SHOVEL"");", 32, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_DIG_UP_TELEPORTER"", ""GOAL_DIG"");", 40, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_USE_THE_FIRST_TELEPORTER"", ""GOAL_USE"");", 48, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_COMPLETE_THE_FIRST_PUZZLE"", ""GOAL_COMPLETE"");", 56, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_CRAFT_FIRST_PET"", ""GOAL_RETURN"");", 64, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_CRAFT_FIRST_PET"", ""GOAL_FORGE"");", 72, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_COMPLETE_N_STAGES"", ""GOAL_1"");", 80, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_COMPLETE_N_STAGES"", ""GOAL_2"");", 88, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_COMPLETE_N_STAGES"", ""GOAL_3"");", 96, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_SONAR_TRAINING_1"", ""GOAL_RETURN"");", 104, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_SONAR_TRAINING_2"", ""LINK_TOWER_SONAR_TOOLKIT"");", 112, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_SONAR_TRAINING_3"", ""LINK_TOWER_TOOLKIT"");", 120, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_SONAR_TRAINING_3"", ""INSTALL_SONAR"");", 128, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_SONAR_TRAINING_3"", ""DIG_AND_FETCH"");", 136, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_RETURN_3"", ""GOAL_RETURN"");", 144, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_COMPLETE_A_CIRCLE"", ""CIRCLE"");", 152, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_ENTER_FULL_CIRCLE_TELEPORTER"", ""GOAL_ENTER"");", 160, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_FETCH_ONE_KEY"", ""GOAL_KEY"");", 168, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_RETURN_WITH_FIRST_KEY"", ""GOAL_RETURN"");", 176, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_COMPLETE_ALL_STAGES"", ""ANCIENT"");", 184, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_COMPLETE_ALL_STAGES"", ""WINTER"");", 192, player);
            Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_3_main.nut"", ""PHASE_COMPLETE_ALL_STAGES"", ""DESERT"");", 200, player);
            Stage_RunScriptDelayed (@"Game_ShowQuestInfoDialog (""quests/dlc_3_main.nut"");", 208, player);
            Stage_RunScriptDelayed (@"Game_SaveGame (true);", 216, player);
            Game_SetRespawnPoint (10860.0, 10002.0, 0.0);
            Game_SetWorldState ("MODS", "mod_starting_stage_active", initializing);
            Game_SetWorldState ("MODS", "mod_starting_stage_used", initializing);
          }
          break;
        case "fortress":
          Game_RemoveWorldState ("MODS", "mod_starting_stage_initializing");
          Game_MarkStageObjectPUIDPersistentlyDestroyed (evacuation_wall_puid, true);
          Game_SetRespawnPoint (52650.0, 30090.0, -840.0);
          Game_SetWorldState ("MODS", "mod_starting_stage_active", initializing);
          Game_SetWorldState ("TOMBS", "activated", "1");
          Game_SaveGame();
          break;
        case "pyramid":
          if (stage == "stages/special/pyramid-tomb.stage") {
            Game_RemoveWorldState ("MODS", "mod_starting_stage_initializing");
            local player = Game_GetPrimaryPlayerActor();
            if (player != null) {
              Game_SpawnMaterials (player, player, "MANA_SHARD,MANA_CHUNK,MANA_BEAD");
              local position = StageObject_GetStagePosition (player);
              if (position != null) {
                local valid_position = Game_GetValidPosition (position[0], position[1], position[2], 60.0, 30.0);
                if (valid_position == null) valid_position = position;
                Game_CreateKeyActor (position[0], position[1], position[2] - 30.0, "SURREAL_KEY");
              }
              foreach (puid in pyramid_tomb_puids) {
                local tablet = Stage_GetStageObjectByPUID (puid);
                if (tablet != null) {
                  Actor_InteractWithInteraction (tablet, player, "tomb_read");
                }
              }
            }
            local sarcophage = Stage_GetStageObjectByPUID (35);
            if (sarcophage != null) {
              Actor_SetInteractionEnabled (sarcophage, "use", false);
              StageObject_SetKeyValueBoolean (sarcophage, "looted_corpse", true);
              Actor_PlayAnimationWithDelayPlaybackSpeedAndPosition (sarcophage, "open", 0, 1, 1);
            }
            Game_CraftRecipe ("DISH_STEAKHOUSE_SALAD");
            Game_SetRespawnPoint (1800.0, 3630.0, 120.0);
            Game_SetWorldState ("MODS", "mod_starting_stage_active", initializing);
            Game_SetWorldState ("TOMBS", "activated", "1");
            Game_SaveGame();
          }
          break;
        case "ark":
          if (stage == "stages/special/the-ark-level-2.stage") {
            Game_RemoveWorldState ("MODS", "mod_starting_stage_initializing");
            local position = StageObject_GetStagePosition (player);
            if (position != null) {
              local valid_position = Game_GetValidPosition (position[0], position[1], position[2], 60.0, 30.0);
              if (valid_position == null) valid_position = position;
              Game_CreateKeyActor (position[0], position[1], position[2] - 30.0, "ARK_LAB_KEY");
            }
            Game_SetWorldState ("ENTER_AREA", "ARK2_WALK_TO_THRONE", "1");
            Game_SetWorldState ("ENTER_AREA", "ARK2_START_CUTSCENE", "1");
            Game_SetWorldState ("ENTER_AREA", "ARK2_THRONE_SIT", "1");
            Game_SetRespawnPoint (1425.0, 2220.0, 10.0);
            Game_SetWorldState ("MODS", "mod_starting_stage_active", initializing);
            Game_SetWorldState ("TOMBS", "activated", "1");
            Game_SaveGame();
          }
          break;
        case "random":
          Game_RemoveWorldState ("MODS", "mod_starting_stage_initializing");
          Game_SetQuestAvailable ("quests/preparing-for-winter.nut");
          Game_SetQuestAvailable ("quests/sweltering-heat.nut");
          Game_SetTemporaryModifier (player, "mod_starting_stage", 60.0 * 60.0, "cold_protection_absolute_increase", 70.0);
          Game_SetTemporaryModifier (player, "mod_starting_stage", 60.0 * 60.0, "heat_protection_absolute_increase", 80.0);
          local player_position = StageObject_GetStagePosition (player);
          if (player_position != null) {
            local global_kvs = Game_GetGlobalKeyValueStore ("MODS");
            KeyValueStore_SetKeyValueStage (global_kvs, "starting_stage_respawn_stage", stage);
            KeyValueStore_SetKeyValuePosition (global_kvs, "starting_stage_respawn_position", player_position[0], player_position[1], player_position[2]);
            Game_SetRespawnPoint (player_position[0], player_position[1], player_position[2]);
          }
          switch (stage) {
            case "stages/island/index.xml":
            case "stages/undercrown/index.xml":
              Game_SetWorldState ("TOMBS", "activated", "1");
              break;
            case "stages/dlc1/index.xml":
              Game_SetQuestAvailable ("quests/dlc_1_main.nut");
              Game_SetQuestTracked ("quests/dlc_1_main.nut", true, true);
              Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_1_main.nut"", ""PHASE_GO_TO_LINK_TOWER"", ""GOAL_SCAN_ANOMALIES"");", 16, player);
              Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_1_main.nut"", ""PHASE_GO_TO_ENTRANCE"", ""GOAL_INVESTIGATE"");", 24, player);
              Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_1_main.nut"", ""PHASE_USE_ENTRANCE"", ""GOAL_USE_ENTRANCE"");", 32, player);
              Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_1_main.nut"", ""PHASE_EXPLORE_CATACOMBS"", ""GOAL_INVESTIGATE_CATACOMBS"");", 40, player);
              Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/dlc_1_main.nut"", ""PHASE_DOORWAY"", ""GOAL_DOORWAY_ENTER"");", 48, player);
              Stage_RunScriptDelayed (@"Game_ShowQuestInfoDialog (""quests/dlc_1_main.nut"");", 56, player);
              Stage_RunScriptDelayed (@"Game_SaveGame (true);", 64, player);
              break;
            case "stages/dlc2/index.xml":
              Game_SetQuestAvailable ("quests/hidden-archipelago.nut");
              Game_SetQuestTracked ("quests/hidden-archipelago.nut", true, true);
              Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/hidden-archipelago.nut"", ""PHASE_INVESTIGATE_SIGNAL"", ""INVESTIGATE_SIGNAL"");", 16, player);
              Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/hidden-archipelago.nut"", ""PHASE_GO_TO_DRONE_DEPOT"", ""GO_TO_DRONE_DEPOT"");", 24, player);
              Stage_RunScriptDelayed (@"Game_QuestGoalCompleted (""quests/hidden-archipelago.nut"", ""PHASE_BOARD_THE_DRONE"", ""BOARD_THE_DRONE"");", 32, player);
              Stage_RunScriptDelayed (@"Game_ShowQuestInfoDialog (""quests/hidden-archipelago.nut"");", 40, player);
              Stage_RunScriptDelayed (@"Game_SaveGame (true);", 48, player);
              break;
          }
          Game_SetWorldState ("MODS", "mod_starting_stage_active", initializing);
          Game_SaveGame (true);
          break;
      }
    }
    local active = Game_GetWorldState ("MODS", "mod_starting_stage_active");
    if (active != null) {
      switch (active) {
        case "Hedgefield":
        case "Arcturus":
        case "Everglade":
        case "Borealis":
        case "Sunburn Desert":
        case "Frore":
        case "Polaris":
        case "Vulcan":
        case "fortress":
        case "random":
          if (Game_GetWorldStateAsInteger ("FPS_MEASUREMENT", "first_house") == 1) {
            Game_RemoveWorldState ("MODS", "mod_starting_stage_active");
          }
          break;
        case "DLC1":
          if (Game_IsQuestPhaseCompleted ("quests/dlc_1_main.nut", "PHASE_LAST") == true) {
            Game_RemoveWorldState ("MODS", "mod_starting_stage_active");
          } else if (stage == "stages/special/catacombs-midway-1.stage") {
            local exit = Stage_GetStageObjectById ("catacombs_entrance", STAGE_OBJECT_TYPE_ACTOR);
            if (exit != null) {
              Actor_SetInteractionEnabled (exit, "leave", false);
            }
          }
          break;
        case "DLC2":
          if (Game_IsQuestCompleted ("quests/hidden-archipelago.nut") == true) {
            Game_RemoveWorldState ("MODS", "mod_starting_stage_active");
          }
          break;
        case "DLC3":
          if (Game_IsQuestCompleted ("quests/dlc_3_main.nut") == true) {
            Game_RemoveWorldState ("MODS", "mod_starting_stage_active");
          }
          if (stage == "stages/pet-stages/pet-hub.stage" && IAP_IsItemPurchased ("DLC2") == true && Game_IsRecipeCrafted ("BEAM_GUN") != true) {
            local beamgun = Stage_CreateActor ("actors/mods/mods-collect-beamgun.xml", 4535.0, 2715.0, -55.0, false);
            StageObject_SetAngles (beamgun, 60.0, 0.0, 20.0);
          }
          break;
        case "pyramid":
          if (stage == "stages/special/pyramid-tomb.stage") {
            local marker = Stage_GetStageObjectById ("trigger_open_doors", STAGE_OBJECT_TYPE_MARKER);
            if (marker != null) {
              Marker_SetRadius (marker, 210.0);
            }
            if (Game_IsRecipeCrafted ("KHOPESH") != true) {
              Stage_CreateActor ("actors/mods/mods-collect-khopesh.xml", 335.0, 1950.0, -78.0, false);
            }
          } else if (stage == "stages/island/index.xml") {
            local entrance = Stage_GetStageObjectById ("pyramid_tomb_entrance", STAGE_OBJECT_TYPE_ACTOR);
            if (entrance != null) {
              StageObject_SetKeyValueBoolean (entrance, "unlocked", true);
              Actor_PlayAnimationWithDelayPlaybackSpeedAndPosition (entrance, "unlock", 0, 1, 1);
            }
          }
          if (Game_GetWorldStateAsInteger ("FPS_MEASUREMENT", "first_house") == 1) {
            Game_RemoveWorldState ("MODS", "mod_starting_stage_active");
          }
          break;
        case "ark":
          if (stage == "stages/special/the-ark-level-2.stage") {
            if (Game_IsRecipeCrafted ("POWER_FIST") != true) {
              local fist = Stage_CreateActor ("actors/mods/mods-collect-powerfist.xml", 1830.0, 240.0, -25.0, false);
              StageObject_SetAngles (fist, 0.0, 180.0, 150.0);
            }
            foreach (puid in [ 202, 203 ] ) {
              local door = Stage_GetStageObjectByPUID (puid);
              Stage_SendStageObjectCommandWord (door, "open");
            }
          } else if (stage == "stages/island/index.xml") {
            local gate = Stage_GetStageObjectByPUID (ark_door_puid);
            if (gate != null) {
              Actor_InteractWithInteraction (gate, player, "force_open");
            }
          }
          if (Game_GetWorldStateAsInteger ("FPS_MEASUREMENT", "first_house") == 1) {
            Game_RemoveWorldState ("MODS", "mod_starting_stage_active");
          }
          break;
      }
    }
    local dlc = Profile_GetValue ("!SAVE_STATE", "mod_starting_stage", "dlc");
    local shelter = Profile_GetValue ("!SAVE_STATE", "mod_starting_stage", "shelter");
    local location = Profile_GetValue ("!SAVE_STATE", "mod_starting_stage", "location");
    if (shelter != null && shelter != "") location = shelter;
    if (dlc != null && dlc != "") {
      Profile_SetValue ("!SAVE_STATE", "mod_starting_stage", "dlc", "");
      if (IAP_IsItemPurchased (dlc) == true) {
        Game_SetWorldState ("MODS", "mod_starting_stage_initializing", dlc);
        Game_LogEvent ("MOD_STARTING_STAGE", dlc);
        switch (dlc) {
          case "DLC1":
            Stage_RunScriptDelayed (@"Game_FastTravelToExternalStagePointOfInterest (""stages/special/catacombs-midway-1.stage"", ""catacombs_entrance"");", 6, player);
            break;
          case "DLC2":
            Stage_RunScriptDelayed (@"Game_FastTravelToExternalStagePointOfInterest (""stages/dlc2/index.xml"", ""DLC2_CAMPFIRE_1"");", 6, player);
            break;
          case "DLC3":
            Stage_RunScriptDelayed (@"Game_FastTravelToExternalStagePointOfInterest (""stages/dlc3/index.xml"", ""SHELTER_DESOLATUM_ENTRANCE"");", 6, player);
            break;
        }
      }
    } else if (location != null && location != "") {
      Profile_SetValue ("!SAVE_STATE", "mod_starting_stage", "location", "");
      Profile_SetValue ("!SAVE_STATE", "mod_starting_stage", "shelter", "");
      Game_SetWorldState ("MODS", "mod_starting_stage_initializing", location);
      Game_LogEvent ("MOD_STARTING_STAGE", location);
      switch (location) {
        case "Hedgefield":
          Stage_RunScriptDelayed (@"Game_FastTravelToExternalStagePointOfInterest (""stages/island/index.xml"", ""shelter_hedgefield_topside"");", 6, player);
          break;
        case "Arcturus":
          Stage_RunScriptDelayed (@"Game_FastTravelToExternalStagePointOfInterest (""stages/island/index.xml"", ""shelter_arcturus_topside"");", 6, player);
          break;
        case "Everglade":
          Stage_RunScriptDelayed (@"Game_FastTravelToExternalStagePointOfInterest (""stages/island/index.xml"", ""shelter_everglade_topside"");", 6, player);
          break;
        case "Borealis":
          Stage_RunScriptDelayed (@"Game_FastTravelToExternalStagePointOfInterest (""stages/island/index.xml"", ""shelter_borealis_topside"");", 6, player);
          break;
        case "Sunburn Desert":
          Stage_RunScriptDelayed (@"Game_FastTravelToExternalStagePointOfInterest (""stages/island/index.xml"", ""shelter_sunburn-desert_topside"");", 6, player);
          break;
        case "Frore":
          foreach (puid in central_gascloud_puids) {
            Game_MarkStageObjectPUIDPersistentlyDestroyed (puid, true);
          }
          Stage_RunScriptDelayed (@"Game_FastTravelToExternalStagePointOfInterest (""stages/island/index.xml"", ""shelter_frore_topside"");", 6, player);
          break;
        case "Polaris":
          Stage_RunScriptDelayed (@"Game_FastTravelToExternalStagePointOfInterest (""stages/island/index.xml"", ""shelter_polaris_topside"");", 6, player);
          break;
        case "Vulcan":
          Game_MarkStageObjectPUIDPersistentlyDestroyed (harbor_box_puid, true);
          Stage_RunScriptDelayed (@"Game_FastTravelToExternalStagePointOfInterest (""stages/island/index.xml"", ""shelter_vulcan_topside"");", 6, player);
          break;
        case "fortress":
          Stage_RunScriptDelayed (@"Game_FastTravelToExternalStagePosition (""stages/island/index.xml"", 52650.0, 30090.0, -840.0);", 6, player);
          break;
        case "pyramid":
          Stage_RunScriptDelayed (@"Game_FastTravelToExternalStagePosition (""stages/special/pyramid-tomb.stage"", 1800.0, 3630.0, 120.0);", 6, player);
          break;
        case "ark":
          foreach (puid in central_gascloud_puids) {
            Game_MarkStageObjectPUIDPersistentlyDestroyed (puid, true);
          }
          Stage_RunScriptDelayed (@"Game_FastTravelToExternalStagePosition (""stages/special/the-ark-level-2.stage"", 1425.0, 2220.0, 10.0);", 6, player);
          break;
        case "random":
          local total_poi_count = 0;
          foreach (stage_base, stage_data in poi_stages) {
            local valid_pois = [];
            if (stage_data.rawin("dlc") != true || IAP_IsItemPurchased (stage_data.rawget("dlc")) == true) {
              local stage = stage_base + "/index.xml";
              local pois = stage_base + "/points-of-interest.xml";
              for (local pois_node_index = 0; pois_node_index < DM_GetArrayNumberOfNodes (pois, stage); pois_node_index++) {
                local type = DM_GetArrayNodeValue (pois, stage, pois_node_index, "type");
                if (type != null && blacklist_poi_types.find(type) == null) {
                  if (type != "ANIMAL" || DM_GetArrayNodeValue (pois, stage, pois_node_index, "actor_type") != "actors/animals/vulture.xml") {
                    local requires_iap = DM_GetArrayNodeValue (pois, stage, pois_node_index, "requires_iap");
                    if (requires_iap == null || requires_iap == "" || IAP_IsItemPurchased (requires_iap) == true) {
                      local so_id = DM_GetArrayNodeValue (pois, stage, pois_node_index, "so_id");
                      if (so_id != null && so_id != "") {
                        valid_pois.push(so_id);
                      }
                    }
                  }
                }
              }
              total_poi_count += valid_pois.len();
            }
            poi_stages[stage_base]["pois"] <- valid_pois;
          }
          local winner_poi_number = (m_randf() * total_poi_count.tofloat()).tointeger();
          if (winner_poi_number == total_poi_count) winner_poi_number = 0;
          local winner_stage_base = null;
          foreach (stage_base, stage_data in poi_stages) {
            winner_stage_base = stage_base;
            local poi_count = stage_data.pois.len();
            if (winner_poi_number < poi_count) {
              break;
            }
            winner_poi_number -= poi_count;
          }
          local poi = poi_stages[winner_stage_base].pois[winner_poi_number];
          local script = @"
              Game_FastTravelToExternalStagePointOfInterest (""$stage"", ""$poi"");
            ";
          script = string_replace(script, "$stage", winner_stage_base + "/index.xml");
          script = string_replace(script, "$poi", poi);
          Stage_RunScriptDelayed (script, 6, player);
          break;
      }
    }
    if (stage == "stages/island/index.xml") {
      foreach (puid in blocking_puids) {
        Game_MarkStageObjectPUIDPersistentlyDestroyed (puid, true);
      }
    }
    if (stage == "stages/tombs/tomb-link-relay.xml") {
      local marker = Stage_GetStageObjectById ("loop_back_to_relay", STAGE_OBJECT_TYPE_MARKER);
      if (marker != null) {
        StageObject_SetEnabled (marker, false);
      }
    }
  }
}


function Mod_StartingStage_OnClick_FirstGameOptions (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_starting_stage":
        local index = UI_GetProperty ("mod_starting_stage", "drop_down_list.selected_line_index");
        local selected = index == null || index == 0 ? null : UI_GetDropDownListLineIdByIndex ("mod_starting_stage", index.tointeger());
        Profile_SetValue ("!SAVE_STATE", "mod_starting_stage", "dlc", "");
        Profile_SetValue ("!SAVE_STATE", "mod_starting_stage", "shelter", "");
        Profile_SetValue ("!SAVE_STATE", "mod_starting_stage", "location", "");
        if (selected != null && selected != "" && selected != "vanilla") {
          if (selected.len() > 4 && selected.slice(0, 4) == "dlc_") {
            Profile_SetValue ("!SAVE_STATE", "mod_starting_stage", "dlc", selected.slice(4));
          } else if (selected.len() > 8 && selected.slice(0, 8) == "shelter_") {
            Profile_SetValue ("!SAVE_STATE", "mod_starting_stage", "location", selected.slice(8));
          } else {
            Profile_SetValue ("!SAVE_STATE", "mod_starting_stage", "location", selected);
          }
        }
        break;
      case "mod_starting_stage_title":
        Mods_Info_Popup (
            LocalizeText("Starting stage"),
            LocalizeText("Begin your new game right on a DLC map or at another shelter, to increase challenge."));
        break;
    }
  }
}


function Mod_StartingStage_OnEnter_FirstGameOptions() {
  UI_SetProperty ("mod_starting_stage_title", "textbox.text", "|img src='emojis/package.png' scale=0.7 offset=2|   " + LocalizeText("Starting stage"));
  UI_RemoveAllDropDownListLines ("mod_starting_stage");
  UI_AddDropDownListLine ("mod_starting_stage", "vanilla", "vanilla");
  foreach (location in [ "Hedgefield", "Arcturus", "Everglade", "Borealis", "Sunburn Desert", "Frore", "Polaris", "Vulcan" ]) {
    UI_AddDropDownListLine ("mod_starting_stage", location, LocalizeText(location));
  }
  foreach (dlc in [ "DLC1", "DLC2" ]) {
    if (IAP_IsItemPurchased (dlc) == true) {
      local text = DM_GetArrayNodeValue ("in-app-purchases/in-app-purchases.xml", "ITEMS", dlc, "name");
      UI_AddDropDownListLine ("mod_starting_stage", "dlc_" + dlc, text == null ? dlc : LocalizeText(text));
    }
  }
  if (IAP_IsItemPurchased ("DLC3") == true) {
    UI_AddDropDownListLine ("mod_starting_stage", "dlc_DLC3", LocalizeText("Desolatum"));
  }
  UI_AddDropDownListLine ("mod_starting_stage", "fortress", LocalizeText("King's Study"));
  UI_AddDropDownListLine ("mod_starting_stage", "pyramid", LocalizeText("Tomb of the Immortal King"));
  UI_AddDropDownListLine ("mod_starting_stage", "ark", LocalizeText("The Ark"));
  UI_AddDropDownListLine ("mod_starting_stage", "random", LocalizeText("random location"));
  Mod_StartingStage_OnClick_FirstGameOptions ("mod_starting_stage");
  UI_SetProperty ("Title3", "parent", "aligner_3");
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
