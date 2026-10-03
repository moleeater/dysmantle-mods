// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
if (NX_FileExists ("actors/collectibles/tarot.xml") || NX_FileExists ("scripts/interactions/tarot.nut") || NX_FileExists ("ui/tarot_templates.xml")
|| NX_FileExists ("ui/collectibles/tarotcard.nut") || NX_FileExists ("ui/collectibles/tarotcard.xml")
|| NX_FileExists ("actors/interactives/farming-mushroom_brown.xml") || NX_FileExists ("docs://Mega Quality Of Life Balance Mod/mod-info.xml")
|| NX_FileExists ("ugc://3711913031/mod-info.xml") || NX_FileExists ("ugc://3703339560/mod-info.xml")) return null;


local mods_include_path = "";
mods_include_path = "scripts/mods/mods-by-moleeater.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);

Include ("ui/scripts/ui-transitions.nut");


function OnEnter() {
  if (this.rawin ("Mods_by_MoleEater_OnEnter_MainMenu") == true) Mods_by_MoleEater_OnEnter_MainMenu();
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
