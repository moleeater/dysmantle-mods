// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_EventLog_OnEnter_GameEventLog() {
  local is_modded = UI_IsScreenInStack ("StageEditor") == false && UI_IsScreenInStack ("PauseMenu") == true && UI_IsScreenInStack ("OptionsUnified") != true;
  UI_SetVisible ("panel4", is_modded ? false : true);
  if (is_modded) {
    UI_SetProperty ("LogName", "localize", false);
    UI_SetProperty ("LogName", "textbox.text", "Note that no events are logged if you're playing with developer mode enabled.");
    if (NX_ProductFeatureExists ("MOBILE_UI") == true) {
      UI_SetProperty ("panel", "scale", 1.3);
      UI_SetProperty ("panel", "ninepatch.rectangle_width", 800);
      UI_SetProperty ("panel", "ninepatch.rectangle_height", 480);
      UI_SetProperty ("LogName", "scale", 0.7);
      UI_SetProperty ("LogName", "position.x", -0.48);
      UI_SetProperty ("LogName", "position.y", -0.487);
      UI_SetProperty ("LogName", "textbox.textbox_width", 350);
      UI_SetProperty ("Title", "position.x", -0.11);
      UI_SetProperty ("Title", "position.y", -0.482);
      UI_SetProperty ("DrawHeatMap", "position.x", 0.09);
      UI_SetProperty ("DrawHeatMap", "position.y", -0.459);
      UI_SetProperty ("DrawEventIcons", "position.x", 0.27);
      UI_SetProperty ("DrawEventIcons", "position.y", -0.459);
      UI_SetProperty ("Close", "scale", 1.2);
      UI_SetProperty ("TitleMaterialFilters", "scale", 0.8);
      UI_SetProperty ("TitleMaterialFilters", "position.x", -0.485);
      UI_SetProperty ("TitleMaterialFilters", "position.y", -0.412);
      UI_SetProperty ("Filter", "scale", 1);
      UI_SetProperty ("Filter", "position.x", -0.415);
      UI_SetProperty ("Filter", "position.y", -0.4);
      UI_SetProperty ("ClearFilter", "scale", 0.8);
      UI_SetProperty ("ClearFilter", "position.x", -0.197);
      UI_SetProperty ("ClearFilter", "position.y", -0.4);
      UI_SetProperty ("events", "scale", 0.86);
      UI_SetProperty ("events", "position.y", -0.37);
      UI_SetProperty ("events", "listbox.content_height", 288);
      UI_SetProperty ("timeline2", "position.x", -0.188);
      UI_SetProperty ("timeline2", "position.y", -0.372);
      UI_SetProperty ("timeline2", "slider.ninepatch_height", 250);
      UI_SetProperty ("FilterResults", "scale", 1);
      UI_SetProperty ("FilterResults", "position.x", 0.02);
      UI_SetProperty ("FilterResults", "textbox.textbox_width", 280);
      UI_SetProperty ("panel2", "scale", 1.2);
      UI_SetProperty ("panel2", "position.y", 0.19);
      UI_SetProperty ("panel2", "ninepatch.rectangle_width", 206);
      UI_SetProperty ("panel2", "ninepatch.rectangle_height", 118);
      UI_SetProperty ("touchfield_2", "touchfield.area_width", 198);
      UI_SetProperty ("touchfield_2", "touchfield.area_height", 112);
      UI_SetProperty ("aligner_3", "aligner.area_width", 8);
      UI_SetProperty ("EventType", "textbox.textbox_width", 285);
      UI_SetProperty ("EventDesc", "textbox.textbox_width", 285);
      UI_SetProperty ("panel5", "ninepatch.rectangle_width", 538);
      UI_SetProperty ("panel5", "ninepatch.rectangle_height", 315);
      UI_SetProperty ("panel5", "position.x", 0.156);
      UI_SetProperty ("panel5", "position.y", -0.428);
      UI_SetProperty ("touchfield_1", "position.y", 0.011);
      UI_SetProperty ("touchfield_1", "touchfield.area_width", 530);
      UI_SetProperty ("touchfield_1", "touchfield.area_height", 307);
      UI_SetProperty ("Map", "scale", 0.836);
      UI_SetProperty ("InfoText", "textbox.textbox_width", 590);
      UI_SetProperty ("InfoText", "position.x", 0.155);
      UI_SetProperty ("InfoText", "position.y", 0.22);
      UI_SetProperty ("Timeline", "scale", 0.9);
      UI_SetProperty ("Timeline", "position.x", -0.15);
      UI_SetProperty ("Timeline", "position.y", 0.26);
      UI_SetProperty ("Timeline", "slider.ninepatch_width", 550);
      UI_SetProperty ("aligner_2", "scale", 1);
      UI_SetProperty ("aligner_2", "position.x", -0.175);
      UI_SetProperty ("aligner_2", "position.y", 0.315);
      UI_SetProperty ("aligner_2", "aligner.area_width", 530);
      UI_SetProperty ("aligner_2", "aligner.min_padding", 6);
    }
  }
  UI_SetVisible ("Mode", is_modded ? false : true);
}


function Mod_EventLog_OnClick_PauseMenu (clicked) {
  if (clicked == "mod_event_log") {
    UI_SendScreenMessage ("GameEventLog", "Mode", "INSPECT");
    UI_PushScreen ("GameEventLog");
  }
}


function Mod_EventLog_OnEnter_PauseMenu() {
  UI_SetProperty ("mod_event_log", "button.text", "|#c0c0c0||img src='emojis/package.png' scale=2 offset=2||#000000|  " + LocalizeText("Event Log"));
  UI_SetVisible ("mod_event_log", true);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
