// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local cooldown_realseconds = 900;
local minimum_distance = 500.0;
local probability = 0.01;


function Mod_WildCrops_OnGameStart_PlantBed (plantbed, same) {
  if (this.rawin("Game_SetSelectedFarmingSeedForActor") == true) {
    local player = Game_GetPrimaryPlayerActor();
    if (StageObject_GetKeyValue (plantbed, "seed_id", "") == ""
    && player != null && Game_IsItemEquipped (player, "SEED_BAG", true) != true && Game_IsItemEquipped (player, "SEED_BAG_MANA", true) != true) {
      local global_kvs = Game_GetGlobalKeyValueStore ("MODS");
      local next_plant_worldseconds = KeyValueStore_GetKeyValue (global_kvs, "wild_crops_next_plant_worldseconds");
      local now = Game_GetWorldTimeInSeconds();
      if (next_plant_worldseconds == null || next_plant_worldseconds < now) {
        local crop = null;
        local position = StageObject_GetStagePosition (plantbed);
        local player_position = StageObject_GetStagePosition (player);
        if (position != null && player_position != null) {
          local distance = sqrt(pow(position[0] - player_position[0], 2) + pow(position[1] - player_position[1], 2));
          if (distance > minimum_distance) {
            local objects = Stage_QueryStageObjectsInRadius (position[0], position[1], position[2], 1.0);
            if (objects != null && objects.len() > 0) {
              foreach (object in objects) {
                if (StageObject_GetKeyValue (object, "poi_type", "") == "FARMABLE" && Actor_GetOwner (object) == plantbed) {
                  crop = object;
                  break;
                }
              }
            }
            if (crop == null && m_randf() < probability) {
              local stage = Stage_GetFilename();
              if (stage != null) {
                local seeds = [];
                for (local seeds_node_index = 0; seeds_node_index < DM_GetArrayNumberOfNodes ("dysmantle/seeds.xml", "SEEDS"); seeds_node_index++) {
                  local seed = DM_GetArrayNodeValue ("dysmantle/seeds.xml", "SEEDS", seeds_node_index, "id");
                  local material = DM_GetArrayNodeValue ("dysmantle/seeds.xml", "SEEDS", seeds_node_index, "material_id");
                  if (seed != null && material != null) {
                    local dlc = DM_GetArrayNodeValue ("dysmantle/material-types.xml", "MATERIAL_TYPES", material, "requires_iap");
                    if ((dlc == null || IAP_IsItemPurchased (dlc) == true)
                    && (seed != "BANANA" || stage == "stages/dlc2/index.xml")
                    && (seed != "MANA_BEAD" || (stage == "stages/dlc1/index.xml" && Game_IsRecipeCrafted ("SEED_BAG_MANA") == true))) {
                      seeds.append(seed);
                    }
                  }
                }
                if (seeds.len() > 0) {
                  local seed_winner = (m_randf() * seeds.len().tofloat()).tointeger();
                  if (seed_winner == seeds.len()) seed_winner = 0;
                  local seed = seeds[seed_winner];
                  Game_SetSelectedFarmingSeedForActor (player, seed);
                  local world_time_multiplier = 20.0;
                  local engine_kvs = Engine_GetKeyValueStore();
                  if (engine_kvs != null) {
                    world_time_multiplier = KeyValueStore_GetKeyValue (engine_kvs, "world_time_multiplier", 20.0);
                  }
                  local global_kvs = Game_GetGlobalKeyValueStore ("MODS");
                  KeyValueStore_SetKeyValueInteger (global_kvs, "wild_crops_next_plant_worldseconds", floor(now.tofloat() + cooldown_realseconds.tofloat() * world_time_multiplier.tofloat() + cooldown_realseconds.tofloat() * m_randf()));
                  local command = Command_Create ("plant_seed");
                  Command_SetIntegerValue (command, player);
                  Stage_SendStageObjectCommandWithDelete (plantbed, command);
                }
              }
            }
          }
        }
      }
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
