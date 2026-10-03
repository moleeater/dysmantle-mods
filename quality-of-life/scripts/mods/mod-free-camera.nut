// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local throttle_realseconds = 0.5;
local action = {
    "name"      : "free_camera",
    "title"     : "Free camera",
    "desc"      : LocalizeText("Move the main camera freely to take screenshots from any perspective."),
    "per_player": false,
  };
local last_time = null;


Include ("scripts/mods/mods-info.nut");
Include ("scripts/mods/mods-controller.nut");


function Mod_FreeCamera_OnUpdate_Stage (tdelta) {
  Mods_Controller_OnUpdate_Stage (action, tdelta);
  if (UI_IsScreenInStack ("PauseMenu") != true
  && UI_IsScreenInStack ("CodeEditor") != true && UI_IsScreenInOverlayStack ("CodeEditor") != true
  && UI_IsScreenInStack ("EditorFlyMode") != true && UI_IsScreenInOverlayStack ("EditorFlyMode") != true
  && UI_GetActiveScreenName() == "Stage" && UI_PeekScreen() == "Stage") {
    local players = Mods_Controller_GetPlayers (action);
    if (players[0].player == null) {
      last_time = null;
    } else {
      local now = NX_GetTime();
      if (players[0].key_state != null && (last_time == null || last_time < now - throttle_realseconds.tofloat() * 1000.0)) {
        last_time = now;
        UI_PushScreen ("EditorFlyMode");
      }
    }
  }
}


function Mod_FreeCamera_OnEnter_EditorFlyMode() {
  UI_SetProperty ("MessageText", "position.y", 0.6);
  UI_SetProperty ("MessageText", "shader_effect", "FontBlackShadowOutline");
  UI_SetProperty ("MessageText", "ui_scale_modifier", 0.3);
  UI_SetProperty ("MessageText", "textbox.text", LocalizeText("|img src='controller-art/wasdmouse/button-wasd.png' scale=0.28 offset=2|  move camera\nESC   exit\n|img src='controller-art/wasdmouse/button-space.png' scale=0.5 offset=2|  toggle game update"));
}


function Mod_FreeCamera_OnEnter_Stage() {
  Mods_Controller_OnEnter_Stage (action);
}


function Mod_FreeCamera_OnClick_OptionsUnified (clicked) {
  Mods_Controller_OnClick_OptionsUnified (action, clicked);
}


function Mod_FreeCamera_OnEnter_OptionsUnified (stage_in_stack) {
  Mods_Controller_OnEnter_OptionsUnified (action, stage_in_stack);
  local is_devenv = Feature_ProductFeatureExists ("SHADEGROWN_DEVELOPMENT_ENVIRONMENT") == true ? true : false;
  UI_SetProperty ("mod_free_camera_error", "textbox.text", LocalizeText("Free camera mod needs SHADEGROWN_DEVELOPMENT_ENVIRONMENT in features line of prog.xml file"));
  UI_SetVisible ("mod_free_camera_error", is_devenv == true ? false : true);
  UI_SetVisible ("mod_free_camera_controller_title", is_devenv);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
