// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local is_info_screen = false;
local buttons_urls = [];


function Mods_Info_Popup (title = "", text = "", buttons = []) {
  UI_SendScreenMessage ("PopupMessage", "Mode", "MODS_INFO");
  local buttons_str = "";
  if (typeof buttons == "array" && buttons.len() > 0) {
    foreach (button_index, button_data in buttons) {
      local url = "";
      if (button_data.rawin("OpenURL")) {
        url = button_data["OpenURL"];
        if (url == null) {
          url = "";
        } else {
          url = url.tostring();
        }
      }
      UI_SendScreenMessage ("PopupMessage", "mods_info_button_url_" + button_index.tostring(), url);
      local button_text = "";
      if (button_data.rawin("text")) {
        button_text = button_data["text"];
        if (button_text == null) button_text = "";
      }
      buttons_str += (buttons_str == "" ? "" : ",") + string_replace(button_text.tostring(), ",", "_");
    }
  }
  UI_ShowPopup (title == null ? "" : title.tostring(), text == null ? "" : text.tostring(), buttons_str);
}


function Mods_Info_OnScreenMessage_PopupMessage (key, value) {
  if (key != null) {
    switch (key) {
      case "Mode":
        if (value == "MODS_INFO") {
          is_info_screen = true;
          UI_SetProperty ("fader", "shaderfilter.blur.enabled", false);
          UI_SetProperty ("fader", "shaderfilter.hsb.enabled", true);
          UI_SetProperty ("fader", "shaderfilter.hsb.saturation", 0.75);
          UI_SetProperty ("fader", "shaderfilter.hsb.brightness", 0.5);
          UI_SetProperty ("panel", "ninepatch.automatic_content_padding", 35);
          UI_SetProperty ("panel", "ninepatch.automatic_content_width", true);
          UI_SetProperty ("aligner_2", "aligner.automatic_area_width", true);
          UI_SetProperty ("marker_1", "marker.area_height", 1);
          UI_SetProperty ("Title", "textbox.textbox_width", 660);
          UI_SetProperty ("Text", "textbox.textbox_width", 560);
          UI_SetProperty ("aligner_1", "aligner.area_width", 610.0);
          UI_SetProperty ("aligner_1", "aligner.fixed_num_rows", 0);
          UI_SetProperty ("aligner_1", "aligner.area_height", 0.0);
          UI_SetVisible ("marker_2", false);
        }
        break;
    }
    if (regexp("mods_info_button_url_[0-9]+").match(key) == true) {
      local button_num = key.slice(21).tointeger();
      if (buttons_urls.len() <= button_num) {
        buttons_urls.resize(button_num + 1);
      }
      buttons_urls.insert(button_num, value == "" ? null : value);
      UI_SetProperty ("Button_" + button_num.tostring(), "button.ninepatch_margin", 30);
      UI_SetProperty ("aligner_1", "aligner.area_height", 100.0);
    }
  }
}


function Mods_Info_OnClick_PopupMessage (clicked) {
  if (is_info_screen == true && clicked != null) {
    switch (clicked) {
      case "fader":
        UI_PopScreen();
        break;
    }
    if (regexp("Button_[0-9]+").match(clicked) == true) {
      local button_num = clicked.slice(7).tointeger();
      local url = buttons_urls[button_num];
      if (url != null) {
        NX_CallExtension ("OpenURL", url);
      }
    }
  }
}


function Mods_Info_OnLeave_PopupMessage() {
  buttons_urls = [];
  is_info_screen = false;
  UI_SetProperty ("fader", "shaderfilter.hsb.enabled", false);
  UI_SetProperty ("fader", "shaderfilter.hsb.saturation", 1.0);
  UI_SetProperty ("fader", "shaderfilter.hsb.brightness", 1.0);
  UI_SetProperty ("fader", "shaderfilter.blur.enabled", true);
  UI_SetProperty ("panel", "ninepatch.automatic_content_padding", 14);
  UI_SetProperty ("marker_1", "marker.area_height", 35);
  UI_SetProperty ("Title", "textbox.textbox_width", 752);
  UI_SetProperty ("Text", "textbox.textbox_width", 705);
  UI_SetProperty ("aligner_1", "aligner.fixed_num_rows", 1);
  UI_SetProperty ("aligner_1", "aligner.area_height", 65.0);
  UI_SetProperty ("aligner_1", "aligner.area_width", 814.0);
  UI_SetVisible ("marker_2", true);
  foreach (button_num in [0,1,2,3,4]) {
    UI_SetProperty ("Button_" + button_num.tostring(), "button.ninepatch_margin", 20);
    UI_SetProperty ("Button_" + button_num.tostring(), "button.ninepatch_height", 48);
  }
  UI_SetProperty ("aligner_2", "aligner.automatic_area_width", true);
  UI_SetProperty ("panel", "ninepatch.automatic_content_width", true);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
