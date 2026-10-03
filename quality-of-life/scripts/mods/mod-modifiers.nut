// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local recipes = {
    "MOD_ONE_HIT_OBJECTS"     : "one_hit_objects",
    "MOD_GOD_MODE"            : "god_mode",
    "MOD_FASTER_MELEE"        : "faster_melee",
    "MOD_INSTANT_FARMING"     : "instant_farming",
    "MOD_SPEED_FISHING"       : "speed_fishing",
    "MOD_MORE_MELEE_TARGETS"  : "more_melee_targets",
  };


Include ("scripts/mods/mods-info.nut");


function Mod_Modifiers_IsModifierStageLimited (mod_name, modifier_data) {
  local is_limited = null;
  if (modifier_data.rawin("limit_stages") == true) {
    if (modifier_data.limit_stages.len() > 0) {
      is_limited = false;
      local stage = Stage_GetFilename();
      if (stage != null) {
        foreach (limitation in modifier_data.limit_stages) {
          switch (limitation) {
            case "is_tomb":
              is_limited = Game_IsTombStage (stage) == true ? true : is_limited;
              break;
            case "is_pet_stage":
              is_limited = Game_IsPetStage (stage) == true ? true : is_limited;
              break;
            case "has_force_player_unarmed":
              local force_player_unarmed = false;
              local stage_kvs = Stage_GetKeyValueStore();
              if (stage_kvs != null) {
                force_player_unarmed = KeyValueStore_GetKeyValue (stage_kvs, "force_player_unarmed", false);
              }
              is_limited = force_player_unarmed ? true : is_limited;
              break;
          }
        }
      }
    }
  }
  return is_limited;
}


function Mod_Modifiers_OnEnter_Stage (all_modifiers) {
  foreach (recipe, mod_name in recipes) {
    if (Game_IsRecipeCrafted (recipe) == true) {
      if (all_modifiers.rawin(mod_name) == true) {
        local modifier_data = all_modifiers[mod_name];
        Game_SetWorldState ("MODS", mod_name + "_enabled", "1");
        foreach (player_index in [0,1]) {
          local player = Game_GetPlayerActor (player_index);
          if (player != null) {
            foreach (modifier_id, modifier_value in modifier_data.modifiers) {
              Game_SetTemporaryModifier (player, "mod_" + mod_name + "_enabled", 50000000.0, modifier_id, modifier_value);
            }
          }
        }
      }
      Game_CheatCraftOrUncraftRecipe (recipe, false);
    }
  }
  Game_CheatCraftOrUncraftRecipe ("MOD_FORAGING", false);
  Game_CheatCraftOrUncraftRecipe ("MOD_STUNNING_PETS", false);
  Game_CheatCraftOrUncraftRecipe ("MOD_HYPERCRITICAL", false);
  foreach (mod_name, modifier_data in all_modifiers) {
    local is_limited = Mod_Modifiers_IsModifierStageLimited (mod_name, modifier_data);
    if (is_limited != null) {
      local state = Game_GetWorldState ("MODS", mod_name + "_" + modifier_data.state_name);
      if (state == null) state = 0;
      state = state.tofloat();
      if (state > 0.0) {
        if (is_limited) {
          state = 0.0;
        }
        foreach (player_index in [0,1]) {
          local player = Game_GetPlayerActor (player_index);
          if (player != null) {
            foreach (modifier_id, modifier_value in modifier_data.modifiers) {
              Game_SetTemporaryModifier (player, "mod_" + mod_name + "_" + modifier_data.state_name, state == 0 ? 0.0 : 50000000.0, modifier_id, modifier_value * state.tofloat());
            }
          }
        }
      }
    }
  }
}


function Mod_Modifiers_OnCoopPlayerJoined_ProtagonistReactions (all_modifiers, primary_player, coop_player) {
  foreach (mod_name, modifier_data in all_modifiers) {
    local state = Game_GetWorldState ("MODS", mod_name + "_" + modifier_data.state_name);
    if (state == null) state = 0;
    state = state.tofloat();
    if (Mod_Modifiers_IsModifierStageLimited (mod_name, modifier_data) == true) {
      state = 0.0;
    }
    foreach (modifier_id, modifier_value in modifier_data.modifiers) {
      Game_SetTemporaryModifier (coop_player, "mod_" + mod_name + "_" + modifier_data.state_name, state == 0 ? 0.0 : 50000000.0, modifier_id, modifier_value * state.tofloat());
    }
  }
}


