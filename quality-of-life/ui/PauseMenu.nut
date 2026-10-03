// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
if (NX_FileExists ("actors/collectibles/tarot.xml") || NX_FileExists ("scripts/interactions/tarot.nut") || NX_FileExists ("ui/tarot_templates.xml")
|| NX_FileExists ("ui/collectibles/tarotcard.nut") || NX_FileExists ("ui/collectibles/tarotcard.xml")
|| NX_FileExists ("actors/interactives/farming-mushroom_brown.xml") || NX_FileExists ("docs://Mega Quality Of Life Balance Mod/mod-info.xml")
|| NX_FileExists ("ugc://3711913031/mod-info.xml") || NX_FileExists ("ugc://3703339560/mod-info.xml")) return null;


local mods_include_path = "";
mods_include_path = "scripts/mods/mods-by-moleeater.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-wiki.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function OnLoad()
{
}


function OnEnter()
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mods_by_MoleEater_OnEnter_PauseMenu") == true) Mods_by_MoleEater_OnEnter_PauseMenu();
  if (this.rawin ("Mod_Wiki_OnEnter_UI") == true) Mod_Wiki_OnEnter_UI();
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}


function OnLeave()
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mods_by_MoleEater_OnLeave_PauseMenu") == true) Mods_by_MoleEater_OnLeave_PauseMenu();
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}


function OnClick(name)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mods_by_MoleEater_OnClick_PauseMenu") == true) Mods_by_MoleEater_OnClick_PauseMenu (name);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}


function UpdateUITransitionSimple (fader, panel) {
  local pure_trans = UI_GetScreenTransitionPhase();
  local trans = sin(0.5*PI * pure_trans);
  local alpha_offset = 0.3;
  UI_SetProperty(panel, "alpha", m_clamp01f((pure_trans-alpha_offset)/(1-alpha_offset)) - 0.2 * 0);
  UI_SetProperty(fader, "alpha", m_clamp01f(2*pure_trans));
  // Make the background less bright during transition.
  local c = m_clamp01f(0.1+pure_trans);
  UI_SetProperty(fader, "color", c,c,c,1);
}


function OnUpdate(tdelta)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mods_by_MoleEater_OnUpdate_PauseMenu") == true) Mods_by_MoleEater_OnUpdate_PauseMenu (tdelta);
  if (this.rawin ("Mod_Wiki_OnUpdate_UI") == true) Mod_Wiki_OnUpdate_UI (tdelta);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  UpdateUITransitionSimple ("fader", "panel");
}


function OnDraw()
{
}


function OnBackAction()
{
}


// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function OnScreenMessage (key, value) {
  if (this.rawin ("Mods_by_MoleEater_OnScreenMessage_PauseMenu") == true) Mods_by_MoleEater_OnScreenMessage_PauseMenu (key, value);
}


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
