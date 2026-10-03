// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-wiki.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function OnEnter() {
  if (this.rawin ("Mod_Wiki_OnEnter_UI") == true) Mod_Wiki_OnEnter_UI();
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function GetStackDepthOffset ()
{
  local this_screen = UI_GetActiveScreenName();
  
  local depth_offset = 0;
  local num_screens = UI_GetNumberOfScreensInStack();
  for (local i = 0; i < num_screens; i++)
    {
    local name = UI_PeekScreen(i);
    if (name == this_screen)
        {
      return depth_offset;
    }
    if (!(name == "TimelineTransition" || name == "Transition"))
        {
      depth_offset = depth_offset + m_smooth01f(UI_GetScreenTransitionPhase(name));
    }
  }
  
  return depth_offset;
}

function OnUpdate(tdelta)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_Wiki_OnUpdate_UI") == true) Mod_Wiki_OnUpdate_UI (tdelta);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  local pure_trans = UI_GetScreenTransitionPhase();
  local trans = sin(0.5*PI * pure_trans);

  local stack_depth_offset = GetStackDepthOffset ();
  local scale_mul = 1 - 0.1 * stack_depth_offset;

    local alpha_offset = 0.3;
  UI_SetProperty("panel", "alpha", m_clamp01f((pure_trans-alpha_offset)/(1-alpha_offset)) - 0.2 * stack_depth_offset);
  UI_SetProperty("panel", "scale_multiplier", scale_mul - 0.1*(1-trans));
  UI_SetProperty("fader", "alpha", trans);
  UI_SetProperty("panel", "angle_offset.x", -PI/2 * (1-trans));
}


// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
//function OnLoad() {}
//function OnScreenMessage (key, value) {}
//function OnDraw() {}
//function OnClick(name) {}
//function OnBackAction() {}
//function OnLeave() {}
//function OnDrawComp (component_name) {}
//function OnCustomEvent (event) {}
//function OnUpdateLocalizations() {}
//function OnCursorEnter (component_name) {}
//function OnCursorOverEntersComponent (component_name) {}
//function OnLongPress (component_name) {}
//function OnDoubleClick (component_name) {}
//function OnKeyDown (scancode) {}
//function OnKeyUp (scancode) {}
//function OnMouseDown (x, y, scancode, unknown) {}
//function OnMouseUp (x, y, scancode, unknown) {}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
