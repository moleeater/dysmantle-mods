// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local controller_types = {
    "gamepad"  : "Gamepad",
    "wasdmouse": "Keyboard and Mouse",
  };
local controllers = {
    "gamepad_1": LocalizeText("Gamepad") + " 1",
    "gamepad_2": LocalizeText("Gamepad") + " 2",
    "gamepad_3": LocalizeText("Gamepad") + " 3",
    "gamepad_4": LocalizeText("Gamepad") + " 4",
    "wasdmouse": LocalizeText("Keyboard and Mouse"),
  };
local controller_scancodes = {
    "gamepad"  : {},
    "wasdmouse": {},
  };
controller_scancodes.gamepad[801] <- "LEFT_TRIGGER";
controller_scancodes.gamepad[802] <- "RIGHT_TRIGGER";
controller_scancodes.gamepad[804] <- "LEFT_THUMB_X";
controller_scancodes.gamepad[805] <- "LEFT_THUMB_Y";
controller_scancodes.gamepad[806] <- "RIGHT_THUMB_X";
controller_scancodes.gamepad[807] <- "RIGHT_THUMB_Y";
controller_scancodes.gamepad[810] <- "DPAD_UP";
controller_scancodes.gamepad[811] <- "DPAD_DOWN";
controller_scancodes.gamepad[812] <- "DPAD_LEFT";
controller_scancodes.gamepad[813] <- "DPAD_RIGHT";
controller_scancodes.gamepad[820] <- "BUTTON_START";
controller_scancodes.gamepad[821] <- "BUTTON_BACK";
controller_scancodes.gamepad[822] <- "BUTTON_LEFT_THUMB";
controller_scancodes.gamepad[823] <- "BUTTON_RIGHT_THUMB";
controller_scancodes.gamepad[824] <- "BUTTON_LEFT_SHOULDER";
controller_scancodes.gamepad[825] <- "BUTTON_RIGHT_SHOULDER";
controller_scancodes.gamepad[826] <- "BUTTON_A";
controller_scancodes.gamepad[827] <- "BUTTON_B";
controller_scancodes.gamepad[828] <- "BUTTON_X";
controller_scancodes.gamepad[829] <- "BUTTON_Y";
controller_scancodes.gamepad[845] <- "TOUCHPAD";
controller_scancodes.gamepad[848] <- "BUTTON_TOUCHPAD";
controller_scancodes.wasdmouse[8] <- "BACKSPACE";
controller_scancodes.wasdmouse[9] <- "TAB";
controller_scancodes.wasdmouse[12] <- "CLEAR";
controller_scancodes.wasdmouse[13] <- "RETURN";
controller_scancodes.wasdmouse[16] <- "SHIFT";
controller_scancodes.wasdmouse[17] <- "CONTROL";
controller_scancodes.wasdmouse[18] <- "ALT";
controller_scancodes.wasdmouse[19] <- "PAUSE";
controller_scancodes.wasdmouse[20] <- "CAPITAL";
controller_scancodes.wasdmouse[27] <- "ESCAPE";
controller_scancodes.wasdmouse[32] <- "SPACE";
controller_scancodes.wasdmouse[33] <- "PAGEUP";
controller_scancodes.wasdmouse[34] <- "PAGEDOWN";
controller_scancodes.wasdmouse[35] <- "END";
controller_scancodes.wasdmouse[36] <- "HOME";
controller_scancodes.wasdmouse[37] <- "LEFT";
controller_scancodes.wasdmouse[38] <- "UP";
controller_scancodes.wasdmouse[39] <- "RIGHT";
controller_scancodes.wasdmouse[40] <- "DOWN";
controller_scancodes.wasdmouse[41] <- "SELECT";
controller_scancodes.wasdmouse[42] <- "PRINT";
controller_scancodes.wasdmouse[43] <- "EXECUTE";
controller_scancodes.wasdmouse[44] <- "PRINT_SCREEN";
controller_scancodes.wasdmouse[45] <- "INSERT";
controller_scancodes.wasdmouse[46] <- "DELETE";
controller_scancodes.wasdmouse[47] <- "HELP";
for (local code = 48; code < 48 + 10; code++) {
  controller_scancodes.wasdmouse[code] <- code.tochar();
}
controller_scancodes.wasdmouse[59] <- ";";
controller_scancodes.wasdmouse[61] <- "=";
for (local code = 65; code < 65 + 26; code++) {
  controller_scancodes.wasdmouse[code] <- code.tochar();
}
controller_scancodes.wasdmouse[91] <- "META";
controller_scancodes.wasdmouse[92] <- "META_RIGHT";
controller_scancodes.wasdmouse[93] <- "CONTEXT";
for (local num = 0; num < 10; num++) {
  controller_scancodes.wasdmouse[96 + num] <- "NUMPAD" + num.tostring();
}
controller_scancodes.wasdmouse[106] <- "MULTIPLY";
controller_scancodes.wasdmouse[107] <- "ADD";
controller_scancodes.wasdmouse[108] <- "SEPARATOR";
controller_scancodes.wasdmouse[109] <- "SUBTRACT";
controller_scancodes.wasdmouse[110] <- "DECIMAL";
controller_scancodes.wasdmouse[111] <- "DIVIDE";
for (local num = 1; num <= 24; num++) {
  controller_scancodes.wasdmouse[112 - 1 + num] <- "F" + num.tostring();
}
controller_scancodes.wasdmouse[144] <- "NUMLOCK";
controller_scancodes.wasdmouse[145] <- "SCROLL";
controller_scancodes.wasdmouse[160] <- "LEFT_SHIFT";
controller_scancodes.wasdmouse[161] <- "RIGHT_SHIFT";
controller_scancodes.wasdmouse[162] <- "LEFT_CONTROL";
controller_scancodes.wasdmouse[163] <- "RIGHT_CONTROL";
controller_scancodes.wasdmouse[164] <- "LEFT_ALT";
controller_scancodes.wasdmouse[165] <- "RIGHT_ALT";
controller_scancodes.wasdmouse[172] <- "BROWSER";
controller_scancodes.wasdmouse[173] <- "MUTE";
controller_scancodes.wasdmouse[174] <- "VOLUME_DOWN";
controller_scancodes.wasdmouse[175] <- "VOLUME_UP";
controller_scancodes.wasdmouse[176] <- "NEXT";
controller_scancodes.wasdmouse[177] <- "PREVIOUS";
controller_scancodes.wasdmouse[178] <- "STOP";
controller_scancodes.wasdmouse[179] <- "PLAY";
controller_scancodes.wasdmouse[180] <- "EMAIL";
controller_scancodes.wasdmouse[186] <- ";";
controller_scancodes.wasdmouse[187] <- "=";
controller_scancodes.wasdmouse[188] <- ",";
controller_scancodes.wasdmouse[189] <- "-";
controller_scancodes.wasdmouse[190] <- ".";
controller_scancodes.wasdmouse[191] <- "/";
controller_scancodes.wasdmouse[192] <- "`";
controller_scancodes.wasdmouse[219] <- "[";
controller_scancodes.wasdmouse[221] <- "]";
controller_scancodes.wasdmouse[222] <- "'";
controller_scancodes.wasdmouse[220] <- "\"";
controller_scancodes.wasdmouse[300] <- "MENU";
controller_scancodes.wasdmouse[400] <- "GESTURE_SWIPE_UP";
controller_scancodes.wasdmouse[401] <- "GESTURE_SWIPE_RIGHT";
controller_scancodes.wasdmouse[402] <- "GESTURE_SWIPE_DOWN";
controller_scancodes.wasdmouse[403] <- "GESTURE_SWIPE_LEFT";
controller_scancodes.wasdmouse[500] <- "MOUSE_X_REL";
controller_scancodes.wasdmouse[501] <- "MOUSE_Y_REL";
controller_scancodes.wasdmouse[502] <- "MOUSE_Z_REL";
controller_scancodes.wasdmouse[503] <- "MOUSE_X";
controller_scancodes.wasdmouse[504] <- "MOUSE_Y";
controller_scancodes.wasdmouse[505] <- "MOUSE_Z";
controller_scancodes.wasdmouse[506] <- "MOUSE_WHEEL_X";
controller_scancodes.wasdmouse[507] <- "MOUSE_WHEEL_Y";
controller_scancodes.wasdmouse[508] <- "MOUSE_DELTA_X";
controller_scancodes.wasdmouse[509] <- "MOUSE_DELTA_Y";
for (local num = 0; num < 8; num++) {
  controller_scancodes.wasdmouse[510 + num] <- "MOUSE_BUTTON_" + num.tostring();
}
controller_scancodes.wasdmouse[518] <- "MOUSE_ACTIVE";
controller_scancodes.wasdmouse[1500] <- "NV_ACTIVE";
controller_scancodes.wasdmouse[1501] <- "NV_TOOL_POS_X";
controller_scancodes.wasdmouse[1502] <- "NV_TOOL_POS_Y";
controller_scancodes.wasdmouse[1503] <- "NV_TOOL_POS_Z";
controller_scancodes.wasdmouse[1511] <- "NV_TOOL_FORCE_X";
controller_scancodes.wasdmouse[1512] <- "NV_TOOL_FORCE_Y";
controller_scancodes.wasdmouse[1513] <- "NV_TOOL_FORCE_Z";
controller_scancodes.wasdmouse[1520] <- "NV_BUTTONS";
controller_scancodes.wasdmouse[1521] <- "NV_BUTTON_1";
controller_scancodes.wasdmouse[1522] <- "NV_BUTTON_2";
controller_scancodes.wasdmouse[1523] <- "NV_BUTTON_3";
controller_scancodes.wasdmouse[1524] <- "NV_BUTTON_4";
controller_scancodes.wasdmouse[1600] <- "MOBILE_DEVICE_STATES";
controller_scancodes.wasdmouse[1610] <- "ACCELEROMETER_X";
controller_scancodes.wasdmouse[1611] <- "ACCELEROMETER_Y";
controller_scancodes.wasdmouse[1612] <- "ACCELEROMETER_Z";
controller_scancodes.wasdmouse[1613] <- "GRAVITY_X";
controller_scancodes.wasdmouse[1614] <- "GRAVITY_Y";
controller_scancodes.wasdmouse[1615] <- "GRAVITY_Z";
controller_scancodes.wasdmouse[1621] <- "LOCATION_LATITUDE";
controller_scancodes.wasdmouse[1622] <- "LOCATION_LONGITUDE";
controller_scancodes.wasdmouse[1632] <- "VOLUME_UP";
controller_scancodes.wasdmouse[1633] <- "VOLUME_DOWN";
controller_scancodes.wasdmouse[1640] <- "ROTATION_X";
controller_scancodes.wasdmouse[1641] <- "ROTATION_Y";
controller_scancodes.wasdmouse[1642] <- "ROTATION_Z";
local controller_images = {
    "gamepad": {
        "BUTTON_A"             : "button-a.png",
        "BUTTON_B"             : "button-b.png",
        "BUTTON_BACK"          : "button-back.png",
        "BUTTON_LEFT_SHOULDER" : "left-shoulder.png",
        "BUTTON_LEFT_THUMB"    : "left-stick-press.png",
        "BUTTON_RIGHT_SHOULDER": "right-shoulder.png",
        "BUTTON_RIGHT_THUMB"   : "right-stick-press.png",
        "BUTTON_START"         : "button-start.png",
        "BUTTON_TOUCHPAD"      : "touchpad.png",
        "BUTTON_X"             : "button-x.png",
        "BUTTON_Y"             : "button-y.png",
        "DPAD_DOWN"            : "button-dpad-down.png",
        "DPAD_LEFT"            : "button-dpad-left.png",
        "DPAD_RIGHT"           : "button-dpad-right.png",
        "DPAD_UP"              : "button-dpad-up.png",
        "LEFT_THUMB_X"         : "left-stick.png",
        "LEFT_THUMB_Y"         : "left-stick.png",
        "LEFT_TRIGGER"         : "left-trigger.png",
        "RIGHT_THUMB_X"        : "right-stick.png",
        "RIGHT_THUMB_Y"        : "right-stick.png",
        "RIGHT_TRIGGER"        : "right-trigger.png",
        "TOUCHPAD"             : "touchpad.png",
      },
    "wasdmouse": {
        "*"             : "button-asterisk.png",
        "+"             : "button-plus.png",
        "-"             : "button-minus.png",
        "0"             : "button-0.png",
        "1"             : "button-1.png",
        "2"             : "button-2.png",
        "3"             : "button-3.png",
        "4"             : "button-4.png",
        "5"             : "button-5.png",
        "6"             : "button-6.png",
        "7"             : "button-7.png",
        "8"             : "button-8.png",
        "9"             : "button-9.png",
        ";"             : "button-semicolon.png",
        "<"             : "button-mark_left.png",
        ">"             : "button-mark_right.png",
        "?"             : "button-question.png",
        "A"             : "button-a.png",
        "ADD"           : "button-plus_tall.png",
        "ALT"           : "button-alt.png",
        "B"             : "button-b.png",
        "BACKSPACE"     : "button-backspace_alt.png",
        "C"             : "button-c.png",
        "CAPITAL"       : "button-caps_lock.png",
        "CONTROL"       : "button-ctrl.png",
        "D"             : "button-d.png",
        "DELETE"        : "button-del.png",
        "DOWN"          : "button-arrow_down.png",
        "E"             : "button-e.png",
        "END"           : "button-end.png",
        "F"             : "button-f.png",
        "G"             : "button-g.png",
        "H"             : "button-h.png",
        "HOME"          : "button-home.png",
        "I"             : "button-i.png",
        "INSERT"        : "button-insert.png",
        "J"             : "button-j.png",
        "K"             : "button-k.png",
        "L"             : "button-l.png",
        "LEFT"          : "button-arrow_left.png",
        "LEFT_ALT"      : "button-alt.png",
        "LEFT_CONTROL"  : "button-ctrl.png",
        "LEFT_SHIFT"    : "button-shift_alt.png",
        "M"             : "button-m.png",
        "META"          : "button-win.png",
        "MOUSE_BUTTON_0": "mouse-left.png",
        "MOUSE_BUTTON_1": "mouse-right.png",
        "MOUSE_BUTTON_2": "mouse-middle.png",
        "MULTIPLY"      : "button-asterisk.png",
        "N"             : "button-n.png",
        "NUMLOCK"       : "button-num_lock.png",
        "O"             : "button-o.png",
        "P"             : "button-p.png",
        "PAGEDOWN"      : "button-page_down.png",
        "PAGEUP"        : "button-page_up.png",
        "PRINT"         : "button-print_screen.png",
        "Q"             : "button-q.png",
        "R"             : "button-r.png",
        "RETURN"        : "button-enter_alt.png",
        "RIGHT"         : "button-arrow_right.png",
        "RIGHT_ALT"     : "button-alt.png",
        "RIGHT_CONTROL" : "button-ctrl.png",
        "RIGHT_SHIFT"   : "button-shift_alt.png",
        "S"             : "button-s.png",
        "SHIFT"         : "button-shift_alt.png",
        "SPACE"         : "button-space.png",
        "SUBTRACT"      : "button-minus.png",
        "T"             : "button-t.png",
        "TAB"           : "button-tab.png",
        "U"             : "button-u.png",
        "UP"            : "button-arrow_up.png",
        "V"             : "button-v.png",
        "W"             : "button-w.png",
        "X"             : "button-x.png",
        "Y"             : "button-y.png",
        "Z"             : "button-z.png",
        "["             : "button-bracket_left.png",
        "\""            : "button-quote.png",
        "\\"            : "button-slash.png",
        "]"             : "button-bracket_right.png",
        "~"             : "button-tilda.png",
      },
  };
