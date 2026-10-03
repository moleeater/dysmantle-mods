// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-ark-single-deposit.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function OnInteractionStarted(so_self, so_activator)
{
  Actor_PlayAnimation(so_self, "open");
}

function OnInteractionCancelled(so_self, so_activator)
{
  Actor_PlayAnimation(so_self, "close");
}

function GetNumberOfMaterialDeposited(material_id)
{
  return Game_GetWorldStateAsInteger("ARK_MATERIALS", material_id, 0);
}

function IncreaseStored(material_id, amount)
{
  local total_amount = GetNumberOfMaterialDeposited(material_id) + amount;
  Game_SetWorldState("ARK_MATERIALS", material_id, total_amount.tostring());
}

function IsCompleted(so_self, material_id)
{
  local total_amount = GetNumberOfMaterialDeposited(material_id);
  local required = StageObject_GetKeyValue(so_self, "required_amount");
  return total_amount >= required;
}

function GetStatueActor(so_self)
{
  local at = "actors/interactives/ark-collection-statue-leader.xml";
  local pos = StageObject_GetStagePosition(so_self);
  local actor = Stage_QueryNearestActorWithType(pos[0], pos[1], pos[2], 500, at);
  return actor;
}

function CheckCompletion(so_self)
{
  local actor = GetStatueActor(so_self);
  Actor_InteractWithInteraction(actor, actor, "check_completion");
}

function GetAmountToDeposit(so_self, material_id)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_ArkSingleDeposit_GetAmountToDeposit_ArkMaterialContainer") == true) {
    local ret = Mod_ArkSingleDeposit_GetAmountToDeposit_ArkMaterialContainer (so_self, material_id);
    if (ret != null) return ret;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  // The 'update' and 'deposit' interaction definitions of this need to match!
  local num_deposited = Game_GetWorldStateAsInteger("ARK_MATERIALS", material_id, 0);
  local num_required = StageObject_GetKeyValue(so_self, "required_amount");
  local num_times_deposited = StageObject_GetKeyValue(so_self, "num_times_deposited");
  local num_to_deposit = 10 * pow(2, num_times_deposited);
  if (num_deposited + num_to_deposit > num_required)
  {
    num_to_deposit = num_required - num_deposited;
  }
  return num_to_deposit;
}

function OnInteraction(so_self, so_activator)
{
  local material_id = StageObject_GetKeyValue(so_self, "material_id");
  if (material_id == null || material_id == "")
    return;

  local num_to_deposit = GetAmountToDeposit(so_self, material_id);

  local material_list = "" + num_to_deposit + "x" + material_id;
  if (Game_ThrowMaterialsToActorFromStorage(so_activator, so_self, material_list))
  {
    local num_times_deposited = StageObject_GetKeyValue(so_self, "num_times_deposited");
    StageObject_SetKeyValueInteger(so_self, "num_times_deposited", num_times_deposited+1);

    IncreaseStored(material_id, num_to_deposit);
    Actor_InteractWithInteraction(so_self, so_activator, "update");
    local xp_reward = StageObject_GetKeyValue(so_self, "xp_reward_per_material");
    Game_AddExperiencePoints(xp_reward * num_to_deposit);

    if (IsCompleted(so_self, material_id))
    {
      CheckCompletion(so_self);
    }
    else
    {
      local statue = GetStatueActor(so_self);
      //Game_RemoveAllActorNotificationsForActor(statue, true);
      local number = GetNumberOfMaterialDeposited(material_id);
      local text = LOC_TEXT("[NUMBER] samples deposited.");
      text = string_replace(text, "[NUMBER]", number.tostring());
      local n = Game_AddActorNotificationWithDynamicNumberVoiceover(statue, text,
        "", number, "sfx/ark/SAMPLES_DEPOSITED_POST");
    }
  }
  else
  {
    Game_AddActorNotification(so_activator, LOC_TEXT("I don't have enough in the [ORANGE]Storage Box[WHITE]."));
  }
  Actor_PlayAnimation(so_self, "close");
}
