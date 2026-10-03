// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local hud_button_icons = {
    "enabled":  "hud/mods/mod-auto-material-transporter-enabled.png",
    "disabled": "hud/mods/mod-auto-material-transporter-disabled.png",
  };
local command = null;


Include ("scripts/mods/mods-info.nut");


function Mod_AutoMaterialTransporter_OnUpdate_Stage (tdelta) {
  if (Game_IsCinemaModeEnabled() != true && UI_IsScreenInStack ("PauseMenu") != true
  && Game_GetWorldStateAsInteger ("MODS", "auto_material_transporter_enabled", 0) == 1
  && Game_IsStoringMaterials() != true
  && command != null) {
    local player = Game_GetPrimaryPlayerActor();
    if (player != null) {
      Command_SetStageObjectReference (command, player);
      Stage_SendStageObjectCommand (player, command);
    }
  }
}


function Mod_AutoMaterialTransporter_OnClick_Stage (clicked) {
  if (clicked == "mod_auto_material_transporter") {
    local enable = UI_GetProperty ("mod_auto_material_transporter", "button.bm_icon") == hud_button_icons.enabled ? false : true;
    Game_SetWorldState ("MODS", "auto_material_transporter_enabled", enable ? "1" : "0");
    UI_SetProperty ("mod_auto_material_transporter", "button.bm_icon", enable ? hud_button_icons.enabled : hud_button_icons.disabled);
    local engine_kvs = Engine_GetKeyValueStore();
    if (engine_kvs != null) {
      KeyValueStore_SetKeyValueBoolean (engine_kvs, "autosave_when_storing_materials", ! enable);
    }
  }
}


function Mod_AutoMaterialTransporter_OnLeave_Stage() {
  Command_Delete (command);
}


function Mod_AutoMaterialTransporter_OnEnter_Stage() {
  UI_SetVisible ("mod_auto_material_transporter", false);
  command = Command_Create ("store_materials");
  local enabled = Game_GetWorldStateAsInteger ("MODS", "auto_material_transporter_enabled", 0) == 1 ? true : false;
  if (Game_GetWorldStateAsInteger ("MODS", "auto_material_transporter_hud", 0) == 1 && NX_ProductFeatureExists ("MOBILE_UI") != true) {
    UI_SetProperty ("mod_auto_material_transporter", "button.bm_icon", enabled ? hud_button_icons.enabled : hud_button_icons.disabled);
    UI_SetVisible ("mod_auto_material_transporter", true);
  }
  local engine_kvs = Engine_GetKeyValueStore();
  if (engine_kvs != null) {
    KeyValueStore_SetKeyValueBoolean (engine_kvs, "autosave_when_storing_materials", ! enabled);
  }
}


function Mod_AutoMaterialTransporter_OnScreenMessage_Stage (key, value) {
  if (key != null) {
    switch (key) {
      case "mod_auto_material_transporter_hud_message":
        UI_SetVisible ("mod_auto_material_transporter", value == "1" ? true : false);
        break;
      case "mod_auto_material_transporter_enabled_message":
        UI_SetProperty ("mod_auto_material_transporter", "button.bm_icon", value == "1" ? hud_button_icons.enabled : hud_button_icons.disabled);
        break;
    }
  }
}


function Mod_AutoMaterialTransporter_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_auto_material_transporter_enabled":
        local enabled = UI_GetProperty ("mod_auto_material_transporter_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "auto_material_transporter_enabled", enabled ? "1" : "0");
        UI_SetVisible ("mod_auto_material_transporter_enabled_notice", enabled);
        if (NX_ProductFeatureExists ("MOBILE_UI") != true) {
          UI_SendScreenMessage ("Stage", "mod_auto_material_transporter_enabled_message", enabled ? "1" : "0");
        }
        local engine_kvs = Engine_GetKeyValueStore();
        if (engine_kvs != null) {
          KeyValueStore_SetKeyValueBoolean (engine_kvs, "autosave_when_storing_materials", ! enabled);
        }
        break;
      case "mod_auto_material_transporter_hud":
        local hud = UI_GetProperty ("mod_auto_material_transporter_hud", "checkbox.value");
        Game_SetWorldState ("MODS", "auto_material_transporter_hud", hud.tostring());
        UI_SendScreenMessage ("Stage", "mod_auto_material_transporter_hud_message", hud.tostring());
        break;
      case "mod_auto_material_transporter_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Automatic material transporter"),
            LocalizeText("Store materials from backpack into camp storage box automatically, even legendary materials, and not just full backpacks.")
              + (NX_ProductFeatureExists ("MOBILE_UI") != true
                ? "\n\n" + LocalizeText("HUD") + ": " + LocalizeText("Toggle Automatic material transporter with a button on the bottom of the screen between the minimap and the carried materials.") : ""),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-auto-material-transporter-video")}] );
        break;
    }
  }
}


function Mod_AutoMaterialTransporter_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetVisible ("mod_auto_material_transporter_hud", false);
  local enabled = Game_GetWorldStateAsInteger ("MODS", "auto_material_transporter_enabled", 0) == 1 ? true : false;
  UI_SetProperty ("mod_auto_material_transporter_enabled", "checkbox.value", enabled ? 1 : 0);
  UI_SetProperty ("mod_auto_material_transporter_hud", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "auto_material_transporter_hud", 0));
  UI_SetVisible ("mod_auto_material_transporter_hud", NX_ProductFeatureExists ("MOBILE_UI") != true ? true : false);
  UI_SetVisible ("mod_auto_material_transporter_enabled_notice", enabled);
  UI_SetProperty ("mod_auto_material_transporter_enabled_title", "textbox.text", LocalizeText("Automatic material transporter"));
  UI_SetProperty ("mod_auto_material_transporter_enabled_notice", "textbox.text", LocalizeText("Remember to disable to bring materials."));
  UI_SetProperty ("mod_auto_material_transporter_hud_title", "textbox.text", LocalizeText("HUD") + ":");
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