local binding_for = null;
local controls = {};
local players = [ null, null ];
local owner_indexes = {};
local is_controller_popup = false;
local popup_controller = null;


Include ("scripts/mods/mods-info.nut");


function Mods_Controller_OnScreenMessage_PopupMessage (key, value) {
  if (key != null) {
    switch (key) {
      case "Mode":
        if (value == "MODS_CONTROLLER") {
          is_controller_popup = true;
          UI_SetProperty ("fader", "shaderfilter.blur.enabled", false);
          UI_SetProperty ("panel", "ninepatch.automatic_content_padding", 35);
          UI_SetProperty ("panel", "ninepatch.automatic_content_width", true);
          UI_SetProperty ("aligner_2", "aligner.min_padding", 35);
          UI_SetProperty ("aligner_2", "aligner.automatic_area_width", true);
          UI_SetProperty ("marker_1", "marker.area_height", 1);
          UI_SetProperty ("Title", "textbox.fit_inside_textbox", false);
          UI_SetProperty ("Title", "textbox.textbox_width", 600);
          UI_SetProperty ("Title", "interactive", true);
          UI_SetProperty ("Title", "active", true);
          UI_SetProperty ("Text", "textbox.textbox_width", 500);
          UI_SetProperty ("Text", "interactive", true);
          UI_SetProperty ("Text", "active", true);
          UI_SetProperty ("aligner_1", "aligner.min_padding", 0);
          UI_SetProperty ("aligner_1", "aligner.fixed_num_rows", 0);
          UI_SetProperty ("aligner_1", "aligner.fixed_num_columns", 1);
          UI_SetProperty ("aligner_1", "aligner.automatic_area_width", true);
          UI_SetProperty ("aligner_1", "aligner.automatic_area_height", true);
          UI_SetVisible ("marker_2", false);
          foreach (button_num in [0,1]) {
            UI_SetProperty ("Button_" + button_num.tostring(), "button.ninepatch_margin", 20);
          }
        }
        break;
      case "mods_controller":
        popup_controller = value;
        foreach (player_index in [0,1]) {
          local button_text = "|#" + (player_index == 1 ? "ff7f66" : "6699ff") + "|" + LocalizeText("PLAYER") + " " + (player_index + 1).tostring();
          UI_SetProperty ("Button_" + player_index.tostring(), "button.text", button_text);
        }
        break;
    }
  }
}