function Mod_Modifiers_OnClick_OptionsUnified (all_modifiers, clicked) {
  if (clicked != null && clicked.len() > 6 && clicked.slice(0, 4) == "mod_") {
    local is_title = false;
    local option_name = clicked.slice(4);
    if (option_name.len() > 6 && option_name.slice(option_name.len() - 6) == "_title") {
      option_name = option_name.slice(0, option_name.len() - 6);
      is_title = true;
    }
    local option_parts = split(option_name, "_");
    if (option_parts.len() > 1) {
      option_parts.remove(option_parts.len() - 1);
      local mod_name = option_parts.reduce(@(first, next) (first == null ? "" : first) + (next == null ? "" : "_" + next));
      if (all_modifiers.rawin(mod_name) == true) {
        local modifier_data = all_modifiers[mod_name];
        if (is_title) {
          local video_url = null;
          if (modifier_data.rawin("video_url") == true) {
            video_url = modifier_data["video_url"];
          }
          Mods_Info_Popup (
              LocalizeText(modifier_data.info_title),
              LocalizeText(modifier_data.info_text),
              video_url == null ? [] : [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration", "OpenURL": LocalizeText(video_url)}] );
        } else {
          local state = 0;
          switch (modifier_data.state_name) {
            case "enabled":
              state = UI_GetProperty (clicked, "checkbox.value") == 1 ? 1 : 0;
              break;
            case "amount":
            case "percent":
              state = round(UI_GetProperty (clicked, "slider.value"));
              break;
          }
          Game_SetWorldState ("MODS", mod_name + "_" + modifier_data.state_name, state.tostring());
          foreach (player_index in [0,1]) {
            local player = Game_GetPlayerActor (player_index);
            if (player != null) {
              foreach (modifier_id, modifier_value in modifier_data.modifiers) {
                Game_SetTemporaryModifier (player, "mod_" + mod_name + "_" + modifier_data.state_name, state == 0 ? 0.0 : 50000000.0, modifier_id, modifier_value * state.tofloat());
              }
            }
          }
          Game_LogEvent ("MOD_" + mod_name.toupper(), modifier_data.state_name == "enabled" ? (state == 0 ? "disabled" : "enabled") : state.tostring());
        }
      }
    }
  }
}


function Mod_Modifiers_OnEnter_OptionsUnified (all_modifiers, stage_in_stack) {
  foreach (mod_name, modifier_data in all_modifiers) {
    UI_SetProperty ("mod_" + mod_name + "_" + modifier_data.state_name + "_title", "textbox.text", LocalizeText(modifier_data.info_title));
    UI_SetVisible ("mod_" + mod_name + "_" + modifier_data.state_name + "_title", false);
  }
  if (stage_in_stack) {
    foreach (mod_name, modifier_data in all_modifiers) {
      UI_SetVisible ("mod_" + mod_name + "_" + modifier_data.state_name + "_title", true);
      switch (modifier_data.state_name) {
        case "enabled":
          UI_SetProperty ("mod_" + mod_name + "_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", mod_name + "_enabled", 0));
          break;
        case "amount":
        case "percent":
          if (modifier_data.rawin("max_value") == true) {
            UI_SetProperty ("mod_" + mod_name + "_" + modifier_data.state_name, "slider.max_value", modifier_data.max_value.tofloat());
          }
          local state = Game_GetWorldState ("MODS", mod_name + "_" + modifier_data.state_name);
          if (state == null) state = 0.0;
          if (UI_GetProperty ("mod_" + mod_name + "_" + modifier_data.state_name + "_number", "name") == "mod_" + mod_name + "_" + modifier_data.state_name + "_number") {
            UI_SetProperty ("mod_" + mod_name + "_" + modifier_data.state_name + "_number", "editbox.text", state.tostring());
          }
          UI_SetProperty ("mod_" + mod_name + "_" + modifier_data.state_name, "slider.value", state.tofloat());
          break;
      }
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
