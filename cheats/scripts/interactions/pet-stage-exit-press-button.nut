// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-starting-stage.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function IsInteractionAvailable(so_self, so_activator)
{
 return !Game_IsShowingActorNotification(so_activator);
}


function OnInteraction(so_self, so_activator)
{
  local set_id = StageObject_GetKeyValue(so_self, "set", null);
  if (set_id != null)
  {
    local num = Game_GetWorldStateAsInteger("PET_HUB_PROGRESS", set_id, 0);
    local target = Game_GetWorldStateAsInteger("PET_HUB_PROGRESS_TARGET", set_id, 0);
    if (target < 2)
      target = 2; // Fixes temporary issue with saves.
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    if (this.rawin ("Mod_StartingStage_OnGameStart_PetStageExit_Circle") == true) {
      local ret = Mod_StartingStage_OnGameStart_PetStageExit_Circle (so_self, so_activator);
      if (ret != null) target = ret;
    }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    //Game_AddActorNotification(so_self, "Required " + num + " / " + target);
    if (num < target)
      return;

    local quest_id = "quests/dlc_3_main.nut";
    if (Game_IsQuestPhaseCurrent(quest_id, "PHASE_ENTER_FULL_CIRCLE_TELEPORTER") && set_id == "FOREST")
    {
      Game_QuestGoalCompleted(quest_id, "PHASE_ENTER_FULL_CIRCLE_TELEPORTER", "GOAL_ENTER");
    }
    quest_id = "quests/dlc_3_underworld_circle.nut";
    if (Game_IsQuestPhaseCurrent(quest_id, "PHASE_ENTER_FULL_CIRCLE_TELEPORTER") && set_id == "DLC1")
    {
      Game_QuestGoalCompleted(quest_id, "PHASE_ENTER_FULL_CIRCLE_TELEPORTER", "GOAL_ENTER");
    }
    quest_id = "quests/dlc_3_doomsday_circle.nut";
    if (Game_IsQuestPhaseCurrent(quest_id, "PHASE_ENTER_FULL_CIRCLE_TELEPORTER") && set_id == "DLC2")
    {
      Game_QuestGoalCompleted(quest_id, "PHASE_ENTER_FULL_CIRCLE_TELEPORTER", "GOAL_ENTER");
    }
  }

  Game_SetStagePointOfInterestCompleted(so_self);

  local pos = StageObject_GetPosition(so_self);
  local angle = StageObject_GetAngle(so_self);
  local plr_pos = StageObject_GetPosition(so_activator);
  local dx = pos[0] - plr_pos[0];
  local dy = pos[1] - plr_pos[1];
  local dist = sqrt(dx*dx+dy*dy);
  if (dist > 5)
  {
    Actor_QueueActionMove(so_activator, pos[0], pos[1]);
  }
  Actor_QueueActionTurn(so_activator, angle);

  local stage_kvs = Stage_GetKeyValueStore();
  if (!KeyValueStore_GetKeyValue(stage_kvs, "force_player_unarmed", false))
    Actor_QueueActionPlayAnimation(so_activator, "tool_unequip", true);
  Actor_QueueActionPlayAnimation(so_activator, "teleport_out", true);
  Actor_QueueActionSendCommandWord(so_activator, so_self, "wait");

  Actor_QueueActionPlayAnimation(so_self, "stage_exit", true);

  Game_SetCinemaMode(true);

  local is_pet_hub_teleporter = StageObject_GetKeyValue(so_self, "pet_hub_teleporter", false);

  if (is_pet_hub_teleporter)
  {
    // Check that are we returning to the position where we portaled in before.
    local kvs = Game_GetGlobalKeyValueStore("pet_hub_portal");
    if (kvs != null)
    {
      local target_stage = KeyValueStore_GetKeyValue(kvs, "teleport_from_stage");
      local target_pos = KeyValueStore_GetKeyValue(kvs, "teleport_target_pos");
      local is_open = KeyValueStore_GetKeyValue(kvs, "open", false);
      if (is_open && target_pos != null)
      {
        KeyValueStore_SetKeyValueBoolean(kvs, "open", false);
        Game_FastTravelToExternalStagePosition(target_stage, target_pos[0], target_pos[1], target_pos[2]);

        // This gets reset at campfire and on death. Used for blocking timed crates.
        Game_SetPlayerState("used_home_portal", "1");

        return;
      }
    }
  }

  local travel_to_entrance_id = StageObject_GetKeyValue(so_self, "travel_to_entrance_id");
  if (travel_to_entrance_id == null || travel_to_entrance_id == "")
  {
    // Fallback for returning from tombs etc.
    Game_SetScreenFadeOutWithCommand(1, "travel_back_from_stage", so_activator, 1.5);
  }
  else
  {
    Game_SetScreenFadeOutWithCommand(1, "travel_to_stage", so_self, 1.5);
  }
}
