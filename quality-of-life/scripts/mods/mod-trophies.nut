// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local prop_names = [
    "aquatic",
    "arctic",
    "blue",
    "blue2",
    "boss",
    "boss2",
    "boss_bottomleft",
    "boss_bottomright",
    "boss_topleft",
    "boss_topright",
    "boss-vulnerable",
    "cerebellum",
    "decal",
    "desert",
    "doomsquito",
    "doomsquito2",
    "doomsquito3",
    "large",
    "mana-crystal",
    "mana-crystal2",
    "red",
    "red2",
    "small",
    "small2",
    "submergable_bottom",
    "submergable_left",
    "submergable_right",
    "submergable_top",
    "survivor",
    "woodland",
    "yellow",
    "yellow2",
  ];
local boss_puids = {
    "stages/island/index.xml"    : {},
    "stages/undercrown/index.xml": {},
    "stages/dlc1/index.xml"      : {},
    "stages/dlc2/index.xml"      : {},
    "stages/dlc3/index.xml"      : {},
  };
boss_puids["stages/island/index.xml"][5136099]     <- {                                                    "buildable": "actors/mods/mod-trophies-false-gatekeeper.xml"       };
boss_puids["stages/island/index.xml"][3604200]     <- { "check": @() Game_IsPUIDMarkedDestroyed (3604135) == true, "buildable": "actors/mods/mod-trophies-vicious-twins.xml"          };
boss_puids["stages/island/index.xml"][3604135]     <- { "check": @() Game_IsPUIDMarkedDestroyed (3604200) == true, "buildable": "actors/mods/mod-trophies-vicious-twins.xml"          };
boss_puids["stages/island/index.xml"][1706214]     <- {                                                    "buildable": "actors/mods/mod-trophies-alpha-wolf.xml"             };
boss_puids["stages/island/index.xml"][1292135]     <- {                                                    "buildable": "actors/mods/mod-trophies-law.xml"                    };
boss_puids["stages/island/index.xml"][7268448]     <- {                                                    "buildable": "actors/mods/mod-trophies-ruthless-pitcher.xml"       };
boss_puids["stages/island/index.xml"][7664145]     <- {                                                    "buildable": "actors/mods/mod-trophies-reaper.xml"                 };
boss_puids["stages/island/index.xml"][5666147]     <- {                                                    "buildable": "actors/mods/mod-trophies-perilous-pursuer.xml"       };
boss_puids["stages/island/index.xml"][8000190]     <- {                                                    "buildable": "actors/mods/mod-trophies-old-loyal-champion.xml"     };
boss_puids["stages/island/index.xml"][4308168]     <- { "check": @() Game_IsPUIDMarkedDestroyed (4308158) == true, "buildable": "actors/mods/mod-trophies-skinless-skulkers.xml"      };
boss_puids["stages/island/index.xml"][4308158]     <- { "check": @() Game_IsPUIDMarkedDestroyed (4308168) == true, "buildable": "actors/mods/mod-trophies-skinless-skulkers.xml"      };
boss_puids["stages/island/index.xml"][2332018]     <- {                                                    "buildable": "actors/mods/mod-trophies-sword.xml"                  };
boss_puids["stages/island/index.xml"][7518110]     <- {                                                    "buildable": "actors/mods/mod-trophies-crown.xml"                  };
boss_puids["stages/island/index.xml"][4724491]     <- {                                                    "buildable": "actors/mods/mod-trophies-wicked-leaper.xml"          };
boss_puids["stages/island/index.xml"][4908028]     <- { "check": @() Game_IsPUIDMarkedDestroyed (4908052) == true, "buildable": "actors/mods/mod-trophies-alpha-wolves.xml"           };
boss_puids["stages/island/index.xml"][4908052]     <- { "check": @() Game_IsPUIDMarkedDestroyed (4908028) == true, "buildable": "actors/mods/mod-trophies-alpha-wolves.xml"           };
boss_puids["stages/undercrown/index.xml"][3164101] <- {                                                    "buildable": "actors/mods/mod-trophies-toxic-destroyer.xml"        };
boss_puids["stages/dlc1/index.xml"][336081]        <- {                                                    "buildable": "actors/mods/mod-trophies-slick-swindler.xml"         };
/*
local check_cats = @() [ 506015, 602044, 506039, 602060, 506105, 602134, 506043, 602133 ].apply(@(puid) Game_IsPUIDMarkedDestroyed (puid) == true).find(false) == null;
foreach (cat in [ 506015, 602044, 506039, 602060, 506105, 602134, 506043, 602133 ]) {
  boss_puids["stages/dlc2/index.xml"][cat]         <- { "check": check_cats,                               "buildable": "actors/mods/mod-trophies-cats.xml"                   };
}
*/
boss_puids["stages/dlc2/index.xml"][1204382]       <- {                                                    "buildable": "actors/mods/mod-trophies-doomhive-prime.xml"         };
boss_puids["stages/dlc2/index.xml"][1130397]       <- { "check": @() Game_IsPUIDMarkedDestroyed (1322002) == true, "buildable": "actors/mods/mod-trophies-mass-production-models.xml" };
boss_puids["stages/dlc2/index.xml"][1318002]       <- { "check": @() Game_IsPUIDMarkedDestroyed (1322002) == true, "buildable": "actors/mods/mod-trophies-mass-production-models.xml" };
boss_puids["stages/dlc2/index.xml"][1322002]       <- {                                                    "buildable": "actors/mods/mod-trophies-mass-production-models.xml",
                                                    "check": @() Game_IsPUIDMarkedDestroyed (1130397) == true && Game_IsPUIDMarkedDestroyed (1318002) == true };
