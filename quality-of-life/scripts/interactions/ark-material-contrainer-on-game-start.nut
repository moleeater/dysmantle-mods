// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-ark-single-deposit.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-walkable-ark.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


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

  local num_deposited = 0;
  local amount_str = Game_GetWorldState("ARK_MATERIALS", material_id);
  if (amount_str != null)
    num_deposited = amount_str.tointeger();

  // This needs to match the 'deposit' interaction num_to_deposit definition.
  local num_required = StageObject_GetKeyValue(so_self, "required_amount");
  local num_to_deposit = GetAmountToDeposit(so_self, material_id);

  if (num_to_deposit > 0)
  {
    local deposit_str = LOC_TEXT("Deposit [AMOUNT]");
    deposit_str = string_replace(deposit_str, "[AMOUNT]",
      num_to_deposit.tostring() + " [MATERIAL_ICON=" + material_id + "]" +
      "[MATERIAL_NAME=" + material_id + "]");

    local in_storage = Game_GetNumberOfMaterialsInStorage(material_id);
    local storage_str = LOC_TEXT("[AMOUNT] in storage");
    //storage_str = string_replace(storage_str, "[AMOUNT]", "[MATERIAL_ICON=" + material_id + "]" + in_storage);
    storage_str = string_replace(storage_str, "[AMOUNT]", "" + in_storage);

    local text = deposit_str + " " + "(" + storage_str + ")";

    if (Stage_IsGameStarted())
      Actor_SetInteractionText(so_self, "deposit", Game_GetConvertedString(text));
  }


  if (num_deposited >= num_required)
  {
    if (!Actor_IsAnimationPlaying(so_self, "completed"))
    {
      if (Stage_IsGameStarted())
        Actor_PlayAnimation(so_self, "completed");
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
      else if (!Stage_IsStageEditorOpen()) {
        Actor_PlayAnimationWithDelayPlaybackSpeedAndPosition(so_self, "completed", 0, 1, 1, 1);
        if (this.rawin ("Mod_WalkableArk_OnGameStart_ArkMaterialContainer") == true) Mod_WalkableArk_OnGameStart_ArkMaterialContainer (so_self, so_activator);
      }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    }
    Actor_SetInteractionEnabled(so_self, "deposit", false);
  }
  else
  {
    Actor_PlayAnimationWithDelayPlaybackSpeedAndPosition(so_self, "close", 0, 1, 1, 1);
  }

  local kvs = Actor_GetPropActorKeyValueStore(so_self, "text");
  if (Stage_IsStageEditorOpen())
    num_deposited = 0;
  local screen_number = num_required - num_deposited;
  KeyValueStore_SetKeyValueString(kvs, "text_not_localized", "|#11ff11|" + screen_number.tostring());
}
