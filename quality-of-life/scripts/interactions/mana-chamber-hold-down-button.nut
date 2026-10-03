// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-fix-from-storage.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function IsInteractionAvailable(so_self, so_activator)
{
  local num_investigated = Game_GetWorldStateAsInteger("MANA_CHAMBERS", "num_investigated", 0);
  local powered = StageObject_GetKeyValue(so_self, "powered", false);

  //Debug
  //num_investigated = 2;

  if(Game_IsManaChamberActive())
    return false;

  return num_investigated >= 1 && !powered && !Game_IsShowingActorNotification(so_activator);
}


function OnInteraction(so_self, so_activator)
{
  local cost = StageObject_GetKeyValue(so_self, "cost");

// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  local mod_fix_from_storage_is_done = false;
  if (this.rawin ("Mod_FixFromStorage_HoldDownButton_ManaChamber") == true) {
    local ret = Mod_FixFromStorage_HoldDownButton_ManaChamber (so_self, so_activator, cost);
    if (ret != null) mod_fix_from_storage_is_done = ret;
  }
  if (mod_fix_from_storage_is_done == true || Game_ThrowMaterialsToActor(so_activator, so_self, cost))
  {
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    //debug. omment these lines
    local quest_id = "quests/mana-chamber-intro.nut";
    Game_SendQuestPhaseCommandWord(quest_id, "PHASE_ACTIVATE", "activate");

    StageObject_SetKeyValueBoolean(so_self, "powered", true);
    Actor_PlayAnimation(so_self, "powered");
    //Actor_SetInteractionEnabled(so_self, "power", false);
    //Actor_SetInteractionText(so_self, "cooldown", "Override Cooldown")
  }
  else
  {
    local text = LOC_TEXT("I should return with [REQUIRED_MATERIALS].");
    local cost = StageObject_GetKeyValue(so_self, "cost");

    local required_materials_text = "";
    local substrings = split(cost, "x, ");
    foreach (str in substrings)
    {
      if (str.len() <= 2)
      {
        required_materials_text += str + "x";
      }
      else
      {
        required_materials_text += "[MATERIAL_ICON=" + str + "]  ";
      }
    }
    rstrip(required_materials_text);

    text = string_replace(text, "[REQUIRED_MATERIALS]", Game_GetConvertedString(required_materials_text));
    Game_AddActorNotification(so_activator, text);
  }
}
