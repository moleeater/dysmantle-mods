// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local components = {
    "CodeEditor"         : [ { "scale": 0.13, "position.x": -0.47, "position.y": -0.535, }, ],
    "CookingRecipeInfo"  : [ { "scale": 0.15, "position.x": -0.4 , "position.y":  0.41 , }, ],
    "JoinCoopPlayer"     : [ { "scale": 0.15, "position.x": -0.4 , "position.y":  0.38 , }, ],
    "MaterialInfo"       : [ { "scale": 0.15, "position.x": -0.41, "position.y":  0.39 , }, ],
    "MedalInfo"          : [ { "scale": 0.15, "position.x": -0.41, "position.y":  0.4  , }, ],
    "PauseMenu"          : [
        { "name": "mod_wiki_creature"   , "scale": 0.25, "position.x":  2.5 , "position.y": -0.46 , "parent": "CollectionScrollBar_Creatures", },
        { "name": "mod_wiki_quest"      , "scale": 0.2 , "position.x":  0.05, "position.y":  0.78 , "parent": "QuestImage", "image.bitmap": "ui/gfx/mods/mod-wiki-black.png", "alpha": 0.9, },
      ],
    "PointOfInterestInfo": [ { "scale": 0.15, "position.x": -0.42, "position.y": -0.38 , }, ],
    "Profiles"           : [ { "scale": 0.15, "position.x": -0.42, "position.y": -0.39 , }, ],
    "RecipeInfo"         : [ { "scale": 0.18, "position.x": -0.41, "position.y":  0.4  , }, ],
    "SelectInventoryItem": [ { "scale": 0.15, "position.x":  0.46, "position.y": -0.4  , "parent": "upper_details", }, ],
    "UpsellDLC1"         : [ { "scale": 0.15, "position.x": -0.45, "position.y":  0.41 , }, ],
    "UpsellDLC2"         : [ { "scale": 0.15, "position.x": -0.45, "position.y":  0.41 , "image.bitmap": "ui/gfx/mods/mod-wiki-black.png", }, ],
    "UpsellDLC3"         : [ { "scale": 0.15, "position.x": -0.45, "position.y":  0.41 , }, ],
  };
local default_properties = {
    "parent": "panel", "name": "mod_wiki",
    "inherit": "DefaultImage",
    "align": NX_ALIGN_VCENTER | NX_ALIGN_HCENTER,
    "image.anim_mode": 4,
    "image.bitmap": "ui/gfx/mods/mod-wiki.png",
    "alpha": 0.67,
    "selection_priority": 50,
    "can_be_accessed_with_gamepads": false,
  };
local wiki_root = "https://dysmantle.fandom.com/wiki/";


function urlencode (str, replace_space_with_underscore = false) {
  local url = "";
  if (str != null) {
    foreach (char in str) {
      if (replace_space_with_underscore && char == 32) char = 95;
      url += "%" + format("%02X", char);
    }
  }
  return url;
}


function Mod_Wiki_IsEnglish() {
  local lang = DM_GetArrayNodeValue ("save://index.xml", "!SETTINGS", "USER_SELECTED_LANGUAGE", "value");
  return lang == null || lang == "" ? true : false;
}


function Mod_Wiki_SetLink (component, slug, root_slug = "") {
  if (UI_GetProperty (component, "name") == component) {
    if (slug == null || slug == "") {
      UI_SetVisible (component, false);
    } else {
      UI_SetProperty (component, "on_click_script_call", "NX_CallExtension (\"OpenURL\", \"" + wiki_root + (root_slug != "" ? urlencode (root_slug, true) + "/" : "") + urlencode (slug, true) + "\");");
      UI_SetVisible (component, true);
    }
  }
}


function Mod_Wiki_OnUpdate_UI (tdelta) {
  local screen = UI_GetActiveScreenName();
  if (screen != null && components.rawin(screen) == true) {
    switch (screen) {
      case "PauseMenu":
        Mod_Wiki_SetLink ("mod_wiki_creature", Mod_Wiki_IsEnglish() ? UI_GetProperty ("CreatureName", "textbox.text") : "Creatures");
        Mod_Wiki_SetLink ("mod_wiki_quest", Mod_Wiki_IsEnglish() ? UI_GetProperty ("QuestName", "textbox.text") : "Quests");
        break;
      case "SelectInventoryItem":
        local slug = "Crafting";
        if (Mod_Wiki_IsEnglish()) {
          slug = UI_GetProperty ("ItemDisplayName", "textbox.text");
          local captured = regexp("(.+)( \\+[0-9]+)").capture(slug);
          if (captured != null && captured[1] != null && captured[1].end != 0 && captured[2] != null && captured[2].begin != 0 && captured[2].end != 0) {
            slug = slug.slice(captured[1].begin, captured[1].end)
          }
        }
        Mod_Wiki_SetLink ("mod_wiki", slug);
        break;
    }
  }
}


