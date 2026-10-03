// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-capernaum-shortcut.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function OnInteraction (container, same) {
  if (this.rawin ("Mod_CapernaumShortcut_OnCreate_SuburbCargoContainer") == true) Mod_CapernaumShortcut_OnCreate_SuburbCargoContainer (container, same);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
