// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-starting-stage.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function IsInteractionAvailable(so_self, so_activator)
{
  if (!IAP_IsItemPurchased("DLC3"))
    return false;

  local required_phase = StageObject_GetKeyValue(so_self, "requires_dlc3_main_quest_phase", null);
  if (required_phase != null)
  {
    local quest_id = "quests/dlc_3_main.nut";
    if (!(Game_IsQuestPhaseCurrent(quest_id, required_phase) ||
        Game_IsQuestPhaseCompleted(quest_id, required_phase)))
        return false;
  }
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  local is_unlocked = StageObject_GetKeyValue (so_self, "unlocked", false);
  if (this.rawin ("Mod_StartingStage_OnGameStart_BuriedTeleporter") == true) {
    local ret = Mod_StartingStage_OnGameStart_BuriedTeleporter (so_self, so_activator);
    if (ret != null) is_unlocked = ret;
  }
  return Game_IsBuriedTeleporterFound(StageObject_GetId(so_self)) || is_unlocked;
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}


function OnInteraction(so_self, so_activator)
{
  local stage_id = StageObject_GetKeyValue(so_self, "stage");
  if (stage_id == null)
    return;

  Game_RevealActorOnMap(so_self);

  local quest_id = "quests/dlc_3_main.nut";
  if (Game_IsQuestCurrent(quest_id))
  {
    local phase_id = "PHASE_INVESTIGATE_HUB_TELEPORTER";
    local goal_id = "GOAL_INVESTIGATE";
    /*if (!Game_IsQuestGoalCompleted(quest_id, phase_id, goal_id))
      Game_QuestGoalCompleted(quest_id, phase_id, goal_id);*/

    if (stage_id != "stages/pet-stages/pet-hub.stage")
    {
      // Check that the id matches.
      phase_id = "PHASE_USE_THE_FIRST_TELEPORTER";
      goal_id = "GOAL_USE";

      if (Game_IsQuestPhaseCurrent(quest_id, phase_id) &&
        !Game_IsQuestGoalCompleted(quest_id, phase_id, goal_id))
        Game_QuestGoalCompleted(quest_id, phase_id, goal_id);
    }
  }

  Actor_QueueActionWaitForCommandWord(so_self, "wait");
  local pos = StageObject_GetPosition(so_self);
  Actor_QueueActionMove(so_activator, pos[0], pos[1], pos[2]);
  Actor_QueueActionSendCommandWord(so_activator, so_self, "wait");
  Actor_PlayAnimation(so_self, "stage_exit");
  Actor_PlayAnimationWithDelayPlaybackSpeedAndPosition(so_activator, "teleport_out", 1, 1, 0);
  Game_SetCinemaMode(true);
  Game_SetScreenFadeOutWithCommand(1, "travel_to_stage", so_self, 2.0);
}
