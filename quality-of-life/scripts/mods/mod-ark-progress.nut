// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local debounce_realseconds = 1.0;
local ark_requirements = [
    { "material": "MUSHROOM_BROWN"   , "required":  100 },
    { "material": "MUSHROOM_RED"     , "required":   80 },
    { "material": "MUSHROOM_WHITE"   , "required":   50 },
    { "material": "BERRIES"          , "required":  100 },
    { "material": "FISH_A"           , "required":   70 },
    { "material": "FISH_B"           , "required":   45 },
    { "material": "FISH_C"           , "required":   30 },
    { "material": "EGG"              , "required":  100 },
    { "material": "CARROT"           , "required":  300 },
    { "material": "TOMATO"           , "required":  300 },
    { "material": "LETTUCE"          , "required":  220 },
    { "material": "POTATO"           , "required":  220 },
    { "material": "CORN"             , "required":  200 },
    { "material": "ONION"            , "required":  160 },
    { "material": "WHEAT"            , "required":  140 },
    { "material": "SPICES"           , "required":   40 },
    { "material": "SCRAP_FABRIC"     , "required":  500 },
    { "material": "PLANTS"           , "required": 1800 },
    { "material": "BONE"             , "required":  300 },
    { "material": "HIDE"             , "required":  100 },
    { "material": "FABRIC"           , "required":  300 },
    { "material": "IRON"             , "required":  400 },
    { "material": "SCRAP_METAL"      , "required":  500 },
    { "material": "SCRAP_WOOD"       , "required":  400 },
    { "material": "WOOD"             , "required":  600 },
    { "material": "LUMBER"           , "required":   50 },
    { "material": "CERAMICS"         , "required":  300 },
    { "material": "PLASTICS"         , "required":  650 },
    { "material": "ELECTRONICS"      , "required":  160 },
    { "material": "SCRAP_ELECTRONICS", "required":  250 },
    { "material": "RUBBER"           , "required":  250 },
    { "material": "STEEL"            , "required":  300 },
    { "material": "STONE"            , "required":  450 },
    { "material": "BRICKS"           , "required":  450 },
    { "material": "TITANIUM"         , "required":   35 },
  ];
local ark4_requirements = [
    { "material": "MANA_BEAD" , "required": 200 },
    { "material": "MANA_CHUNK", "required":  10 },
    { "material": "MANA_SHARD", "required":   5 },
    { "material": "TOMB_ORB"  , "required":   3 },
    { "material": "NIGHT_MANA", "required":  10 },
  ];
local next_stageseconds = null;


function Mod_POIInfo_OnLeave_PointOfInterestInfo() {
  UI_SetProperty ("Desc", "textbox.text", "");
  UI_SetProperty ("Desc", "scale", 0.687938);
  UI_SetProperty ("Desc", "textbox.textbox_width", 681);
}


function Mod_ArkProgress_Calculate() {
  local ark = [];
  local requirements = null;
  if (Game_IsQuestPhaseCompleted ("quests/the-ark.nut", "ENTER_ARK") == true) {
    if (Game_IsQuestPhaseCompleted ("quests/the-ark.nut", "COMPLETE_ALL_COLLECTIONS") != true) {
      requirements = ark_requirements;
    } else if (Game_IsStageDiscovered ("stages/special/the-ark-level-4.stage") == true && Game_IsAudioLogListened ("dysmantle/ark.xml", "ARK_LEVEL_4_COLLECTION") != true) {
      requirements = ark4_requirements;
    }
  }
  if (requirements != null && requirements.len() > 0) {
    foreach (requirement in requirements) {
      local material_data = {
          "material": requirement.material,
          "required": requirement.required,
        };
      local arked = Game_GetWorldStateAsInteger ("ARK_MATERIALS", requirement.material, 0);
      if (arked >= requirement.required) {
        if (arked > requirement.required) Engine_Warning("mod-ark-progress material has more stashed than required, material:" + requirement.material.tostring());
        material_data.status <- "completed";
      } else {
        material_data.status <- "missing";
        material_data.arked <- arked;
        local owned = Game_GetNumberOfMaterialsStoragePlusCarried (requirement.material);
        if (owned == null) owned = 0;
        material_data.owned <- owned;
      }
      ark.push(material_data);
    }
  }
  return ark;
}


