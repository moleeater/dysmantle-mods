// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mods-by-moleeater.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);

Include ("ui/scripts/ui-transitions.nut");


function OnScreenMessage (key, value) {
  if (this.rawin ("Mods_by_MoleEater_OnScreenMessage_Cheats") == true) Mods_by_MoleEater_OnScreenMessage_Cheats (key, value);
}


function OnEnter() {
  if (this.rawin ("Mods_by_MoleEater_OnEnter_Cheats") == true) Mods_by_MoleEater_OnEnter_Cheats();
}


function OnClick (clicked) {
  if (this.rawin ("Mods_by_MoleEater_OnClick_Cheats") == true) Mods_by_MoleEater_OnClick_Cheats (clicked);
}


function OnLeave() {
  if (this.rawin ("Mods_by_MoleEater_OnLeave_Cheats") == true) Mods_by_MoleEater_OnLeave_Cheats();
}


function OnUpdate (tdelta) {
  UpdateUITransition ("fader", "panel");
}


function OnLoad() {}
//function OnDraw() {}
function OnBackAction() {}
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