function Mods_Controller_OnClick_PopupMessage (clicked) {
  if (is_controller_popup == true && clicked != null) {
    switch (clicked) {
      case "Button_0":
      case "Button_1":
        UI_SendScreenMessage ("Stage", "mods_controller_" + popup_controller, clicked.slice(7));
        break;
    }
  }
}


function Mods_Controller_OnLeave_PopupMessage() {
  is_controller_popup = false;
  UI_SetProperty ("fader", "shaderfilter.blur.enabled", true);
  UI_SetProperty ("panel", "ninepatch.automatic_content_padding", 14);
  UI_SetProperty ("aligner_2", "aligner.min_padding", 16);
  UI_SetProperty ("marker_1", "marker.area_height", 35);
  UI_SetProperty ("Title", "textbox.fit_inside_textbox", true);
  UI_SetProperty ("Title", "textbox.textbox_width", 752);
  UI_SetProperty ("Title", "interactive", false);
  UI_SetProperty ("Title", "active", false);
  UI_SetProperty ("Text", "textbox.textbox_width", 705);
  UI_SetProperty ("Text", "interactive", false);
  UI_SetProperty ("Text", "active", false);
  UI_SetProperty ("aligner_1", "aligner.min_padding", 0.1);
  UI_SetProperty ("aligner_1", "aligner.automatic_area_width", false);
  UI_SetProperty ("aligner_1", "aligner.automatic_area_height", false);
  UI_SetProperty ("aligner_1", "aligner.fixed_num_columns", 0);
  UI_SetProperty ("aligner_1", "aligner.fixed_num_rows", 1);
  UI_SetVisible ("marker_2", true);
  UI_SetProperty ("aligner_2", "aligner.automatic_area_width", true);
  UI_SetProperty ("panel", "ninepatch.automatic_content_width", true);
}


