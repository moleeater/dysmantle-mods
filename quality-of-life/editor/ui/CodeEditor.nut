// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mods-by-moleeater.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-wiki.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);

Include ("ui/scripts/ui-transitions.nut");


function OnEnter() {
  if (this.rawin ("Mods_by_MoleEater_OnEnter_CodeEditor") == true) Mods_by_MoleEater_OnEnter_CodeEditor();
  if (this.rawin ("Mod_Wiki_OnEnter_UI") == true) Mod_Wiki_OnEnter_UI();
}


function OnUpdate (tdelta) {
  UpdateUITransition("fader", "panel");
}


function OnLoad() {}
function OnScreenMessage (key, value) {}
//function OnDraw() {}
function OnClick(name) {}
function OnBackAction() {}
function OnLeave() {}
//function OnDrawComp (component_name) {}
//function OnCustomEvent (event) {}
function OnUpdateLocalizations() {}
function OnCursorEnter (component_name) {}
//function OnCursorOverEntersComponent (component_name) {}
function OnLongPress (component_name) {}
function OnDoubleClick (component_name) {}
function OnKeyDown (scancode) {}
function OnKeyUp (scancode) {}
function OnMouseDown (x, y, scancode, unknown) {}
function OnMouseUp (x, y, scancode, unknown) {}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
