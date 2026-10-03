// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local obelisks = {
    "OBELISK_OF_WAR": {
      "modifier_title": "Melee attack speed",
      "modifier_value": "+10%",
      "obelisk_title" : "Obelisk of War",
    },
    "OBELISK_OF_WINTER": {
      "modifier_title": "Cold protection",
      "modifier_value": "+5 C",
      "obelisk_title" : "Obelisk of Winter",
    },
    "OBELISK_OF_SUMMER": {
      "modifier_title": "Heat protection",
      "modifier_value": "+5 C",
      "obelisk_title" : "Obelisk of Summer",
    },
    "OBELISK_OF_WIND": {
      "modifier_title": "Running speed",
      "modifier_value": "+7%",
      "obelisk_title" : "Obelisk of Wind",
    },
    "OBELISK_OF_WATER": {
      "modifier_title": "Evade chance",
      "modifier_value": "+15%",
      "obelisk_title" : "Obelisk of Water",
    },
    "OBELISK_OF_EARTH": {
      "modifier_title": "Damage block",
      "modifier_value": "+8%",
      "obelisk_title" : "Obelisk of Earth",
    },
    "OBELISK_OF_FIRE": {
      "modifier_title": "Critical hit chance",
      "modifier_value": "+6%",
      "obelisk_title" : "Obelisk of Fire",
    },
    "OBELISK_OF_GROWTH": {
      "modifier_title": "Plant grow speed",
      "modifier_value": "+50%",
      "obelisk_title" : "Obelisk of Growth",
    },
    "OBELISK_OF_LIFE": {
      "modifier_title": "Life drain per hit",
      "modifier_value": "+10",
      "obelisk_title" : "Obelisk of Life",
    },
  };
local target_obelisk = "";


function Mod_ObeliskInfo_OnScreenMessage_Obelisk (key, value) {
  if (key == "obelisk_id") {
    target_obelisk = value;
  }
}


function Mod_ObeliskInfo_OnEnter_Obelisk() {
  local active_obelisk = Game_GetPlayerState ("OBELISK");
  if (active_obelisk != target_obelisk) {
    UI_SetProperty ("ItemModifiers2", "textbox.fit_inside_textbox", true);
    UI_SetProperty ("ItemModifiers2", "scale", 0.75);
    local active_text = "|img src='emojis/cross mark.png' scale=0.7 offset=2|";
    if (active_obelisk != null) {
      if (obelisks.rawin(active_obelisk) != true) {
        Engine_Warning("mod-obelisk-info is missing obelisk data, active_obelisk:" + active_obelisk.tostring());
        active_text = "???";
      } else {
        active_text = LocalizeText(obelisks[active_obelisk].obelisk_title)
          + "  (" + LocalizeText(obelisks[active_obelisk].modifier_title) + " |#00ff00|" + obelisks[active_obelisk].modifier_value + "|#ffffff|)";
      }
    }
    local text = "|#999999|" + LocalizeText("Only one Obelisk can be active at the same time.") + "|#ffffff|\n"
      + "|img src='emojis/package.png' scale=0.7 offset=2|  " + LocalizeText("active") + ":  " + active_text;
    UI_SetProperty ("ItemModifiers2", "localize", false);
    UI_SetProperty ("ItemModifiers2", "textbox.text", text);
  }
}


function Mod_ObeliskInfo_OnLeave_Obelisk() {
  UI_SetProperty ("ItemModifiers2", "scale", 0.6247);
  UI_SetProperty ("ItemModifiers2", "textbox.fit_inside_textbox", false);
  UI_SetProperty ("ItemModifiers2", "localize", true);
  UI_SetProperty ("ItemModifiers2", "textbox.text", "Only one Obelisk can be active at the same time.");
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
