// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mods-by-moleeater.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);

Include ("ui/scripts/ui-transitions.nut");


function OnScreenMessage (key, value) {
  if (this.rawin ("Mods_by_MoleEater_OnScreenMessage_Refiner") == true) Mods_by_MoleEater_OnScreenMessage_Refiner (key, value);
}


function OnClick (clicked) {
  if (this.rawin ("Mods_by_MoleEater_OnClick_Refiner") == true) Mods_by_MoleEater_OnClick_Refiner (clicked);
}


function OnUpdate (tdelta) {
  UpdateUITransition("fader", "panel");
  UI_SetProperty("fader2", "alpha", UI_GetScreenTransitionPhase());
  if (this.rawin ("Mods_by_MoleEater_OnUpdate_Refiner") == true) Mods_by_MoleEater_OnUpdate_Refiner (tdelta);
}


function OnEnter() {
  if (this.rawin ("Mods_by_MoleEater_OnEnter_Refiner") == true) Mods_by_MoleEater_OnEnter_Refiner();
}


function OnLoad() {}
//function OnDraw() {}
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