boss_puids["stages/dlc3/index.xml"][216133]        <- {                                                    "buildable": "actors/mods/mod-trophies-beast-of-timber.xml"        };
boss_puids["stages/dlc3/index.xml"][154263]        <- {                                                    "buildable": "actors/mods/mod-trophies-beast-of-frost.xml"         };
boss_puids["stages/dlc3/index.xml"][360213]        <- {                                                    "buildable": "actors/mods/mod-trophies-beast-of-terra.xml"         };
boss_puids["stages/dlc3/index.xml"][356321]        <- {                                                    "buildable": "actors/mods/mod-trophies-beast-of-desolation.xml"    };
boss_puids["stages/dlc3/index.xml"][292236]        <- {                                                    "buildable": "actors/mods/mod-trophies-groundskeeper.xml"          };
boss_puids["stages/dlc3/index.xml"][234002]        <- {                                                    "buildable": "actors/mods/mod-trophies-lab-guardian.xml"           };


function Mod_Trophies_Check (puid, boss_data) {
  if (Game_IsPUIDMarkedDestroyed (puid) == true && boss_data.rawin("buildable") == true) {
    if (Profile_GetValue ("BUILDABLES", boss_data.buildable, "built") != "1") {
      local unlock = false;
      if (boss_data.rawin("check") != true) {
        unlock = true;
      } else if (boss_data.check() == true) {
        unlock = true;
      }
      if (unlock == true) {
        Game_SetBuildableUnlocked (boss_data.buildable, true, true);
      }
    }
  }
}


function Mod_Trophies_OnEnter_Stage() {
  local stage = Stage_GetFilename();
  if (stage != null && boss_puids.rawin(stage) == true) {
    foreach (puid, boss_data in boss_puids[stage]) {
      if (Game_IsPUIDMarkedDestroyed (puid) == true) {
        Mod_Trophies_Check (puid, boss_data);
      }
    }
  }
  if (Game_GetWorldState ("MODS", "trophies_used") != "1") {
    Game_SetWorldState ("MODS", "trophies_used", "1");
  }
}


function Mod_Trophies_Check_Creature (creature) {
  local stage = Stage_GetFilename();
  if (stage != null && boss_puids.rawin(stage) == true) {
    local puid = StageObject_GetPersistentUniqueId (creature);
    if (puid != null && boss_puids[stage].rawin(puid) == true) {
      local boss_data = boss_puids[stage][puid];
      Mod_Trophies_Check (puid, boss_data);
    }
  }
}


function Mod_Trophies_OnCommandWord_Creature (creature, command_word) {
  if (command_word == "death_start") {
    Mod_Trophies_Check_Creature (creature);
  }
}


function Mod_Trophies_OnDeathStart_BossMain (boss, same) {
  Mod_Trophies_Check_Creature (boss);
}


function Mod_Trophies_OnDeath_Boss (boss) {
  Mod_Trophies_Check_Creature (boss);
}


function Mod_Trophies_HoldDownButton_Buildable (trophy, player) {
  local new_pose = Game_PlayAnimationFromCategory (trophy, "MOD_TROPHIES");
  if (new_pose != null) {
    StageObject_SetKeyValueString (trophy, "mod_trophies_last_pose", new_pose);
  }
}


function Mod_Trophies_OnGameStart_Buildable (trophy, same) {
  local is_disabled = false;
  local last_pose = StageObject_GetKeyValue (trophy, "mod_trophies_last_pose");
  local actor_type = Actor_GetActorType (trophy);
  if (actor_type != null) {
    if (Profile_GetValue ("BUILDABLES", actor_type, "built") == "1" && (last_pose == null || last_pose == "") && NX_IsDeveloperModeEnabled() != true) {
      is_disabled = true;
      foreach (prop_name in prop_names) {
        Actor_SetPropEnabled (trophy, prop_name, false);
      }
    }
    Profile_SetValue ("BUILDABLES", actor_type, "built", "1");
    Game_SetBuildableUnlocked (actor_type, false, false);
  }
  if (! is_disabled) {
    if (last_pose != null && last_pose != "") {
      Actor_PlayAnimation (trophy, last_pose);
    } else {
      local new_pose = Game_PlayAnimationFromCategory (trophy, "MOD_TROPHIES");
      if (new_pose != null) {
        StageObject_SetKeyValueString (trophy, "mod_trophies_last_pose", new_pose);
      }
    }
    Actor_SetInteractionEnabled (trophy, "mod_trophies_hold_down_button", true);
    Actor_SetInteractionEnabled (trophy, "mod_trophies_press_button", true);
  }
  StageObject_RemoveTag (trophy, "TABLEWARE");
}


function Mod_Trophies_OnDeathStart_Buildable (trophy, same) {
  local last_pose = StageObject_GetKeyValue (trophy, "mod_trophies_last_pose");
  local actor_type = Actor_GetActorType (trophy);
  if (actor_type != null && last_pose != null && last_pose != "") {
    Profile_SetValue ("BUILDABLES", actor_type, "built", "0");
    Game_SetBuildableUnlocked (actor_type, true, false);
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
