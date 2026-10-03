// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-starting-stage.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function IsInteractionAvailable(so_self, so_activator)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_StartingStage_HoldDownButtonIsInteractionAvailable_ManaRiftTeleport") == true) {
    local ret = Mod_StartingStage_HoldDownButtonIsInteractionAvailable_ManaRiftTeleport (so_self, so_activator);
    if (ret != null) return ret;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  if (Game_GetWorldStateAsInteger("MANA_RIFTS", "enabled") == 0)
    return false;

  local req_quest = StageObject_GetKeyValue (so_self,"required_quest_id");
  local req_phase = StageObject_GetKeyValue (so_self,"required_quest_phase_id");

  if (req_quest != null && req_phase != null)
  {
    if(!Game_IsQuestPhaseCompleted(req_quest, req_phase))
      return false;
  }

  return !StageObject_GetKeyValue(so_self, "open");
}


function OnInteraction(so_self, so_activator)
{
  if (StageObject_GetKeyValue(so_self, "open"))
    return;

  if (!Game_IsRecipeCrafted("RIFT_TOOLKIT"))
  {
    Game_SetRecipeUnlocked("RIFT_TOOLKIT", true, true);
    local text = LOC_TEXT("I need to craft [RECIPE].");
    text = string_replace(text, "[RECIPE]", "[GREEN][RECIPE_NAME=RIFT_TOOLKIT][WHITE]");
    Game_AddActorNotification(so_activator, text);
    return;
  }

  local open_cost = StageObject_GetKeyValue(so_self, "open_cost");
  if (open_cost == null)
    open_cost = "1";

  local materials = "" + open_cost + "xMANA_CHUNK";
  if (open_cost == 0 || Game_ThrowMaterialsToActorFromStorage(so_activator, so_self, materials))
  {
    local num_opened = Game_GetWorldStateAsInteger("MANA_RIFTS", "opened") + 1;
    Game_SetWorldState("MANA_RIFTS", "opened", num_opened.tostring());

    StageObject_SetKeyValueBoolean(so_self, "open", true);
    Actor_InteractWithInteraction(so_self, so_activator, "init");
    Actor_PlayAnimation(so_self, "open");
    //Game_SetStagePointOfInterestCompleted(so_self);
  }
  else
  {
    local text = LOC_TEXT("I don't have enough [MATERIALS] in storage.");
    text = string_replace(text, "[MATERIALS]", "[MATERIAL_ICON=MANA_CHUNK][MATERIAL_NAME=MANA_CHUNK]");
    Game_AddActorNotification(so_activator, text);
  }
}
