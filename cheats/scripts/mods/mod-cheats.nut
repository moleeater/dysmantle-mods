// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
if (NX_FileExists ("actors/collectibles/tarot.xml") || NX_FileExists ("scripts/interactions/tarot.nut") || NX_FileExists ("ui/tarot_templates.xml")
|| NX_FileExists ("ui/collectibles/tarotcard.nut") || NX_FileExists ("ui/collectibles/tarotcard.xml")
|| NX_FileExists ("actors/interactives/farming-mushroom_brown.xml") || NX_FileExists ("docs://Mega Quality Of Life Balance Mod/mod-info.xml")
|| NX_FileExists ("ugc://3711913031/mod-info.xml") || NX_FileExists ("ugc://3703339560/mod-info.xml")) return null;


local mod_infos = {
    "cheats": {
        "title"  : "|img src='achievements/FIGHTER_BASIC.png' scale=1 offset=2| " + LocalizeText("Cheats"),
        "text"   : "40+ cheat mods packed into one modpack, with a settings interface so you can enable what you want.",
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| playlist",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-cheats-playlist")}],
      },
  };
local mod_sections = {
    "spawn"    : "Spawn",
    "death"    : "Death",
    "traversal": "Traversal",
    "weapons"  : "Weapons",
    "loot"     : "Loot",
    "time"     : "Time",
    "minigames": "Mini-games",
  };


Include ("scripts/mods/mods-info.nut");


function Mod_Cheats_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    if (clicked == "mod_cheats_use") {
      Game_SetWorldState ("MODS", "cheats_used", "1");
      UI_SetVisible ("mod_cheats_use", false);
      UI_SetVisible ("mod_cheats_use_spacer", false);
      foreach (section_name, section_title in mod_sections) {
        local accordion = "mod_cheats_" + section_name + "_accordion";
        UI_SetProperty (accordion, "accordion.is_open", true);
        UI_SetProperty (accordion, "active", true);
        UI_SetVisible (accordion, true);
      }
    }
    if (clicked.len() > 4 + 6 && clicked.slice(0, 4) == "mod_" && clicked.slice(clicked.len() - 6) == "_title") {
      local mod_name = clicked.slice(4, clicked.len() - 6);
      if (mod_infos.rawin(mod_name) == true) {
        local mod_data = mod_infos[mod_name];
        local buttons = [];
        if (mod_data.rawin("buttons") == true) {
          buttons = mod_data["buttons"];
        }
        Mods_Info_Popup (LocalizeText(mod_data.title), LocalizeText(mod_data.text), buttons);
      }
    }
  }
}


function Mod_Cheats_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetVisible ("mods_incompatibility", false);
  UI_SetVisible ("mods_notingame", stage_in_stack == true ? false : true);
  UI_SetVisible ("mods_notingame_spacer", stage_in_stack == true ? false : true);
  UI_SetVisible ("mod_cheats_title", stage_in_stack == true ? true : false);
  local used = Game_GetWorldState ("MODS", "cheats_used") == "1";
  UI_SetProperty ("mod_cheats_use", "button.text", LocalizeText("Activate"));
  UI_SetVisible ("mod_cheats_use", stage_in_stack == true && ! used);
  UI_SetVisible ("mod_cheats_use_spacer", stage_in_stack == true && ! used);
  foreach (section_name, section_title in mod_sections) {
    local accordion = "mod_cheats_" + section_name + "_accordion";
    UI_SetProperty (accordion, "accordion.text_left", "   |img src='achievements/FIGHTER_BASIC.png' scale=0.3 offset=2| " + section_title);
    UI_SetProperty (accordion, "accordion.is_open", used);
    UI_SetProperty (accordion, "active", used);
    UI_SetVisible (accordion, stage_in_stack == true);
  }
  foreach (mod_name, mod_data in mod_infos) {
    UI_SetProperty ("mod_" + mod_name + "_title", "textbox.text", mod_data.title);
  }
  UI_SetVisible ("mod_cheats_bottom_spacer", stage_in_stack == true);
  UI_SetVisible ("mods_info", stage_in_stack == true);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
