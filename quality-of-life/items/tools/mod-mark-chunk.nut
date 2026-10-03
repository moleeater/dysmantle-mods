// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-mark-chunk.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);

function OnMetadataRead() {
  local metadata = {};
  if (this.rawin ("Mod_MarkChunk_OnMetadataRead_Tool") == true) metadata = Mod_MarkChunk_OnMetadataRead_Tool();
  return metadata;
}

function IsPossibleToUse() {
  local is_possible = false;
  if (this.rawin ("Mod_MarkChunk_IsPossibleToUse_Item") == true) is_possible = Mod_MarkChunk_IsPossibleToUse_Item();
  return is_possible;
}

function OnTriggerClick() {
  if (this.rawin ("Mod_MarkChunk_OnTriggerClick_Item") == true) Mod_MarkChunk_OnTriggerClick_Item();
}

function OnTriggerHoldDown() {
  if (this.rawin ("Mod_MarkChunk_OnTriggerHoldDown_Item") == true) Mod_MarkChunk_OnTriggerHoldDown_Item();
}

function OnInitialize (player, item_id) {
  if (this.rawin ("Mod_MarkChunk_OnInitialize_Item") == true) Mod_MarkChunk_OnInitialize_Item (player, item_id);
  return true;
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
