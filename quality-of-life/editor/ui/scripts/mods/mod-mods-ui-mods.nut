// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-mods-ui.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);


function OnUpdate (tdelta) {
  if (this.rawin ("Mod_ModsUI_OnUpdate_Mods") == true) Mod_ModsUI_OnUpdate_Mods (tdelta);
}


function OnEnter() {}
function OnLeave() {}
function OnUpdateLocalizations() {}
//function OnDrawSelector (component_name) {}
//function OnDraw (alpha) {}
function OnCustomPropertySet (property_name, value) {}
function OnClick (clicked) {}
function OnKeyDown (scancode) {}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
