// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-rift-forwards.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);

function OnMetadataRead() {
  local metadata = {};
  if (this.rawin ("Mod_RiftForwards_OnMetadataRead_Item") == true) metadata = Mod_RiftForwards_OnMetadataRead_Item();
  return metadata;
}

function OnTriggerDown() {
  if (this.rawin ("Mod_RiftForwards_OnTriggerDown_Item") == true) Mod_RiftForwards_OnTriggerDown_Item();
}

function OnTriggerHoldDown() {
  if (this.rawin ("Mod_RiftForwards_OnTriggerHoldDown_Item") == true) Mod_RiftForwards_OnTriggerHoldDown_Item();
}

function OnTriggerClick() {
  if (this.rawin ("Mod_RiftForwards_OnTriggerClick_Item") == true) Mod_RiftForwards_OnTriggerClick_Item();
}

function OnTriggerCancel() {
  if (this.rawin ("Mod_RiftForwards_OnTriggerCancel_Item") == true) Mod_RiftForwards_OnTriggerCancel_Item();
}

function OnUpdate (tdelta) {
  if (this.rawin ("Mod_RiftForwards_OnUpdate_Item") == true) Mod_RiftForwards_OnUpdate_Item (tdelta);
}

function OnTriggerUp() {
  if (this.rawin ("Mod_RiftForwards_OnTriggerUp_Item") == true) Mod_RiftForwards_OnTriggerUp_Item();
}

function OnInitialize (player, item_id) {
  if (this.rawin ("Mod_RiftForwards_OnInitialize_Item") == true) Mod_RiftForwards_OnInitialize_Item (player, item_id);
  return true;
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
