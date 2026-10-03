// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local interval_realseconds = 0.2;
local update_in_realseconds = 0.0;


function Mod_ModsUI_OnUpdate_Mods (tdelta) {
  update_in_realseconds -= tdelta;
  if (update_in_realseconds < 0.0) {
    update_in_realseconds = interval_realseconds;
    local line_num = 0;
    local line_name_expected = null;
    local line_name_real = null;
    do {
      line_name_expected = "Mod_" + line_num.tostring();
      line_name_real = UI_GetProperty (line_name_expected, "name");
      if (line_name_expected == line_name_real) {
        UI_SetProperty (line_name_real + "_title", "localize", false);
        local mod_title = UI_GetProperty (line_name_real + "_title", "textbox.text");
        if (mod_title.len() >= 8 && mod_title.slice(mod_title.len() - 8) == " [LOCAL]") {
          UI_SetProperty (line_name_real + "_title", "textbox.text", LocalizeText(mod_title.slice(0, mod_title.len() - 8)) + "     (local)");
        } else if (mod_title.len() >= 8 && mod_title.slice(0, 8) == "[LOCAL] ") {
          UI_SetProperty (line_name_real + "_title", "textbox.text", "|#ffffd0ff|" + LocalizeText(mod_title.slice(8)) + "|#ffffd020|     local");
        }
      }
      line_num++;
    } while (line_name_expected == line_name_real);
  }
  if (UI_GetProperty ("PublishMod", "button.text") == "Publish...") {
    UI_SetProperty ("PublishMod", "button.text", "|#ffa500|Publish...");
  }
}


function Mod_ModsUI_OnUpdate_PublishMod (tdelta) {
  if (NX_GetKeyStatei (27) != 0) {
    UI_PopScreen();
  }
  local text = UI_GetProperty ("Publish", "button.text");
  if (text != null) {
    switch (text) {
      case "Publish": UI_SetProperty ("Publish", "button.text", "|#ff0000|Publish"); break;
      case "Update Item": UI_SetProperty ("Publish", "button.text", "|#00ff00|Update Item"); break;
    }
  }
  if (UI_GetProperty ("Visibility", "user_string") != "mod_mods_ui" && UI_GetProperty ("Visibility", "drop_down_list.lines") == "PUBLIC,Public;FRIENDS_ONLY,Friends Only;PRIVATE,Private") {
    UI_SetProperty ("Visibility", "drop_down_list.lines", "PUBLIC,|#ffa500|Public|#ffffff|;FRIENDS_ONLY,|#0000ff|Friends Only|#ffffff|;PRIVATE,|#00ff00|Private|#ffffff|");
    UI_SetProperty ("Visibility", "user_string", "mod_mods_ui");
  }
  if (UI_GetProperty ("ModTitle", "textbox.text") == "My Mod"
  || UI_GetProperty ("ModAuthor", "textbox.text") == "Me"
  || UI_GetProperty ("ModAuthor", "textbox.text") == "MoleEater"
  || UI_GetProperty ("ModDesc", "textbox.text") == "My mod description.") {
    UI_SetProperty ("Publish", "active", false);
  }
}


function Mod_ModsUI_OnUpdate_EditorPopup (tdelta) {
  if (UI_IsScreenInStack ("PublishMod") == true && UI_GetProperty ("Text", "user_string") != "mod_mods_ui"
  && UI_GetProperty ("Title", "textbox.text") == "Publish Result" && UI_GetProperty ("Button_0", "button.text") == "OK") {
    local text = UI_GetProperty ("Text", "textbox.text");
    if (text != null) {
      local new_text = null;
      switch (text) {
        case "Item uploaded to Steam Workshop successfully": new_text = "|#00ff00|" + text; break;
        case "Failed to uploaded to Steam Workshop.": new_text = "|#ff0000|" + text; break;
      }
      if (new_text != null) {
        UI_SetProperty ("Text", "textbox.text", new_text);
        UI_SetProperty ("Text", "user_string", "mod_mods_ui");
      }
    }
  }
}


function Mod_ModsUI_OnEnter_EditorPopup() {
  UI_SetProperty ("Text", "user_string", "");
}


function Mod_ModsUI_OnLeave_EditorPopup() {
  UI_SetProperty ("Text", "user_string", "");
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
