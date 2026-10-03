// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-bioweapon.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);

function OnMetadataRead() {
  local metadata = {};
  if (this.rawin ("Mod_BioWeapon_OnMetadataRead_Item") == true) metadata = Mod_BioWeapon_OnMetadataRead_Item();
  return metadata;
}

function IsPossibleToUse() {
  local is_possible = false;
  if (this.rawin ("Mod_BioWeapon_IsPossibleToUse_Item") == true) is_possible = Mod_BioWeapon_IsPossibleToUse_Item();
  return is_possible;
}

function OnTriggerDown() {
  if (this.rawin ("Mod_BioWeapon_OnTriggerDown_Item") == true) Mod_BioWeapon_OnTriggerDown_Item();
}

function OnTriggerHoldDown() {
  if (this.rawin ("Mod_BioWeapon_OnTriggerHoldDown_Item") == true) Mod_BioWeapon_OnTriggerHoldDown_Item();
}

function OnTriggerCancel() {
  if (this.rawin ("Mod_BioWeapon_OnTriggerCancel_Item") == true) Mod_BioWeapon_OnTriggerCancel_Item();
}

function OnTriggerUp() {
  if (this.rawin ("Mod_BioWeapon_OnTriggerUp_Item") == true) Mod_BioWeapon_OnTriggerUp_Item();
}

function OnInitialize (player, item_id) {
  if (this.rawin ("Mod_BioWeapon_OnInitialize_Item") == true) Mod_BioWeapon_OnInitialize_Item (player, item_id);
  return true;
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
