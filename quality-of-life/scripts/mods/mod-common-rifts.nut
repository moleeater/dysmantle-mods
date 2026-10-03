// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local visible_distance = 3200.0;
local interval_realseconds = 3.0;
local rifts = {
    "stages/island/index.xml": {
        "menzies_pass_1"                 : { "position": [ 76530, 32370,    10 ], "destination": [ 76230, 32430,  -250 ] },
        "menzies_pass_2"                 : { "position": [ 76050, 32550,  -230 ], "destination": [ 75930, 32670,  -490 ] },
        "menzies_pass_3a"                : { "position": [ 75510, 33150,  -470 ], "destination": [ 75390, 33330,  -730 ] },
        "menzies_pass_3a_down"           : { "position": [ 74550, 33500,  -710 ], "destination": [ 76710, 32370,   -10 ] },
        "menzies_pass_3b"                : { "position": [ 73530, 33870,  -470 ], "destination": [ 73410, 33990,  -730 ] },
        "menzies_pass_3b_down"           : { "position": [ 72030, 35370,  -710 ], "destination": [ 76710, 32370,   -10 ] },
        "crown_1"                        : { "position": [ 76170, 31410,    10 ], "destination": [ 76170, 31230,  -250 ] },
        "crown_1b"                       : { "position": [ 70260, 33540,    10 ], "destination": [ 70020, 33720,  -250 ] },
        "crown_2"                        : { "position": [ 75690, 30270,  -230 ], "destination": [ 75570, 30210,  -490 ] },
        "crown_3"                        : { "position": [ 74610, 29850,  -470 ], "destination": [ 74490, 29730,  -730 ] },
        "crown_3_down"                   : { "position": [ 73650, 27870,  -710 ], "destination": [ 76170, 31650,   -10 ] },
        "closed_up_chemical_plant"       : { "position": [ 71840, 29850,  -470 ], "destination": [ 71730, 29730,  -730 ] },
        "closed_up_chemical_plant_down"  : { "position": [ 67290, 31410,  -710 ], "destination": [ 76170, 31650,   -10 ] },
        "fortified_forest_4"             : { "position": [ 63330, 28350,  -710 ], "destination": [ 63390, 28530,  -970 ] },
        "fortified_forest_5"             : { "position": [ 63570, 30450,  -950 ], "destination": [ 63450, 30330, -1210 ] },
        "fortified_forest_5_down"        : { "position": [ 62190, 28290, -1190 ], "destination": [ 62420, 27450,  -730 ] },
        "collapsed_launchpad_road_a"     : { "position": [ 60810, 27510,  -950 ], "destination": [ 60330, 27510, -1190 ] },
        "collapsed_launchpad_road_b"     : { "position": [ 59790, 30810,  -950 ], "destination": [ 59970, 30810, -1210 ] },
        "collapsed_launchpad_road_b_down": { "position": [ 60510, 29790, -1190 ], "destination": [ 60510, 29550,  -970 ] },
        "k23"                            : { "position": [ 57030, 25950,  -970 ], "destination": [ 57150, 26070, -1070 ] },
        "fortress_entrance"              : { "position": [ 58470, 28410,  -970 ], "destination": [ 58170, 28530, -1070 ] },
      },
  };
local update_in_realseconds = 0.0;


Include ("scripts/mods/mods-info.nut");


function Mod_CommonRifts_OnUpdate_Stage (tdelta) {
  update_in_realseconds -= tdelta;
  if (update_in_realseconds < 0.0) {
    update_in_realseconds = interval_realseconds;
    if (Game_GetWorldStateAsInteger ("MODS", "common_rifts_enabled", 0) == 1) {
      local stage = Stage_GetFilename();
      if (stage != null && rifts.rawin(stage) == true) {
        local stage_rifts = rifts[stage];
        if (stage_rifts != null) {
          local player = Game_GetPrimaryPlayerActor();
          if (player != null) {
            local player_position = StageObject_GetStagePosition (player);
            if (player_position != null) {
              foreach (rift_id, rift_data in stage_rifts) {
                rift_id = "mod_common_rifts_" + rift_id;
                local rift = Stage_GetStageObjectById (rift_id, STAGE_OBJECT_TYPE_ACTOR);
                if (rift == null) {
                  local distance = sqrt(pow(rift_data.position[0] - player_position[0], 2) + pow(rift_data.position[1] - player_position[1], 2));
                  if (distance < visible_distance) {
                    rift = Stage_CreateActor ("actors/mods/mod-common-rift.xml", rift_data.position[0], rift_data.position[1], rift_data.position[2], false);
                    StageObject_SetId (rift, rift_id);
                    local kvs = StageObject_GetKeyValueStore (rift);
                    KeyValueStore_SetKeyValuePosition (kvs, "destination", rift_data.destination[0], rift_data.destination[1], rift_data.destination[2]);
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}


function Mod_CommonRifts_OnActorEntersRadiusReveal_CommonRift (rift, player) {
  if (StageObject_HasTag (player, "PLAYER") == true) {
    local position = StageObject_GetKeyValue (rift, "destination");
    if (position != null) {
      Stage_SpawnEffect ("effects/mods/mod-common-rift-destination.xml", position[0], position[1], position[2] - 38.0, 0.0);
    }
  }
}


function Mod_CommonRifts_OnActorEntersRadiusTeleport_CommonRift (rift, player) {
  if (Game_IsCinemaModeEnabled() != true && StageObject_HasTag (player, "PLAYER") == true) {
    local position = StageObject_GetKeyValue (rift, "destination");
    if (position != null) {
      Game_TeleportPlayers (position[0], position[1], position[2]);
      Game_LogEvent ("MOD_COMMON_RIFTS", StageObject_GetId (rift));
    }
  }
}


function Mod_CommonRifts_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_common_rifts_enabled":
        local enabled = UI_GetProperty ("mod_common_rifts_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "common_rifts_enabled", enabled ? "1" : "0");
        if (enabled) {
          update_in_realseconds = interval_realseconds;
        } else {
          local stage = Stage_GetFilename();
          if (stage != null && rifts.rawin(stage) == true) {
            local stage_rifts = rifts[stage];
            if (stage_rifts != null) {
              foreach (rift_id, rift_data in stage_rifts) {
                rift_id = "mod_common_rifts_" + rift_id;
                local rift = Stage_GetStageObjectById (rift_id, STAGE_OBJECT_TYPE_ACTOR);
                if (rift != null) {
                  Stage_DeleteStageObjectQueued (rift);
                }
              }
            }
          }
        }
        break;
      case "mod_common_rifts_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Common rifts"),
            LocalizeText("New rifts teleporting you to the inaccessible areas in the Crown plateau, to harvest every tree."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-common-rifts-video")}] );
        break;
    }
  }
}


function Mod_CommonRifts_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_common_rifts_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "common_rifts_enabled", 0));
  UI_SetProperty ("mod_common_rifts_enabled_title", "textbox.text", LocalizeText("Common rifts"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
