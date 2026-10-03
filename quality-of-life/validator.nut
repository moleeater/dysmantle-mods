// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local do_poi_actortype = false;
local do_searchable_recipe_poi = false;
local do_searchable_key_poi = false;
local do_readable = false;
local do_gasleak = false;

local do_poi_actor_types = [
    //"actors/objects/tropic-plant-heliconia.xml",
    //"actors/objects/tropic-plant-lili.xml",
    //"actors/objects/tropic-plant-tigerlily.xml",
    //"actors/interactives/sawmill.xml",
    //"actors/interactives/smelter.xml",
    //"actors/enemies/night-terror-mana-spirit.xml",
    //"actors/enemies/doomhive.xml",
    //"actors/enemies/doomsquito.xml",
  ];
local gasleak_puids = {};
gasleak_puids[1010118] <- [ 1010137, 1202081, ];
gasleak_puids[2750110] <- [ 2750178, ];
gasleak_puids[3528208] <- [ 3528253, 3720219, ];
gasleak_puids[3528209] <- [ 3720220, ];
gasleak_puids[3918210] <- [ 3918206, ];
gasleak_puids[3918209] <- [ 3918207, 3918208, ];
gasleak_puids[3918238] <- [ 4110158, ];
gasleak_puids[4110160] <- [ 3918247, 4110159, ];
gasleak_puids[4494332] <- [ 4494330, ];
gasleak_puids[4494333] <- [ 4494331, ];
gasleak_puids[4496349] <- [ 4496348, ];
local whitelist_readable_puids = {
    "stages/island/index.xml": [ 980269, 1004092, 1006182, 1006227, 1006358, 1056121, 1174208, 1174258, 1196283, 1250002, 1250118, 1294287, 1358183, 1392111, 1466172, 1484206, 1582141, 1628228, 1630011, 1758253, 1776226, 1784125, 1786242, 1818233, 1822248, 1974427, 2002170, 2002244, 2002259, 2002264, 2046134, 2126253, 2162314, 2164031, 2196157, 2214182, 2224181, 2224200, 2224202, 2260158, 2262215, 2276220, 2456212, 2708188, 2898222, 2964084, 2966233, 2966233, 2966233, 2966234, 3032294, 3122139, 3126150, 3162299, 3174002, 3342044, 3342270, 3368213, 3376181, 3416180, 3418270, 3502212, 3502269, 3514154, 3540231, 3542274, 3552245, 3552361, 3566203, 3568013, 3568144, 3568173, 3574302, 3578479, 3602168, 3606259, 3608137, 3696207, 3704182, 3708165, 3718136, 3792505, 3866133, 3896188, 3908244, 3912236, 3914345, 3920176, 3962008, 3964239, 3964268, 3984296, 4068247, 4070193, 4094203, 4100220, 4102205, 4112243, 4292144, 4298004, 4300092, 4328408, 4330353, 4334212, 4474073, 4482231, 4492197, 4494224, 4514213, 4528389, 4546236, 4548219, 4680220, 4686177, 4686186, 4686203, 4738273, 4758214, 4764060, 4880222, 4914092, 5074043, 5112217, 5122111, 5126450, 5136280, 5148073, 5150250, 5150251, 5224194, 5250191, 5342209, 5426014, 5428040, 5428043, 5472080, 5514176, 5536171, 5618046, 5620093, 5620264, 5620266, 5620275, 5620343, 5620357, 5622058, 5624263, 5636279, 5716238, 5722237, 5798212, 5816136, 5848318, 5854109, 5860065, 5862291, 5862308, 5886346, 5906280, 5912250, 5980210, 5990331, 6006082, 6014230, 6018154, 6034259, 6054346, 6076178, 6078344, 6082252, 6086091, 6102007, 6104179, 6172140, 6178248, 6182206, 6182208, 6184208, 6226203, 6228086, 6228155, 6236105, 6240020, 6242167, 6242168, 6244239, 6252111, 6254402, 6256025, 6264268, 6362238, 6366193, 6368164, 6378204, 6384188, 6420312, 6434153, 6450138, 6572150, 6574193, 6750064, 6880352, 6944122, 6956165, 6958088, 6998114, 7048202, 7074527, 7130135, 7264175, 7270147, 7320025, 7442116, 7446074, 7512225, 7512226, 7646275, 7658251, 7660103, 7660150, 7898059, 8356460, ],
    "stages/shelters/shelter-arcturus.xml": [ 22005, ],
    "stages/shelters/shelter-borealis.xml": [ 20686, ],
    "stages/shelters/shelter-decima.stage": [ 295, ],
    "stages/shelters/shelter-desolatum.stage": [ 606, 611, 612, ],
    "stages/shelters/shelter-frore.xml": [ 626, ],
    "stages/shelters/shelter-nona.stage": [ 526, ],
    "stages/shelters/shelter-polaris.xml": [ 32299, ],
    "stages/shelters/shelter-underworld.stage": [ 1090, 1788, 1789, ],
    "stages/shelters/shelter-vulcan.xml": [ 29371, ],
    "stages/undercrown/index.xml": [ 3364381, 3558298, ],
    "stages/dlc1/index.xml": [ 328143, 448034, 448233, 448296, 516271, 518169, 544248, 548205, 624136, 624137, 642318, 652186, 724148, 750003, 750224, 752223, 848110, 1018092, 1018209, 1018212, 1020217, 1020222, 1034170, 1106226, 1112009, 1112248, 1114245, 1114246, 1116089, 1116274, 1116304, 1126152, 1134219, 1162028, 1206185, 1212262, 1212369, 1212430, 1214239, 1238408, 1290249, 1290250, 1292287, 1296091, 1300103, 1302320, 1304078, 1304269, 1316147, 1380168, 1394181, 1400142, 1400350, 1402095, 1402262, 1406222, 1484193, 1494296, 1500310, 1500313, 1502026, 1502226, 1514109, 1520137, 1590096, 1592214, 1676271, 1676284, 1684348, 1686142, 1772235, 1880212, 1960144, 1974351, 1974385, 1976244, 1976319, ],
    "stages/dlc2/index.xml": [ 406095, 406142, 408166, 428273, 500154, 588289, 590284, 618279, 692104, 702273, 750307, 778032, 784194, 784342, 828156, 830167, 836245, 846114, 848135, 850245, 892220, 918176, 930263, 944148, 984126, 990297, 1010152, 1014290, 1016188, 1026229, 1070299, 1072317, 1072317, 1098388, 1108276, 1110239, 1128251, 1230217, 1232228, 1286283, 1378388, 1380267, 1386244, 1412021, 1412228, 1418229, 1418229, 1496271, 1590307, 1762160, 1770117, ],
    "stages/dlc3/index.xml": [ 114240, 114240, 128154, 128154, 164250, 164250, 176106, 176106, 280423, 280423, 306243, 306243, 314203, 314203, 318270, 318270, 328182, 328182, 328200, 328200, 350212, 350212, 400165, 400165, 410241, 410241, 412126, 412126, 412346, 412346, 424017, 424017, 426184, 426184, ],
  };


