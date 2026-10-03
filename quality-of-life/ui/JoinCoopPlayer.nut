// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-wiki.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Include ("ui/scripts/ui-transitions.nut");


function OnLoad()
{
}


function OnEnter()
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_Wiki_OnEnter_UI") == true) Mod_Wiki_OnEnter_UI();
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}


function OnLeave()
{
}


function OnClick(name)
{
}


function OnBackAction()
{
  UI_PopScreen();
}


function OnUpdate(tdelta)
{
  UpdateUITransition("fader", "panel");
}


function OnDraw()
{
}


// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function OnScreenMessage (key, value) {}
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