function Mod_ArkProgress_OnInterval_ArkEntrance (ark, same) {
  local prop_kvs = Actor_GetPropActorKeyValueStore (ark, "mod_ark_progress");
  local text = "";
  local ark = Mod_ArkProgress_Calculate();
  if (ark != null && ark.len() > 0) {
    local icons_per_line = ark.len() > 18 ? 4 : 1;
    local dot = "|img src='ui/gfx/dot-white.png' scale=0.8|";
    local icon_count = 0;
    local spacer = "";
    foreach (material_data in ark) {
      local stored = Game_GetNumberOfMaterialsStoredAllTime (material_data.material);
      local is_known = stored != null && stored > 0 ? true : false;
      spacer = icon_count % icons_per_line == 0 ? "\n" : " ";
      switch (material_data.status) {
        case "missing":
          text += (text == "" ? "" : spacer)
            + (is_known ? "[MATERIAL_ICON=" + material_data.material + "]" : "|img src='controller-art/wasdmouse/button-question.png' scale=1.536|")
            + (material_data.required - material_data.arked <= material_data.owned
              ? "|#b4b400b4|" + dot + dot + "|#ffffff00|" + dot + "|#ffffffff|"
              : "|#ff0000ff|" + dot + "|#ffffff00|" + dot + dot + "|#ffffffff|");
          break;
        case "completed":
          text += (text == "" ? "" : spacer)
            + (is_known ? "[MATERIAL_ICON=" + material_data.material + "]" : "|img src='controller-art/wasdmouse/button-question.png' scale=1.536|")
            + "|#00b400b4|" + dot + dot + dot + "|#ffffffff|";
          break;
      }
      icon_count++;
    }
    for (local count = icon_count; count < ceil(icon_count.tofloat() / icons_per_line.tofloat()) * icons_per_line; count++) {
      text += "|#ffffff00| [MATERIAL_ICON=BEAM_GUN_BATTERY]" + dot + dot + dot;
    }
    text = Game_GetConvertedString (text);
    text = string_replace (text, ".png' scale=0.5 offset=2|", ".png' scale=1.2|");
  }
  KeyValueStore_SetKeyValueString (prop_kvs, "text_not_localized", text);
}


function Mod_ArkProgress_OnEnter_PointOfInterestInfo () {
  if (UI_GetProperty ("Type", "textbox.text") == LocalizeText("Entryway")) {
    local coordinates = UI_GetProperty ("Coordinates", "textbox.text");
    local stage = Stage_GetFilename();
    if ((stage == "stages/island/index.xml" && UI_GetProperty ("Name", "textbox.text") == "\"" + LocalizeText("The Ark") + "\"")
    || stage == "stages/special/the-ark.stage" || (stage.len() >= 36 && stage.slice(0, 29) == "stages/special/the-ark-level-")) {
      local desc = "";
      local ark = Mod_ArkProgress_Calculate();
      if (ark == null || ark.len() == 0) {
        desc += "???\n\n";
        local requirements = null;
        if (Game_IsQuestPhaseCompleted ("quests/the-ark.nut", "COMPLETE_ALL_COLLECTIONS") != true) {
          requirements = ark_requirements;
        } else if (Game_IsAudioLogListened ("dysmantle/ark.xml", "ARK_LEVEL_4_COLLECTION") != true) {
          requirements = ark4_requirements;
        }
        if (requirements != null && requirements.len() > 0) {
          foreach (requirement in requirements) {
            local stored = Game_GetNumberOfMaterialsStoredAllTime (requirement.material);
            desc += stored != null && stored > 0 ? "[MATERIAL_ICON=" + requirement.material + "]" : "|img src='controller-art/wasdmouse/button-question.png' scale=0.7 offset=2|";
          }
        }
        desc += "\n\n???";
      } else {
        foreach (material_data in ark) {
          local stored = Game_GetNumberOfMaterialsStoredAllTime (material_data.material);
          local is_known = stored != null && stored > 0 ? true : false;
          switch (material_data.status) {
            case "missing":
              desc += (desc == "" ? "" : "   ")
                + (is_known ? "[MATERIAL_ICON=" + material_data.material + "]" : "|img src='controller-art/wasdmouse/button-question.png' scale=0.7 offset=2|")
                + (material_data.required - material_data.arked <= material_data.owned ? "|#ffff00|" : "|#ff0000|")
                + material_data.arked.tostring() + "/" + material_data.required.tostring() + "(" + material_data.owned.tostring() + ")"
                + "|#ffffff|";
              break;
            case "completed":
              desc += (desc == "" ? "" : "   ")
                + (is_known ? "[MATERIAL_ICON=" + material_data.material + "]" : "|img src='controller-art/wasdmouse/button-question.png' scale=0.7 offset=2|")
                + "|#00ff00|" + material_data.required.tostring() + "|#ffffff|";
              break;
          }
        }
      }
      desc = Game_GetConvertedString (desc);
      UI_SetProperty ("Desc", "textbox.textbox_width", 810);
      UI_SetProperty ("Desc", "scale", 0.67);
      UI_SetProperty ("Desc", "localize", false);
      UI_SetProperty ("Desc", "textbox.text", desc);
      UI_SendScreenMessage ("Stage", "mod_ark_progress_time_message", Stage_GetTimeMilliseconds().tostring());
    }
  }
}


