// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_PlentyOfFish_OnInterval_FishingSpot (spot, same) {
  if (Game_GetWorldStateAsInteger ("MODS", "plenty_of_fish_enabled", 0) == 1) {
    if (Actor_IsAnimationPlaying (spot, "fishes") != true) {
      Actor_PlayAnimation (spot, "fishes");
    }
  } else {
    if (Actor_IsAnimationPlaying (spot, "fishes") == true && Game_GetFishingTargetActorNumberOfRewardsLeft (spot) == 0) {
      Actor_StopAnimationWithFade (spot, "fishes", 0.0);
    }
  }
}


function Mod_PlentyOfFish_OnCustomTriggerDown_FishingRod (spot_data, player, rod, spot) {
  if (Game_GetWorldStateAsInteger ("MODS", "plenty_of_fish_enabled", 0) == 1) {
    spot_data.spot = spot;
    if (Actor_GetActorType (spot_data.spot) == "actors/interactives/fishing-spot.xml") {
      local puid = StageObject_GetPersistentUniqueId (spot_data.spot);
      if (puid != null) {
        spot_data.spot_id = "puid_" + puid.tostring();
      }
    }
    if (spot_data.spot_id == null) {
      local position = StageObject_GetStagePosition (spot_data.spot);
      if (position != null) {
        spot_data.spot_id = "spot_" + position[0].tostring() + "_" + position[1].tostring();
      }
    }
  }
}


function Mod_PlentyOfFish_OnCustomUpdate_FishingRod (spot_data, player, rod, tdelta) {
  if (spot_data.spot_id != null && Game_GetWorldStateAsInteger ("MODS", "plenty_of_fish_enabled", 0) == 1) {
    Profile_SetValue ("FISHING", "times_fished_at_spot", spot_data.spot_id, "0");
  }
}


function Mod_PlentyOfFish_StopFishing_FishingRod (spot_data, player) {
  if (Game_GetWorldStateAsInteger ("MODS", "plenty_of_fish_enabled", 0) == 1
  && spot_data.spot != null && Game_IsStagePointOfInterestCompleted (spot_data.spot) != true) {
    Game_SetStagePointOfInterestCompleted (spot_data.spot);
  }
}


function Mod_PlentyOfFish_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_plenty_of_fish_enabled":
        Game_SetWorldState ("MODS", "plenty_of_fish_enabled", UI_GetProperty ("mod_plenty_of_fish_enabled", "checkbox.value") == 1 ? "1" : "0");
        break;
      case "mod_plenty_of_fish_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Plenty of fish"),
            LocalizeText("Fish endlessly anywhere, fishing spots never deplete."));
        break;
    }
  }
}


function Mod_PlentyOfFish_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_plenty_of_fish_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "plenty_of_fish_enabled", 0));
  UI_SetProperty ("mod_plenty_of_fish_enabled_title", "textbox.text", LocalizeText("Plenty of fish"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
