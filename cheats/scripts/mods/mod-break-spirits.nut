// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_BreakSpirits_OnThink_ManaSpirit (spirit) {
  if (Game_GetWorldStateAsInteger ("MODS", "break_spirits_enabled", 0) == 1) {
    StageObject_SetKeyValueFloat (spirit, "vulnerability_timer", 10.0);
  }
}


function Mod_BreakSpirits_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_break_spirits_enabled":
        Game_SetWorldState ("MODS", "break_spirits_enabled", UI_GetProperty ("mod_break_spirits_enabled", "checkbox.value") == 1 ? "1" : "0");
        break;
      case "mod_break_spirits_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Break spirits") + " |img src='emojis/star.png' scale=1 offset=2|",
            LocalizeText("Make mana spirits vulnerable by default, no need for mana-infused tools."));
        break;
    }
  }
}


function Mod_BreakSpirits_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetVisible ("mod_break_spirits_enabled_title", IAP_IsItemPurchased ("DLC1") == true);
  UI_SetProperty ("mod_break_spirits_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "break_spirits_enabled", 0));
  UI_SetProperty ("mod_break_spirits_enabled_title", "textbox.text", "|img src='emojis/star.png' scale=0.4 offset=0|  " + LocalizeText("Break spirits"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