function Mod_ArkProgress_OnDeathStart_Material (material, same) {
  UI_SendScreenMessage ("Stage", "mod_ark_progress_time_message", (Stage_GetTimeMilliseconds() + debounce_realseconds.tofloat() * 1000.0).tostring());
}


function Mod_ArkProgress_OnUpdate_Stage (tdelta) {
  if (next_stageseconds != null && next_stageseconds < Stage_GetTimeMilliseconds()) {
    next_stageseconds = null;
    UI_SendScreenMessage ("Stage", "mod_ark_progress_hud", Game_GetWorldStateAsInteger ("MODS", "ark_progress_hud", 0).tostring());
  }
}


function Mod_ArkProgress_OnLeave_PauseMenu() {
  UI_SendScreenMessage ("Stage", "mod_ark_progress_time_message", Stage_GetTimeMilliseconds().tostring());
}


function Mod_ArkProgress_OnScreenMessage_Stage (key, value) {
  if (key != null) {
    switch (key) {
      case "mod_ark_progress_hud":
        local progress = "";
        if (value == "1") {
          local ark = Mod_ArkProgress_Calculate();
          if (ark != null && ark.len() > 0) {
            foreach (material_data in ark) {
              local stored = Game_GetNumberOfMaterialsStoredAllTime (material_data.material);
              if (material_data.status == "missing" && material_data.owned < material_data.required - material_data.arked) {
                progress += (progress == "" ? "" : " ")
                  + (stored != null && stored > 0 ? "[MATERIAL_ICON=" + material_data.material + "]" : "|img src='controller-art/wasdmouse/button-question.png' scale=0.7 offset=2|")
                  + (material_data.required - material_data.arked - material_data.owned).tostring();
              }
            }
            progress = Game_GetConvertedString (progress);
          }
        }
        UI_SetProperty ("mod_ark_progress", "textbox.text", progress);
        break;
      case "mod_ark_progress_time_message":
        next_stageseconds = value.tointeger();
        break;
    }
  }
}


function Mod_ArkProgress_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_ark_progress_hud":
        local enabled = UI_GetProperty ("mod_ark_progress_hud", "checkbox.value");
        Game_SetWorldState ("MODS", "ark_progress_hud", enabled.tostring());
        UI_SendScreenMessage ("Stage", "mod_ark_progress_hud", enabled.tostring());
        break;
      case "mod_ark_progress_hud_title":
        Mods_Info_Popup (
            LocalizeText("Ark progress HUD"),
            LocalizeText("Display a list of the materials you are missing for the Ark quest on an always on-screen overlay."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-ark-progress-video")}] );
        break;
    }
  }
}


function Mod_ArkProgress_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_ark_progress_hud_notice", "textbox.text", LocalizeText("You need to progress the Ark quest to toggle this checkbox."));
  UI_SetProperty ("mod_ark_progress_hud", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "ark_progress_hud", 0));
  local is_started = Game_IsQuestPhaseCompleted ("quests/the-ark.nut", "ENTER_ARK") == true ? true : false;
  UI_SetVisible ("mod_ark_progress_hud_notice", is_started ? false : true);
  UI_SetProperty ("mod_ark_progress_hud", "active", is_started);
  UI_SetProperty ("mod_ark_progress_hud_title", "textbox.text", LocalizeText("Ark progress HUD"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
