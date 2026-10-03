Include("ui/scripts/ui-transitions.nut");

local timer = 0;

function OnLoad()
{
}

function OnEnter()
{
  timer = 0;
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  UI_SetProperty ("Title", "textbox.text", LocalizeText("Machine Gun Turret"));
  UI_SetProperty ("Desc", "textbox.text", LocalizeText("Machine Gun Turret"));
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}

function OnLeave()
{
}

function OnClick(name)
{
  OnBackAction();
}

function OnBackAction()
{
  UI_PopScreen("CreatureIntro");
}

function OnUpdate(tdelta)
{
  timer += 0.3 * tdelta;
    UpdateUITransition("fader", "panel");
  UI_SetProperty("panel", "angle_offset.x", 0.2 * cos(timer));
  UI_SetProperty("panel", "angle_offset.y", 0.2 * sin(timer));
  
}

function OnDraw()
{
}
