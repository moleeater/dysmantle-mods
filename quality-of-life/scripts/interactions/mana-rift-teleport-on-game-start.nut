// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-starting-stage.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function OnInteraction(so_self, so_activator)
{
  if (Game_IsQuestCompleted("quests/displaced-guards.nut"))
    Game_SetWorldState("MANA_RIFTS", "enabled", "1");

  local enabled = Game_GetWorldStateAsInteger("MANA_RIFTS", "enabled") > 0;

  local req_quest = StageObject_GetKeyValue (so_self,"required_quest_id");
  local req_phase = StageObject_GetKeyValue (so_self,"required_quest_phase_id");

  if (req_quest != null && req_phase != null)
  {
    enabled = enabled && Game_IsQuestPhaseCompleted(req_quest, req_phase);
  }

// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_StartingStage_OnGameStart_ManaRiftTeleport") == true) {
    local ret = Mod_StartingStage_OnGameStart_ManaRiftTeleport (so_self, so_activator);
    if (ret != null) enabled = ret;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  Actor_SetActorFlag(so_self, "ONLY_VISIBLE_IN_EDITOR", !enabled);
  if (enabled)
  {
    if (StageObject_GetKeyValue(so_self, "open"))
    {
      if (!Actor_IsAnimationPlaying(so_self, "opened"))
        Actor_PlayAnimation(so_self, "opened");
      Actor_StopAnimationWithFade(so_self, "closed", 0);
    }
    else
    {
      if (!Actor_IsAnimationPlaying(so_self, "closed"))
        Actor_PlayAnimation(so_self, "closed");
      Actor_StopAnimationWithFade(so_self, "opened", 0);
    }
    Actor_StopAnimationWithFade(so_self, "hint", 0);
  }
  else
  {
    if (!Actor_IsAnimationPlaying(so_self, "hint"))
      Actor_PlayAnimation(so_self, "hint");
    Actor_StopAnimationWithFade(so_self, "opened", 0);
    Actor_StopAnimationWithFade(so_self, "closed", 0);
  }

  local open_cost = StageObject_GetKeyValue(so_self, "open_cost");
  if (open_cost == null)
    open_cost = 1;


  local text = LOC_TEXT("Open");
//  if (Game_IsRecipeCrafted("RIFT_TOOLKIT"))
  {
    if (open_cost > 0)
      text = text + " (" + open_cost + "x[MATERIAL_ICON=MANA_CHUNK])";
  }

  Actor_SetInteractionText(so_self, "open", Game_GetConvertedString(text));
}
