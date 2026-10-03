// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-mark-chunk.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function OnInteraction (perm_mark, same) {
  if (this.rawin ("Mod_MarkChunk_OnDeathStart_PermanentMark") == true) Mod_MarkChunk_OnDeathStart_PermanentMark (perm_mark, same);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