function Mods_Controller_GetPlayers (action) {
  local player_datas = players.map(@(player) { "player": player, "key_state": null });
  if (controls.rawin(action.name) == true) {
    foreach (controller, scancode in controls[action.name]) {
      if (scancode != null) {
        local key_state = NX_GetKeyStatei (scancode.tointeger());
        if (key_state != 0) {
          if (action.per_player != true) {
            foreach (player_index, player_data in player_datas) {
              if (player_data.player != null) {
                player_datas[player_index].key_state = key_state;
              }
            }
          } else {
            local owner_index = players[1] == null ? 0 : owner_indexes[controller];
            if (owner_index == null && UI_IsScreenInStack ("PopupMessage") != true) {
              UI_SendScreenMessage ("PopupMessage", "Mode", "MODS_CONTROLLER");
              local image = "|img src='controller-art/" + (controller == "wasdmouse" ? controller + "/button-wasd" : "gamepad/" + string_replace(controller, "_", "-")) + ".png' scale=1 offset=2|";
              UI_ShowPopup (
                  "|img src='emojis/package.png' scale=1.3 offset=2| " + LocalizeText("Who uses") + " " + controllers[controller] + " " + image + "?",
                  LocalizeText("Who activated") + " " + LocalizeText(action.title) + "?",
                  "1,2");
              UI_SendScreenMessage ("PopupMessage", "mods_controller", controller);
            }
            if (owner_index != null) {
              player_datas[owner_index].key_state = key_state;
            }
          }
        }
      }
    }
  }
  return player_datas;
}


