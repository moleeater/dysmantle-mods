// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
if (NX_FileExists ("actors/collectibles/tarot.xml") || NX_FileExists ("scripts/interactions/tarot.nut") || NX_FileExists ("ui/tarot_templates.xml")
|| NX_FileExists ("ui/collectibles/tarotcard.nut") || NX_FileExists ("ui/collectibles/tarotcard.xml")
|| NX_FileExists ("actors/interactives/farming-mushroom_brown.xml") || NX_FileExists ("docs://Mega Quality Of Life Balance Mod/mod-info.xml")
|| NX_FileExists ("ugc://3711913031/mod-info.xml") || NX_FileExists ("ugc://3703339560/mod-info.xml")) return null;


local mods_include_path = "";
mods_include_path = "scripts/mods/mods-changelog.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mods-controller.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mods-by-moleeater.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Include ("ui/scripts/ui-transitions.nut");


function OnLoad()
{
}


function OnEnter()
{
  local stage_in_stack = UI_IsScreenInStack ("Stage");
  UI_SetProperty ("EditVirtualControls", "active", stage_in_stack);
  UI_SetVisible ("EditVirtualControlsHint", !stage_in_stack);
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mods_Changelog_OnEnter_OptionsUnified") == true) Mods_Changelog_OnEnter_OptionsUnified (stage_in_stack);
  if (this.rawin ("Mods_by_MoleEater_OnEnter_OptionsUnified") == true) Mods_by_MoleEater_OnEnter_OptionsUnified (stage_in_stack);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}


function OnLeave()
{
}


function OnBackAction()
{
}


function OnClick(name)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mods_Changelog_OnClick_OptionsUnified") == true) Mods_Changelog_OnClick_OptionsUnified (name);
  if (this.rawin ("Mods_by_MoleEater_OnClick_OptionsUnified") == true) Mods_by_MoleEater_OnClick_OptionsUnified (name);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}


function OnUpdate(tdelta)
{
  UpdateUITransition ("fader", "panel");
  UI_SetProperty ("EmojiExample", "textbox.text", Game_GetConvertedString (LOC_TEXT("Example: I'm thinking [EMOJI=thinking face]")));
}


function OnDraw()
{
}


// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function OnScreenMessage (key, value) {
  if (this.rawin ("Mods_Controller_OnScreenMessage_OptionsUnified") == true) Mods_Controller_OnScreenMessage_OptionsUnified (key, value);
  if (this.rawin ("Mods_by_MoleEater_OnScreenMessage_OptionsUnified") == true) Mods_by_MoleEater_OnScreenMessage_OptionsUnified (key, value);
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
