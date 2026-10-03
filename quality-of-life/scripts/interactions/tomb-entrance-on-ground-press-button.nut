// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-starting-stage.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function IsInteractionAvailable(so_self, so_activator)
{
  local activated = Game_GetWorldState("TOMBS", "activated") != null;
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_StartingStage_PressButtonIsInteractionAvailable_TombEntranceOnGround") == true) {
    local ret = Mod_StartingStage_PressButtonIsInteractionAvailable_TombEntranceOnGround (so_self, so_activator);
    if (ret != null) return ret;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  return !activated &&
    !Game_IsShowingActorNotification(so_activator) &&
    !StageObject_GetKeyValue(so_self, "unlocked") &&
    !Game_IsQuestCompleted("quests/tombs-investigate.nut");
}


function OnInteraction(so_self, so_activator)
{
  local text_0 = LOC_TEXT("I remember these ancient stone formations.");
  local text_1 = LOC_TEXT("Nobody seemed to know exactly what their purpose was.");
  Game_AddActorNotification(so_activator, text_0);
  Game_AddActorNotification(so_activator, text_1);

  /*local quest_id = "quests/tombs-investigate.nut";
  Game_LogEvent("TOMB_INVESTIGATE");

  if (!Game_IsQuestCurrent(quest_id))
  {
    UI_SendScreenMessage("QuestInfo", "quest_id", quest_id);
    UI_SendScreenMessage("QuestInfo", "so_handle_quest_trigger", so_self.tostring());
    UI_SendScreenMessage("QuestInfo", "so_handle_activator", so_activator.tostring());
    UI_PushScreen("QuestInfo");
  }
  else
  {
    // The quest will handle this case.
  }*/
}