function Mods_Controller_OnUpdate_Stage (action, tdelta = null) {
  foreach (player_index in [0,1]) {
    players[player_index] = Game_GetPlayerActor (player_index);
  }
  local was_coop = null;
  switch (Game_GetPlayerState ("mods_controller_coop")) {
    case "1": was_coop = true; break;
    case "0": was_coop = false; break;
    default: was_coop = null; break;
  }
  local is_coop = players[1] != null;
  if (was_coop == null || was_coop != is_coop) {
    foreach (controller, controller_title in controllers) {
      owner_indexes[controller] <- null;
      Game_SetPlayerState ("mods_controller_" + controller, "");
    }
  }
  Game_SetPlayerState ("mods_controller_coop", is_coop == true ? "1" : "0");
}


function Mods_Controller_SetControls (action_name, controller_type) {
  if (controls.rawin(action_name) != true) {
    controls[action_name] <- {};
  }
  local scancode = Game_GetWorldState ("MODS_CONTROLLER", controller_type + "_" + action_name);
  if (scancode == "") scancode = null;
  switch (controller_type) {
    case "gamepad":
      foreach (gamepad_num in [1,2,3,4]) {
        local gamepad_scancode = scancode;
        if (gamepad_scancode != null) {
          gamepad_scancode = gamepad_scancode.tointeger() + 800 + 64 * (gamepad_num - 1);
        }
        controls[action_name]["gamepad_" + gamepad_num.tostring()] <- gamepad_scancode;
      }
      break;
    case "wasdmouse":
      controls[action_name][controller_type] <- scancode;
      break;
  }
}