function Mod_Wiki_OnEnter_UI() {
  local screen = UI_GetActiveScreenName();
  if (screen != null && components.rawin(screen) == true && this.rawin("UI_CreateComponent") == true) {
    foreach (component_index, component in components[screen]) {
      local properties = {};
      foreach (property, value in default_properties) {
        properties.rawset(property, value);
      }
      foreach (property, value in component) {
        properties.rawset(property, value);
      }
      if (UI_GetProperty (properties.name, "name") != properties.name && UI_GetProperty (properties["parent"], "name") == properties["parent"]) {
        UI_CreateComponent (properties.name, properties.inherit);
        foreach (property, value in properties) {
          switch (property) {
            case "name":
            case "inherit":
              break;
            default:
              if (typeof value == "array" && value.len() == 4) {
                UI_SetProperty (properties.name, property, value[0], value[1], value[2], value[3]);
              } else {
                UI_SetProperty (properties.name, property, value);
              }
          }
        }
      }
    }
    switch (screen) {
      case "CodeEditor":
        Mod_Wiki_SetLink ("mod_wiki", "API Docs", "Modding");
        break;
      case "CookingRecipeInfo":
        Mod_Wiki_SetLink ("mod_wiki", Mod_Wiki_IsEnglish() ? UI_GetProperty ("ItemDisplayName", "textbox.text") : "Cooking Recipes");
        break;
      case "JoinCoopPlayer":
        Mod_Wiki_SetLink ("mod_wiki", "Multiplayer", "Dysmantle");
        break;
      case "MaterialInfo":
        Mod_Wiki_SetLink ("mod_wiki", Mod_Wiki_IsEnglish() ? UI_GetProperty ("ItemDisplayName", "textbox.text") : "Materials");
        break;
      case "MedalInfo":
        Mod_Wiki_SetLink ("mod_wiki", Mod_Wiki_IsEnglish() ? UI_GetProperty ("ItemDisplayName", "textbox.text") : "Medals");
        break;
      case "PointOfInterestInfo":
        local poi_type = UI_GetProperty ("Type", "textbox.text");
        if (poi_type != null) {
          switch (poi_type) {
            case LocalizeText("Quest"):
              Mod_Wiki_SetLink ("mod_wiki", Mod_Wiki_IsEnglish() ? UI_GetProperty ("Name", "textbox.text") : "Quests");
              break;
            case LocalizeText("Enemy Tough"):
              Mod_Wiki_SetLink ("mod_wiki", Mod_Wiki_IsEnglish() ? UI_GetProperty ("Name", "textbox.text") : "Creatures");
              break;
            default:
              Mod_Wiki_SetLink ("mod_wiki", null);
          }
        }
        break;
      case "Profiles":
        Mod_Wiki_SetLink ("mod_wiki", "Save Management", "Dysmantle");
        break;
      case "RecipeInfo":
        local slug = "Crafting";
        if (Mod_Wiki_IsEnglish()) {
          slug = UI_GetProperty ("ItemDisplayName", "textbox.text");
          local item_type = UI_GetProperty ("ItemType", "textbox.text");
          if (item_type != null) {
            switch (item_type) {
              case LocalizeText("Skill"):
                local captured = regexp("(.+)( I| II| III| IV| V| VI| VII| VIII| IX| X)").capture(slug);
                if (captured != null && captured[1] != null && captured[1].end != 0 && captured[2] != null && captured[2].begin != 0 && captured[2].end != 0) {
                  slug = slug.slice(captured[1].begin, captured[1].end)
                }
                break;
              case LocalizeText("Tool"):
              case LocalizeText("Special Item"):
              case LocalizeText("Trinket"):
              case LocalizeText("Feature"):
                local captured = regexp("(.+)( \\+[0-9]+)").capture(slug);
                if (captured != null && captured[1] != null && captured[1].end != 0 && captured[2] != null && captured[2].begin != 0 && captured[2].end != 0) {
                  slug = slug.slice(captured[1].begin, captured[1].end)
                }
                break;
            }
          }
        }
        Mod_Wiki_SetLink ("mod_wiki", slug);
        break;
      case "UpsellDLC1": Mod_Wiki_SetLink ("mod_wiki", "Underworld"); break;
      case "UpsellDLC2": Mod_Wiki_SetLink ("mod_wiki", "Doomsday"); break;
      case "UpsellDLC3": Mod_Wiki_SetLink ("mod_wiki", "Pets and Dungeons"); break;
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
