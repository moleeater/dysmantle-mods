// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-bullet-time.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);

function OnMetadataRead() {
  local metadata = {};
  if (this.rawin ("Mod_BulletTime_OnMetadataRead_Item") == true) metadata = Mod_BulletTime_OnMetadataRead_Item();
  return metadata;
}

function OnTriggerDown() {
  if (this.rawin ("Mod_BulletTime_OnTriggerDown_Item") == true) Mod_BulletTime_OnTriggerDown_Item();
}

function OnTriggerCancel() {
  if (this.rawin ("Mod_BulletTime_OnTriggerCancel_Item") == true) Mod_BulletTime_OnTriggerCancel_Item();
}

function OnInitialize (player, item_id) {
  if (this.rawin ("Mod_BulletTime_OnInitialize_Item") == true) Mod_BulletTime_OnInitialize_Item (player, item_id);
  return true;
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