function Mods_Controller_OnScreenMessage_Stage (key, value) {
  if (key != null) {
    switch (key) {
      case "mods_controller_set_controls":
        foreach (controller_type, controller_title in controller_types) {
          if (value.len() > 12 + controller_type.len() && value.slice(value.len() - 1 - controller_type.len()) == "_" + controller_type) {
            local action_name = value.slice(0, value.len() - 12 - controller_type.len());
            if (action_name != null) {
              Mods_Controller_SetControls (action_name, controller_type);
            }
            break;
          }
        }
        break;
      case "mods_controller_wasdmouse":
      case "mods_controller_gamepad_1":
      case "mods_controller_gamepad_2":
      case "mods_controller_gamepad_3":
      case "mods_controller_gamepad_4":
        local controller = key.slice(16);
        owner_indexes[controller] <- value.tointeger();
        Game_SetPlayerState ("mods_controller_" + controller, value);
        break;
    }
  }
}


function Mods_Controller_OnEnter_Stage (action) {
  foreach (controller_type, controller_title in controller_types) {
    Mods_Controller_SetControls (action.name, controller_type);
  }
  foreach (controller, controller_title in controllers) {
    local player_index = Game_GetPlayerState ("mods_controller_" + controller);
    owner_indexes[controller] <- player_index == "" || player_index == null ? null : player_index.tointeger();
  }
}


