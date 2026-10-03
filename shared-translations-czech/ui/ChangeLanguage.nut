// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("ui/scripts/ui-transitions.nut");


function OnUpdate (tdelta) {
  if (UI_GetProperty ("SetLanguage_en", "name") == "SetLanguage_en") {
    local files = NX_FindFiles ("localizations", "info.xml", true);
    if (files != null && files.len() > 0) {
      foreach (file in files) {
        local lang = file.slice(14,-9);
        if (UI_GetProperty ("SetLanguage_" + lang, "name") == "SetLanguage_" + lang) {
          UI_SetProperty ("SetLanguage_" + lang, "button.icon_color", 1, 1, 1, 1);
          UI_SetProperty ("SetLanguage_" + lang, "button.bitmap_color_idle", 1, 1, 1, 0.4);
        }
      }
    }
  }
  UpdateUITransition("fader", "panel");
}


function OnLoad() {}
function OnEnter() {}
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
