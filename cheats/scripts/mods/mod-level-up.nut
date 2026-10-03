// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_LevelUp_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_level_up_amount":
        local index = UI_GetProperty ("mod_level_up_amount", "drop_down_list.selected_line_index");
        UI_SetProperty ("mod_level_up_activate", "active", index != null && index != 0);
        break;
      case "mod_level_up_activate":
        local index = UI_GetProperty ("mod_level_up_amount", "drop_down_list.selected_line_index");
        if (index != null && index != 0) {
          local curr_xp = Game_GetExperiencePoints();
          if (curr_xp == null) curr_xp = 0;
          local max_xp = Game_GetExperiencePointsRequiredForLevel (300);
          if (max_xp == null) max_xp = 630000000;
          max_xp += 16;
          if (curr_xp.tointeger() < max_xp.tointeger()) {
            local add_xp = 0;
            local selected = UI_GetDropDownListLineIdByIndex ("mod_level_up_amount", index.tointeger());
            switch (selected) {
              case "": break;
              case "300":
                add_xp = max_xp.tointeger() - curr_xp.tointeger();
                break;
              default:
                local level = 1;
                do {
                  level++;
                  local xp_for_level = Game_GetExperiencePointsRequiredForLevel (level);
                  if (xp_for_level != null && curr_xp < xp_for_level) {
                    level--;
                    break;
                  }
                } while (level < 300);
                local req_level = level + selected.tointeger();
                if (req_level > 300) req_level = 300;
                local req_xp = Game_GetExperiencePointsRequiredForLevel (req_level);
                if (req_xp != null) {
                  add_xp = req_xp.tointeger() - curr_xp.tointeger();
                }
                break;
            }
            if (add_xp > 0) {
              local experience_points_percentage_increase = 0.0;
              local player = Game_GetPrimaryPlayerActor();
              if (player != null) {
                local modifiers_kvs = Game_GetAllPlayerModifiersAsKeyValueStore (player);
                if (modifiers_kvs != null) {
                  experience_points_percentage_increase = KeyValueStore_GetKeyValue (modifiers_kvs, "experience_points_percentage_increase");
                  if (experience_points_percentage_increase == null) experience_points_percentage_increase = 0.0;
                }
              }
              Game_AddExperiencePoints (ceil(add_xp.tofloat() / (1.0 + experience_points_percentage_increase.tofloat() / 100.0)));
              Engine_Warning ("+" + add_xp.tostring() + " xp");
              curr_xp = Game_GetExperiencePoints();
              if (curr_xp == null) curr_xp = 0;
              if (curr_xp >= max_xp) {
                UI_SetProperty ("mod_level_up_activate", "active", false);
                UI_SetProperty ("mod_level_up_amount", "active", false);
              }
            }
          }
        }
        break;
      case "mod_level_up_title":
        Mods_Info_Popup (
            LocalizeText("Level Up."),
            LocalizeText("Add experience points to level up your player."));
        break;
    }
  }
}


function Mod_LevelUp_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_level_up_title", "textbox.text", LocalizeText("Level Up."));
  UI_SetProperty ("mod_level_up_activate", "button.text", LocalizeText("Activate"));
  local index = UI_GetProperty ("mod_level_up_amount", "drop_down_list.selected_line_index");
  UI_SetProperty ("mod_level_up_activate", "active", index != null && index != 0);
  UI_RemoveAllDropDownListLines ("mod_level_up_amount");
  UI_AddDropDownListLine ("mod_level_up_amount", "", "");
  UI_AddDropDownListLine ("mod_level_up_amount", "1", "+1");
  UI_AddDropDownListLine ("mod_level_up_amount", "3", "+3");
  UI_AddDropDownListLine ("mod_level_up_amount", "10", "+10");
  UI_AddDropDownListLine ("mod_level_up_amount", "30", "+30");
  UI_AddDropDownListLine ("mod_level_up_amount", "100", "+100");
  UI_AddDropDownListLine ("mod_level_up_amount", "300", "300");
  local curr_xp = Game_GetExperiencePoints();
  if (curr_xp == null) curr_xp = 0;
  local max_xp = Game_GetExperiencePointsRequiredForLevel (300);
  if (max_xp == null) max_xp = 630000000;
  max_xp += 16;
  UI_SetProperty ("mod_level_up_amount", "active", curr_xp < max_xp);
  if (curr_xp >= max_xp) {
    UI_SetProperty ("mod_level_up_activate", "active", false);
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
