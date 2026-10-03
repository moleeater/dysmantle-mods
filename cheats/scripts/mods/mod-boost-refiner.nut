// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local used_refiner = null;


Include ("scripts/mods/mods-info.nut");


function Mod_BoostRefiner_OnScreenMessage_Refiner (key, value) {
  if (key == "refiner_actor") {
    used_refiner = null;
    local refiners = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, "REFINER");
    if (refiners != null && refiners.len() > 0) {
      foreach (refiner in refiners) {
        if (refiner.tointeger() == value.tointeger()) {
          used_refiner = refiner;
          break;
        }
      }
    }
    if (used_refiner != null) {
      local enabled = Game_GetWorldStateAsInteger ("MODS", "boost_refiner_enabled", 0) == 1 ? true : false;
      UI_SetVisible ("mod_boost_refiner_button", enabled);
      UI_SetProperty ("aligner_buttons", "aligner.area_width", enabled ? 800 : 550);
      UI_SetProperty ("aligner_buttons", "position.x", enabled ? -0.072 : 0);
    }
  }
}


function Mod_BoostRefiner_OnUpdate_Refiner (tdelta) {
  if (used_refiner != null) {
    local amount_to_refine = StageObject_GetKeyValue (used_refiner, "amount_to_refine", 0);
    local time_started = StageObject_GetKeyValue (used_refiner, "time_started", 1.0);
    UI_SetProperty ("mod_boost_refiner_button", "active", amount_to_refine != null && amount_to_refine > 0 && time_started != 1.0 ? true : false);
  }
}


function Mod_BoostRefiner_OnClick_Refiner (clicked) {
  if (clicked == "mod_boost_refiner_button" && used_refiner != null) {
    UI_SetProperty ("Start", "active", false);
    UI_SetProperty ("Stop", "active", false);
    StageObject_SetKeyValueFloat (used_refiner, "time_started", 1.0);
  }
}


function Mod_BoostRefiner_OnEnter_Refiner() {
  UI_SetProperty ("mod_boost_refiner_button", "button.text", "|#c0c0c0||img src='emojis/package.png' scale=1.5 offset=2||#000000| " + LocalizeText("Boost"));
  UI_SetProperty ("Start", "active", true);
  UI_SetProperty ("Stop", "active", true);
}


function Mod_BoostRefiner_HoldDownButtonIsInteractionAvailable_Refiner (refiner, player) {
  local amount_to_refine = StageObject_GetKeyValue (refiner, "amount_to_refine", 0);
  local is_available = amount_to_refine != null && amount_to_refine > 0 ? true : false;
  if (is_available) {
    Actor_SetInteractionText (refiner, "mod_boost_refiner_hold_down_button", "|img src='emojis/package.png' scale=0.5 offset=2| " + LocalizeText("Boost"));
  }
  return is_available;
}


function Mod_BoostRefiner_HoldDownButton_Refiner (refiner, player) {
  if (Actor_IsAnimationPlaying (player, "activate_material_transporter") != true) {
    Actor_QueueActionPlayAnimationWithParameters (player, "activate_material_transporter", 2.0, 0.0, true);
  }
  local actor_type = Actor_GetActorType (refiner);
  local position = StageObject_GetStagePosition (refiner);
  if (actor_type != null && position != null) {
    switch (actor_type) {
      case "actors/interactives/smelter.xml":
      case "actors/buildables/recycler.xml":
        Stage_SpawnEffect ("effects/battery-birth.xml", position[0], position[1], position[2] - 90.0, 0.0);
        break;
      default:
        Stage_SpawnEffect ("effects/absorb.xml", position[0], position[1], position[2], 0.0);
    }
  }
  StageObject_SetKeyValueFloat (refiner, "time_started", 1.0);
}


function Mod_BoostRefiner_OnGameStart_Refiner (refiner, same) {
  local enabled = Game_GetWorldStateAsInteger ("MODS", "boost_refiner_enabled", 0) == 1 && Game_GetPrimaryPlayerControllerTypeAsAsString() != "TOUCH" ? true : false;
  if (Actor_IsInteractionEnabled (refiner, "mod_boost_refiner_hold_down_button") != enabled) {
    Actor_SetInteractionEnabled (refiner, "mod_boost_refiner_hold_down_button", enabled);
  }
}


function Mod_BoostRefiner_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_boost_refiner_enabled":
        local enabled = UI_GetProperty ("mod_boost_refiner_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "boost_refiner_enabled", enabled ? "1" : "0");
        local interaction_enabled = enabled && Game_GetPrimaryPlayerControllerTypeAsAsString() != "TOUCH";
        local refiners = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, "REFINER");
        if (refiners != null && refiners.len() > 0) {
          foreach (refiner in refiners) {
            if (Actor_IsInteractionEnabled (refiner, "mod_boost_refiner_hold_down_button") != interaction_enabled) {
              Actor_SetInteractionEnabled (refiner, "mod_boost_refiner_hold_down_button", interaction_enabled);
            }
          }
        }
        break;
      case "mod_boost_refiner_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Boost refiner"),
            LocalizeText("Boost sawmills, smelters, recyclers to finish in an instant. Long press the Target Lock button when near the refiner.")
                + " " + LocalizeText("Or on mobile UI, it also shows a button on the refiner screen."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-boost-refiner-video")}] );
        break;
    }
  }
}


function Mod_BoostRefiner_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_boost_refiner_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "boost_refiner_enabled", 0));
  UI_SetProperty ("mod_boost_refiner_enabled_title", "textbox.text", LocalizeText("Boost refiner"));
  UI_SetVisible ("mod_boost_refiner_enabled_title", true);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
