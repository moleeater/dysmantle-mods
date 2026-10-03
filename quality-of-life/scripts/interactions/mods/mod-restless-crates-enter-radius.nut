// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-restless-crates.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function OnActorLeavesRadius (campfire, player) {
  if (this.rawin ("Mod_RestlessCrates_OnActorLeavesRadius_Campfire") == true) Mod_RestlessCrates_OnActorLeavesRadius_Campfire (campfire, player);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
