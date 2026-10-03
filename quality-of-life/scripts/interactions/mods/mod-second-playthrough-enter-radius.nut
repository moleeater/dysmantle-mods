// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-second-playthrough.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function OnActorEntersRadius (radio, player) {
  if (this.rawin ("Mod_SecondPlaythrough_OnActorEntersRadius_Radio") == true) Mod_SecondPlaythrough_OnActorEntersRadius_Radio (radio, player);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
