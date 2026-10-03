// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local default_max_aiming_distance = 400;
local new_max_aiming_distance = 1200;
local blacklist_puids = {
    "stages/dlc2/index.xml": [ 752035, ],
    "stages/dlc3/index.xml": [ 326115, 374086, 280115, 330123, 424035, 424248, ],
  };


Include ("scripts/mods/mods-info.nut");


function Mod_ElectrifyingGrenade_OnCommandWord_Throwable (player, item_id) {
  if (item_id == "items/specials/electric-grenade.nut") {
    Game_IncreaseItemUses (player, item_id, 1);
  }
}


function Mod_ElectrifyingGrenade_OnTrigger_Throwable (item_id) {
  if (item_id == "items/specials/electric-grenade.nut") {
    return Game_GetWorldStateAsInteger ("MODS", "electrifying_grenade_enabled", 0) == 1 ? new_max_aiming_distance : default_max_aiming_distance;
  }
}


function Mod_ElectrifyingGrenade_OnThink_ElectricGrenade (grenade, tdelta) {
  if (Game_GetWorldStateAsInteger ("MODS", "electrifying_grenade_enabled", 0) == 1) {
    local explosion_radius = StageObject_GetKeyValue (grenade, "explosion_radius", 0);
    local position = StageObject_GetStagePosition (grenade);
    if (position != null) {
      local objects = Stage_QueryStageObjectsInRadius (position[0], position[1], position[2], explosion_radius);
      if (objects != null && objects.len() > 0) {
        foreach (object in objects) {
          local puid = StageObject_GetPersistentUniqueId (object);
          if (StageObject_HasTag (object, "CIRCUIT_COMPONENT") == true && StageObject_GetKeyValue (object, "powered", false) != true && StageObject_GetType (object) == STAGE_OBJECT_TYPE_ACTOR && puid != null) {
            local is_blacklisted = false;
            local stage = Stage_GetFilename();
            if (stage != null && blacklist_puids.rawin(stage) == true) {
              local puid = StageObject_GetPersistentUniqueId (object);
              if (puid != null && blacklist_puids[stage].find(puid) != null) {
                is_blacklisted = true;
              }
            }
            if (! is_blacklisted) {
              local actor_type = Actor_GetActorType (object);
              if (actor_type != null) {
                switch (actor_type) {
                  case "actors/interactives/circuit-puzzle-beam-gun-node.xml":
                  case "actors/interactives/circuit-puzzle-power-node.xml":
                    Actor_QueueActionSendCommandWord (object, object, "activate");
                    Game_LogEvent ("MOD_ELECTRIFYING_GRENADE", puid == null ? "" : puid.tostring());
                    break;
                }
                StageObject_SetKeyValueBoolean (object, "powered", true);
              }
            }
          }
        }
      }
    }
  }
}


function Mod_ElectrifyingGrenade_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_electrifying_grenade_enabled":
        Game_SetWorldState ("MODS", "electrifying_grenade_enabled", UI_GetProperty ("mod_electrifying_grenade_enabled", "checkbox.value") == 1 ? "1" : "0");
        break;
      case "mod_electrifying_grenade_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Electrifying grenade") + " |img src='emojis/star.png' scale=1 offset=2|",
            LocalizeText("Power on circuit components with the Electric Grenade to skip Doomsday DLC2 puzzles."));
        break;
    }
  }
}


function Mod_ElectrifyingGrenade_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetVisible ("mod_electrifying_grenade_enabled_title", IAP_IsItemPurchased ("DLC2") == true);
  UI_SetProperty ("mod_electrifying_grenade_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "electrifying_grenade_enabled", 0));
  UI_SetProperty ("mod_electrifying_grenade_enabled_title", "textbox.text", "|img src='emojis/star.png' scale=0.4 offset=0|  " + LocalizeText("Electrifying grenade"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
