// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mods-changelog.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Include("ui/scripts/ui-transitions.nut");


UI_SetKeepVirtualMachineInMemory(true);


local akey = 0;
local timer = 0;
local scrolled = false;


function OnLoad()
{
}


function OnEnter()
{
  UI_SetProperty("Version", "textbox.text", NX_GetProgramVersionString());
  UI_SetProperty("TF", "touchfield.value_y", 0);
  UI_SetProperty("TF_upper", "touchfield.value_x", 0);
  akey = 0;
  timer = 0;
  scrolled = false;
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mods_Changelog_OnEnter_VersionNotes") == true) Mods_Changelog_OnEnter_VersionNotes();
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
  akey += tdelta;
  UI_SetProperty("FingerPoint", "position_offset.y", 0.2*cos(7*akey));
  
  timer += tdelta;
  if (timer > 0.3 && !scrolled)
  {
    scrolled = true;
    local pos = UI_GetComponentPositionOnScreen("ProgressMarker");
    UI_ScrollTouchfieldToScreenPosition("TF_upper", pos[0], pos[1], 2);
  }
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