function Mods_Controller_GetButtonText (controller_type, scancode) {
  local image = null;
  local scanname = null;
  local padding = "";
  if (scancode != null && scancode != "") {
    scancode = scancode.tointeger();
    if (controller_type == "gamepad" && scancode < 800) {
      scancode += 800;
    }
    if (controller_scancodes[controller_type].rawin(scancode)) {
      scanname = controller_scancodes[controller_type][scancode];
      if (scanname.len() == 1) {
        padding = "   ";
      }
      if (controller_images[controller_type].rawin(scanname) == true) {
        local gamepad_art = "";
        if (controller_type == "gamepad") {
          local engine_kvs = Engine_GetKeyValueStore();
          if (engine_kvs != null) {
            gamepad_art = KeyValueStore_GetKeyValueAsString (engine_kvs, "gamepad_art");
          }
        }
        if (gamepad_art == null) gamepad_art = "";
        if (gamepad_art != "") {
          gamepad_art += "/";
        }
        image = "controller-art/" + controller_type + "/" + gamepad_art + controller_images[controller_type][scanname];
      }
    }
  }
  return image != null
      ? " |img src='" + image + "' scale=3.8 offset=-1| "
      : scanname != null
        ? "|#000000|" + padding + scanname + padding + "|#ffffff|"
        : scancode != null && scancode != ""
          ? "|#000000| " + scancode.tostring() + " |#ffffff|"
          : "|#000000| |img src='emojis/cross mark.png' scale=3| |#ffffff|";
}


function Mods_Controller_OnScreenMessage_OptionsUnified (key, value) {
  if (key == "key" && binding_for != null) {
    value = value.tointeger();
    if (value != 510) {
      foreach (controller_type, controller_title in controller_types) {
        if (binding_for.len() > 12 + controller_type.len() && binding_for.slice(binding_for.len() - 1 - controller_type.len()) == "_" + controller_type) {
          local action_name = binding_for.slice(0, binding_for.len() - 12 - controller_type.len());
          local scancode = null;
          if (value == 27) {
            scancode = "";
          } else if (controller_type == "gamepad" && value >= 800 && value <= 800 + 64 * 4) {
            value = (value - 800) % 64 + 800;
            if (controller_scancodes[controller_type].rawin(value) == true) {
              local scanname = controller_scancodes[controller_type][value];
              if (controller_images[controller_type].rawin(scanname) == true) {
                scancode = value - 800;
              }
            }
          } else if (controller_type == "wasdmouse" && (value < 800 || value >= 800 + 64 * 4) && value > 0) {
            scancode = value;
          }
          if (scancode != null && action_name != null) {
            Game_SetWorldState ("MODS_CONTROLLER", controller_type + "_" + action_name, scancode.tostring());
            UI_SetProperty ("mod_" + binding_for, "button.text", Mods_Controller_GetButtonText (controller_type, scancode));
            UI_SendScreenMessage ("Stage", "mods_controller_set_controls", binding_for);
            binding_for = null;
            UI_PopScreen ("ControlOptionsBind");
          }
          break;
        }
      }
    }
  }
}


function Mods_Controller_OnClick_OptionsUnified (action, clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_" + action.name + "_controller_gamepad":
      case "mod_" + action.name + "_controller_wasdmouse":
        local controller = UI_GetProperty (clicked + "_title", "textbox.text");
        local button_label = UI_GetProperty ("mod_" + action.name + "_controller_title", "textbox.text") + (controller == null ? "" : " ("+ controller + ")");
        UI_SendScreenMessage ("ControlOptionsBind", "button_label", "|img src='emojis/package.png' scale=1.8 offset=2| " + button_label);
        UI_PushScreen ("ControlOptionsBind");
        if (UI_IsScreenInStack ("ControlOptionsBind")) {
          binding_for = clicked.slice(4);
        }
        break;
      case "mod_" + action.name + "_controller_title":
        Mods_Info_Popup (
            LocalizeText(action.title),
            LocalizeText(action.desc));
        break;
    }
  }
}


function Mods_Controller_OnEnter_OptionsUnified (action, stage_in_stack) {
  local is_touch = NX_ProductFeatureExists ("VIRTUAL_CONTROLS") == true ? true : false;
  UI_SetProperty ("mod_" + action.name + "_controller_title", "textbox.text", LocalizeText(action.title));
  foreach (controller_type, controller_title in controller_types) {
    UI_SetProperty ("mod_" + action.name + "_controller_" + controller_type + "_title", "textbox.text", LocalizeText(controller_title));
    local scancode = Game_GetWorldState ("MODS_CONTROLLER", controller_type + "_" + action.name);
    UI_SetProperty ("mod_" + action.name + "_controller_" + controller_type, "button.text", Mods_Controller_GetButtonText (controller_type, scancode));
    UI_SetProperty ("mod_" + action.name + "_controller_" + controller_type, "active", is_touch ? false : true);
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