function OnValidateActor (actor) {
  local puid = StageObject_GetPersistentUniqueId (actor);
  local actor_type = Actor_GetActorType (actor);
  local stage = Stage_GetFilename();
  if (do_poi_actortype == true) {
    local pois = stage.slice(0, stage.len() - 10) + "/points-of-interest.xml";
    for (local pois_node_index = 0; pois_node_index < DM_GetArrayNumberOfNodes (pois, stage); pois_node_index++) {
      local poi_puid = DM_GetArrayNodeValue (pois, stage, pois_node_index, "puid");
      if (poi_puid.tointeger() == puid) {
        Engine_Warning ("ACTORTYPE " + stage + " " + puid.tostring() + " " + actor_type);
        break;
      }
    }
  }
  local search_reward_recipe = StageObject_GetKeyValue (actor, "search_reward_recipe", "");
  local search_reward_key = StageObject_GetKeyValue (actor, "search_reward_key", "");
  local custom_display_name = null;
  local do_poi = false;
  if (actor_type != null && do_poi_actor_types.find(actor_type) != null) {
    do_poi = true;
  }
  if (do_searchable_recipe_poi == true && search_reward_recipe != "") {
    custom_display_name = Game_GetConvertedString("[RECIPE_NAME=" + search_reward_recipe + "]");
    do_poi = true;
  }
  if (do_searchable_key_poi == true && search_reward_key != "") {
    custom_display_name = Game_GetConvertedString("[KEY_NAME=" + search_reward_key + "]");
    do_poi = true;
  }
  if (do_poi) {
    local kvs = ActorType_GetKeyValueStore (actor_type);
    local poi_type = KeyValueStore_GetKeyValue (kvs, "poi_type");
    local pos = StageObject_GetStagePosition (actor);
    local width = Stage_GetWidth();
    if (poi_type != null && puid != null && pos != null && stage != null && width != null) {
      local id = StageObject_GetId (actor);
      if (id == null) {
        id = "puid" + puid.tostring();
      }
      local cellsize = Stage_GetCellSize();
      if (cellsize == null) cellsize = 60.0;
      cellsize = cellsize.tofloat();
      local chunk_x = floor(pos[0] / cellsize / 20.0);
      local chunk_y = floor(pos[1] / cellsize / 20.0);
      local chunk_num = chunk_y * floor(width.tofloat() / 20.0) + chunk_x;
      local area = null;
      local towers_nodes_count = DM_GetArrayNumberOfNodes ("dysmantle/towers.xml", stage);
      if (towers_nodes_count != null && towers_nodes_count > 0) {
        local chunk_dashed = chunk_x.tostring() + "-" + chunk_y.tostring();
        for (local towers_node_index = 0; towers_node_index < towers_nodes_count; towers_node_index++) {
          local chunkstr = DM_GetArrayNodeValue ("dysmantle/towers.xml", stage, towers_node_index, "chunks");
          if (chunkstr != null && split (chunkstr, ",").find(chunk_dashed) != null) {
            area = towers_node_index;
            break;
          }
        }
      }
      if (search_reward_recipe != "") {
        poi_type = search_reward_recipe.slice(0,5) == "DISH_" ? "RECIPE_DISH" : "RECIPE";
      }
      if (search_reward_key != "") {
        poi_type = "KEY";
      }
      Engine_Warning ("    <node"
          + " chunk=\"" + chunk_num.tostring() + "\""
          + " pos=\"" + round(pos[0]).tostring() + ";" + round(pos[1]).tostring() + ";" + round(pos[2]).tostring() + "\""
          + (area == null ? "" : " area=\"" + area.tostring() + "\"")
          + " puid=\"" + puid.tostring() + "\""
          + " so_id=\"" + id + "\""
          + (custom_display_name == null ? "" : " custom_display_name=\"" + string_replace(custom_display_name,"\"","&quot;") + "\"")
          + " type=\"" + poi_type + "\""
          + ((poi_type.len() > 6 && poi_type.slice(0,6) == "ENEMY_") || search_reward_recipe != "" || search_reward_key != "" ? " actor_type=\"" + actor_type + "\"" : "")
          + (search_reward_recipe != "" ? " recipe=\"" + search_reward_recipe + "\"" : "")
          + (search_reward_key != "" ? " key=\"" + search_reward_key + "\"" : "")
          + " />");
    }
  }
  if (do_readable) {
    local is_readable = false;
    if (whitelist_readable_puids.rawin(stage) == true) {
      if (whitelist_readable_puids[stage].find(puid) != null) {
        is_readable = true;
      }
    }
    local has_read = Actor_HasInteraction (actor, "read") == true || Actor_HasInteraction (actor, "quest_read") == true;
    if (has_read || is_readable) {
      Engine_Warning ("READABLE " + actor_type);
    }
  }
  if (do_gasleak) {
    if (gasleak_puids.rawin(puid) == true) {
      Engine_Warning ("GASLEAK " + actor_type);
    }
  }
  return "";
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function OnValidateStageObject (object) {
  return "";
}
