// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-starting-stage.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function IsInteractionAvailable(so_self, so_activator)
{
  if (!IAP_IsItemPurchased("DLC3"))
    return false;

  if (Game_IsShowingActorNotification(so_activator))
    return false;

// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_StartingStage_PressButtonIsInteractionAvailable_DogHouse") == true) {
    local ret = Mod_StartingStage_PressButtonIsInteractionAvailable_DogHouse (so_self, so_activator);
    if (ret != null) return ret;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  local quest = "quests/dlc_3_main.nut";
  if (!Game_IsQuestGoalCompleted(quest, "PHASE_INVESTIGATE_DOGHOUSES", "GOAL_DOGHOUSES"))
    return true;

  return false;
}

function TeleportPlayer(so_activator)
{
  //Game_SetCinemaMode(true);

  local current_stage = Stage_GetFilename();
  if (current_stage == "stages/island/index.xml")
  {
    local so = Stage_GetStageObjectById("PET_HUB_TELEPORTER_ENTRY");
    local pos = StageObject_GetPosition(so);
    Game_TeleportPlayers(pos[0], pos[1]);
    //Game_TeleportPlayers(79810, 34320);
  }
  else
  {
     // This doesn't work for some reason.
     //Game_FastTravelToExternalStagePointOfInterest("stages/island/index.xml", "PET_HUB_TELEPORTER_ENTRY");
  }
}

function OnInteraction(so_self, so_activator)
{
  local current_stage = Stage_GetFilename();
  if (current_stage != "stages/island/index.xml")
  {
    // We need to block this in other stages because the teleporting has to happen in the same stage.
    Game_AddActorNotificationWithDelay(so_activator, LOC_TEXT("Nothing special in this doghouse. I should look for the ones on the [ORANGE]main island[DEFAULT]."), 0.3);
    return;
  }

  if (Game_IsInCombat(so_self))
  {
    Game_AddActorNotificationWithDelay(so_activator, LOC_TEXT("There are monsters near. I should take care of them first before investigating this doghouse."), 0.0);
    return;
  }

  local num_investigated = Game_GetWorldStateAsInteger("DOGHOUSES", "investigated", 0);

  local quest = "quests/dlc_3_main.nut";
  if (num_investigated == 0)
  {
    Game_ShowQuestStartDialog(quest, true);
    Game_SetWorldState("DOGHOUSES", "investigated", "1");
    StageObject_SetKeyValueBoolean(so_self, "investigated", true);
    Game_SetStagePointOfInterestCompleted(so_self);
    Game_AddActorNotificationWithDelay(so_activator, LOC_TEXT("There are traces of [BLUE]glowing blue powder[DEFAULT] inside the small dwelling. Interesting. I should look for more [ORANGE]Doghouses[DEFAULT]."), 0.65);
    return;
  }
  else
  {
    local investigated = StageObject_GetKeyValue(so_self, "investigated", false);
    if (num_investigated >= 4)
    {
      TeleportPlayer(so_activator);
      return;
    }

    if (investigated)
    {
      Game_AddActorNotificationWithDelay(so_activator, LOC_TEXT("I've already searched this doghouse."), 0.0);
    }
    else
    {
      StageObject_SetKeyValueBoolean(so_self, "investigated", true);
      Game_SetStagePointOfInterestCompleted(so_self);
      num_investigated = num_investigated + 1;
      Game_SetWorldState("DOGHOUSES", "investigated", num_investigated.tostring());
      if (num_investigated == 2)
      {
        Game_AddActorNotificationWithDelayVoiceover(so_self, LOC_TEXT("[CYAN]Hello human!"), 0, "sfx/pet-hub/doghouse_01");
        Game_AddActorNotificationWithDelay(so_activator, LOC_TEXT("What was that?!"), 1.2);
        Game_AddActorNotificationWithDelay(so_activator, LOC_TEXT("The doghouse is empty! Where did the voice come from?? I should try to find more [ORANGE]Doghouses[DEFAULT]."), 0);
      }
      else if (num_investigated == 3)
      {
        Game_SaveGame(true);
        // Store position so we know how to teleport back. Using pethub portal data store as it's not being used yet.
        local kvs_global = Game_GetGlobalKeyValueStore("pet_hub_portal");
        local current_pos = StageObject_GetStagePosition(so_activator);
        local current_stage = Stage_GetFilename();
        KeyValueStore_SetKeyValuePosition(kvs_global, "teleport_target_pos", current_pos[0], current_pos[1], current_pos[2]);
        KeyValueStore_SetKeyValueString(kvs_global, "teleport_from_stage", current_stage);

        Actor_QueueActionPlayAnimationWithParameters(so_activator, "home_portal_used", 2, 0, true);
        //Game_FastTravelToExternalStagePointOfInterest("stages/dlc3/index.xml", "DOGHOUSE_TELEPORT");
        // Travelling to DOGHOUSE_TELEPORT position but without the entry offset that the above method adds.
        Game_FastTravelToExternalStagePosition("stages/dlc3/index.xml", 14140, 3049, -720);
      }
      else
      {
        TeleportPlayer(so_activator);
      }
    }
  }
}
