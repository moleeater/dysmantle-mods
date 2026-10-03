// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local throttle_realseconds = 0.5;
local action = {
    "name"      : "code_editor",
    "title"     : "Code editor",
    "desc"      : LocalizeText("Execute scripts with the help of a built-in code editor and documentation of the vanilla game.")
        + "\n\n" + LocalizeText("Available in the Pause Menu and by keypress."),
    "per_player": false,
  };
local last_time = null;


Include ("scripts/mods/mods-info.nut");
Include ("scripts/mods/mods-controller.nut");


function Mod_CodeEditor_OnUpdate_Stage (tdelta) {
  Mods_Controller_OnUpdate_Stage (action, tdelta);
  if (UI_IsScreenInStack ("CodeEditor") != true && UI_IsScreenInOverlayStack ("CodeEditor") != true
  && UI_GetActiveScreenName() == "Stage" && UI_PeekScreen() == "Stage") {
    local players = Mods_Controller_GetPlayers (action);
    if (players[0].player == null) {
      last_time = null;
    } else {
      local now = NX_GetTime();
      if (players[0].key_state != null && (last_time == null || last_time < now - throttle_realseconds.tofloat() * 1000.0)) {
        last_time = now;
        Game_SetWorldState ("MODS", "code_editor_used", "1");
        UI_SendScreenMessage ("CodeEditor", "LoadExternalFile", "user://my-script.nut");
        UI_PushScreen ("CodeEditor");
      }
    }
  }
}


function Mod_CodeEditor_OnEnter_Stage() {
  Mods_Controller_OnEnter_Stage (action);
}


function Mod_CodeEditor_OnEnter_CodeHelp() {
  if (UI_IsScreenInStack ("StageEditor") != true && UI_IsScreenInStack ("Stage") == true) {
    UI_SetProperty ("fader", "color", 0, 0, 0, 0.9);
    if (NX_ProductFeatureExists ("MOBILE_UI") == true) {
      UI_SetProperty ("panel", "scale", 1.7);
      UI_SetProperty ("panel", "position.y", 0.45);
      UI_SetProperty ("panel", "ninepatch.rectangle_height", 320);
      UI_SetProperty ("Filter", "position.y", -0.44);
      UI_SetProperty ("Values", "position.y", -0.39);
      UI_SetProperty ("Values", "listbox.content_height", 250);
      UI_SetProperty ("slider_1", "position.y", -0.39);
      UI_SetProperty ("slider_1", "slider.ninepatch_height", 250);
      UI_SetProperty ("aligner_1", "position.y", 0.44);
      UI_SetProperty ("ValueDescription", "textbox.textbox_width", 600);
      UI_SetProperty ("ValueDescription", "textbox.fit_inside_textbox", true);
    }
  }
}


function Mod_CodeEditor_OnEnter_CodeEditor() {
  UI_SetProperty ("mod_code_editor_help", "textbox.text", LocalizeText("Run:  Ctrl+B      Autocomplete:  Ctrl+Space      Find:  Ctrl+F      Scroll down:  Ctrl+Down      Reload:  Ctrl+R      Load:  Ctrl+L      Save:  Ctrl+S"));
  if (UI_IsScreenInStack ("StageEditor") != true && UI_IsScreenInStack ("Stage") == true) {
    UI_SetProperty ("fader", "color", 0, 0, 0, 0.95);
    if (NX_ProductFeatureExists ("MOBILE_UI") == true) {
      UI_SetProperty ("panel", "position.y", 0.47);
      UI_SetProperty ("panel", "ninepatch.rectangle_width", 1030);
      UI_SetProperty ("Search", "position.x", 0.1);
      UI_SetProperty ("Search", "editbox.ninepatch_width", 350);
      UI_SetProperty ("Search", "editbox.text_scale", 2);
      UI_SetProperty ("Close", "scale", 1.5);
      UI_SetProperty ("panel2", "ninepatch.rectangle_width", 995);
      UI_SetProperty ("CodeEdit", "codeeditor.area_width", 990);
      UI_SetProperty ("CodeEdit", "codeeditor.text_scale", 1.2);
      UI_SetProperty ("slider_2", "slider.ninepatch_width", 1000);
      UI_SetProperty ("aligner_syntax_SQUIRREL", "scale", 1.2);
      UI_SetProperty ("Operations", "scale", 1.2);
      UI_SetProperty ("KeywordHelp", "scale", 1.7);
      UI_SetProperty ("KeywordHelp", "textbox.textbox_width", 600);
      UI_SetProperty ("KeywordHelp", "textbox.fit_inside_textbox", true);
    }
  }
}


function Mod_CodeEditor_OnClick_PauseMenu (clicked) {
  if (clicked == "mod_code_editor") {
    Game_SetWorldState ("MODS", "code_editor_used", "1");
    UI_PopScreen ("PauseMenu");
    UI_SendScreenMessage ("CodeEditor", "LoadExternalFile", "user://my-script.nut");
    UI_PushScreen ("CodeEditor");
  }
}


function Mod_CodeEditor_OnEnter_PauseMenu() {
  UI_SetProperty ("mod_code_editor", "button.text", LocalizeText("CODE EDITOR"));
  if (Feature_ProductFeatureExists ("SHADEGROWN_DEVELOPMENT_ENVIRONMENT") == true) {
    UI_SetVisible ("marker_spacer3", false);
    UI_SetVisible ("mod_code_editor", true);
  }
}


function Mod_CodeEditor_OnClick_OptionsUnified (clicked) {
  Mods_Controller_OnClick_OptionsUnified (action, clicked);
}


function Mod_CodeEditor_OnEnter_OptionsUnified (stage_in_stack) {
  Mods_Controller_OnEnter_OptionsUnified (action, stage_in_stack);
  local is_devenv = Feature_ProductFeatureExists ("SHADEGROWN_DEVELOPMENT_ENVIRONMENT") == true ? true : false;
  UI_SetProperty ("mod_code_editor_error", "textbox.text", LocalizeText("Code editor mod needs SHADEGROWN_DEVELOPMENT_ENVIRONMENT in features line of prog.xml file"));
  UI_SetVisible ("mod_code_editor_error", is_devenv == true ? false : true);
  UI_SetVisible ("mod_code_editor_controller_title", is_devenv);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
