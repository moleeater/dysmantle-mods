// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-confirm-pills.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


local owner_handle = 0;

function OnMetadataRead()
{
  local info = {
    name = "Amber Mana Pills"
    description = "Standard Island State issued pills infused with [BLUE]Mana[WHITE]."
    use_description = "Return to the last [ORANGE]Campfire[WHITE] you have rested at without losing any materials."
    use_description_long_press = "Return to the home shelter [ORANGE]Campfire[WHITE]."
    destroy_after_owner_death = true
  };

  return info;
}

function OnInitialize(so_handle_owner, item_id)
{
  owner_handle = so_handle_owner;
  return true;
}

// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function OnTriggerClick()
{
  if (this.rawin ("Mod_ConfirmPills_OnTriggerDown_AmberPills") == true) {
    return Mod_ConfirmPills_OnTriggerDown_AmberPills (owner_handle, false, "Amber Mana Pills", "|img src='items/specials/amber-mana-pills.png' scale=0.4 offset=2|");
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Actor_QueueActionPlayAnimationWithParameters(owner_handle, "eat", 1, 0, true);
  StageObject_SetKeyValueBoolean(owner_handle, "return_to_home_shelter_campfire", false);
}

function OnTriggerHoldDown()
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_ConfirmPills_OnTriggerDown_AmberPills") == true) {
    return Mod_ConfirmPills_OnTriggerDown_AmberPills (owner_handle, true, "Amber Mana Pills", "|img src='items/specials/amber-mana-pills.png' scale=0.4 offset=2|");
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Actor_QueueActionPlayAnimationWithParameters(owner_handle, "eat", 1, 0, true);
  StageObject_SetKeyValueBoolean(owner_handle, "return_to_home_shelter_campfire", true);
}

function OnCommandWord(id, kvs)
{
  if (id == "trigger_special_item")
  {
    Game_SetPlayerActorCauseOfDeath(owner_handle, "pills_with_mana");
    StageObject_SetKeyValueBoolean(owner_handle, "keep_materials_on_death", true);
    Stage_KillActorAndStartDeathAnimation(owner_handle, "die_of_heat");
  }
}
