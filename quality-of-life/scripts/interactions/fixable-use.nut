// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-fix-from-storage.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function GetMetadata()
{
  local data =
  {
    id = "fix"
    enabled = true
    interaction_text = ""
    //interaction_radius = 80
    trigger_type = "PRESS_BUTTON"
    controller_button = "USE"
  };
  return data;
}

function IsInteractionAvailable(so_self, so_activator)
{


  return !Game_IsStoringMaterials();


}

function OnInteraction(so_self, so_activator)
{

  if (Actor_IsAnimationPlaying(so_activator, "pet_animal"))
  {
     return;
  }


  if (Game_IsStoringMaterials())
  {
    return;
  }

  local required_materials = StageObject_GetKeyValue(so_self, "required_materials");

  if (required_materials)
  {
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    local mod_fix_from_storage_required_materials = required_materials;
    if (this.rawin ("Mod_FixFromStorage_PressButtonUse_Fixable") == true) {
      local ret = Mod_FixFromStorage_PressButtonUse_Fixable (so_self, so_activator, mod_fix_from_storage_required_materials);
      if (ret != null) mod_fix_from_storage_required_materials = ret;
    }
    local materials_left = Game_ThrowMaterialsToActorPartially (so_activator, so_self, mod_fix_from_storage_required_materials);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    StageObject_SetKeyValueString(so_self, "required_materials", materials_left);
    local did_deposit_some_materials = materials_left != required_materials;

    if (did_deposit_some_materials)
    {
      local text = LOC_TEXT("Fix") + " (";
      local substrings = split(materials_left, "x, ");
      foreach (str in substrings)
      {
        if (str.len() <= 2)
        {
          text += str + "x";
        }
        else
        {
          text += "[MATERIAL_ICON=" + str + "]  ";
        }
      }
      rstrip(text);
      text += ")";
      Actor_SetInteractionText(so_self, "fix", Game_GetConvertedString(text));
    }

    required_materials = materials_left;
    if (materials_left == "")
    {
      local id = StageObject_GetId(so_self);
      if (id == null)
      {
        NX_Popup("Fixable needs to have some id set!");
        id = "UNKNOWN_FIXABLE";
      }
      Game_SetWorldState("FIXABLES", id, "1");
      Actor_SetInteractionEnabled(so_self, "fix", false);

      if (StageObject_HasTag(so_self, "LINK_TOWER"))
      {
        Actor_PlayAnimation(so_self, "inactive");
        Actor_SetInteractionEnabled(so_self, "activate", true);
      }
      else
      {
        Game_SetStagePointOfInterestCompleted(so_self);
      }

      Game_LogEvent("FIXABLE_FIXED");
      local related_quest = StageObject_GetKeyValue(so_self, "related_quest");
      if (related_quest != null)
        Game_SendQuestCommandWord(related_quest, "activate");

      Actor_ClearActionQueue(so_activator);

      if (!Actor_HasActorFlag(so_self, "SOLID"))
      {
        local script = string_replace("Actor_SetActorFlag($so_self, \"SOLID\", true);", "$so_self", so_self.tointeger());
        Actor_QueueActionRunScript(so_activator, format("StageObject_AddTag(%d, \"IGNORE_SMALL_COLLISIONS\");", so_activator));
        Actor_QueueActionMoveToDistanceFromActor(so_activator, so_self, 220);
        Actor_QueueActionRunScript(so_activator, format("StageObject_RemoveTag(%d, \"IGNORE_SMALL_COLLISIONS\");", so_activator));
        Actor_QueueActionRunScript(so_activator, script);
        Actor_QueueActionSendCommandWord(so_activator, so_self, "update_path_planning");
      }
      Actor_StopAnimationWithFade(so_self, "broken", 0);
      Actor_PlayAnimation(so_self, "fixing");
      //Actor_QueueActionClearQueue(so_activator, so_activator);
    }
    else
    {
      local materials = string_replace(required_materials, "x", "x[MATERIAL_ICON=");
      materials = string_replace(materials, ",", "] ") + "]";
      local text = null;
      if (did_deposit_some_materials)
      {
        text = LOC_TEXT("I still need [REQUIRED_MATERIALS] more.");
      }
      else
      {
        Actor_PlayAnimation(so_activator, "not_here");
        if (Game_IsShowingActorNotification(so_activator))
          return;

        local kvs = ActorType_GetKeyValueStore(Actor_GetActorType(so_self));

        local times_tried = StageObject_GetKeyValue(so_self, "times_tried");
        if (times_tried == null)
          times_tried = 0;

        local options = [];
        for (local i = 0; i < 10; i++)
        {
          local no_materials_text = KeyValueStore_GetKeyValue(kvs, "no_materials_text_" + i);
          if (no_materials_text == null)
            break;
          options.append(LocalizeText(no_materials_text));
        }

        if (options.len() > 0)
        {
          times_tried = times_tried%options.len();
          text = options[times_tried];
          times_tried = (times_tried+1)%options.len();
        }
        StageObject_SetKeyValueInteger(so_self, "times_tried", times_tried);

        if (text == null)
          text = LOC_TEXT("I should return with [REQUIRED_MATERIALS].");
      }
      text = string_replace(text, "[REQUIRED_MATERIALS]", materials);
      Game_AddActorNotification(so_activator, text);
      Actor_InteractWithInteraction(so_self, so_self, "init");
    }
  }
}
