// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-extract-barrier.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function OnActorEntersRadius (recorder, player) {
  if (this.rawin ("Mod_ExtractBarrier_OnActorEntersRadius_TapeRecorder") == true) Mod_ExtractBarrier_OnActorEntersRadius_TapeRecorder (recorder, player);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
