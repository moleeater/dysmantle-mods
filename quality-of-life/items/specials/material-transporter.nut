// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-save-material-transporter.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


local owner_handle = 0;
local item_id = null;

function OnMetadataRead()
{
  local info = {
    name = "Material Transporter"
    description = "Instantly transports all carried materials to the [ORANGE]Camp Storage Box[WHITE]."
    use_description = "Start transport"
    number_of_uses = 1
    additional_uses_per_upgrade_level = 1
    destroy_after_owner_death = true
  };

  return info;
}

function OnInitialize(so_handle_owner, id)
{
  owner_handle = so_handle_owner;
  item_id = id;
  return true;
}

function OnTriggerDown()
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_SaveMaterialTransporter_OnTriggerDown_MaterialTransporter") == true) {
    local ret = Mod_SaveMaterialTransporter_OnTriggerDown_MaterialTransporter (owner_handle);
    if (ret == true) return;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Game_UseItem(owner_handle, item_id);
  Actor_QueueActionPlayAnimationWithParameters(owner_handle, "activate_material_transporter", 1, 0, true);
}

function OnCommandWord(id, kvs)
{
  if (id == "trigger_special_item")
  {
    local command = Command_Create("store_materials");
    Command_SetStageObjectReference(command, owner_handle);
    Stage_SendStageObjectCommandWithDelete(owner_handle, command);
  }
}
