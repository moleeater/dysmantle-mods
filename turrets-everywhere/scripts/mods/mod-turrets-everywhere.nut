// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local dlc2_blacklist_puids = [ 1002238, 1004182, 1004180, 1004183, 1036304, 1036254, 1036334, 1036159, 1036306, 1036333, 1036335, 1038241, 1096308, 1098220, 1130296, 1130307, 1130306, 1130295, 1132144, 1134082, 1134108, 1192386, 1274134, 1276130, 1370106, 1376317, 1380411, 1382314, 1388311, 1390360, 1390358, 1480295, 1480294, 1482345, 1482346, 1484320, 1484316, 1486121, 1486101, 1574272, 1674166, 1770137, 1868126, ];
local dlc3_bosses = {
    "DLC3_BOSS_Groundskeeper": 5,
    "DLC3_BOSS_LabGuardian": 6,
    "DLC3_BOSS_Northeast": 1,
    "DLC3_BOSS_Northwest": 0,
    "DLC3_BOSS_Southeast": 3,
    "DLC3_BOSS_Southwest": 2,
  };


function Mod_TurretsEverywhere_OnCommandWord_Creature (creature, command_word) {
  if (NX_IsDeveloperModeEnabled() == true && command_word == "death_start") {
    local stage_kvs = Stage_GetKeyValueStore();
    local id = StageObject_GetId (creature);
    if (id != null && dlc3_bosses.rawin(id) == true && KeyValueStore_GetKeyValue (stage_kvs, "mod_turrets_everywhere_" + id, false) != true) {
      local area_num = dlc3_bosses[id];
      local turret_count = 0;
      for (local pois_node_index = 0; pois_node_index < DM_GetArrayNumberOfNodes ("stages/dlc3/points-of-interest.xml", "stages/dlc3/index.xml"); pois_node_index++) {
        if (DM_GetArrayNodeValue ("stages/dlc3/points-of-interest.xml", "stages/dlc3/index.xml", pois_node_index, "area") == area_num.tostring()
        && [ "ENEMY_NORMAL", "ENEMY_STATIONARY" ].find(DM_GetArrayNodeValue ("stages/dlc3/points-of-interest.xml", "stages/dlc3/index.xml", pois_node_index, "type")) != null) {
          turret_count++;
        }
      }
      KeyValueStore_SetKeyValueBoolean (stage_kvs, "mod_turrets_everywhere_" + id, true);
      local kvp = KeyValueStore_GetKeyValueAsPointer (stage_kvs, "mod_turrets_everywhere_" + id);
      if (kvp != null) {
        KeyValueStore_SetFlagForKeyValue (kvp, "SAVE_STATE", true);
      }
      Mod_TurretsEverywhere_SpawnManaBeads (turret_count, Game_GetPrimaryPlayerActor(), creature);
    }
  }
}


function Mod_TurretsEverywhere_OnDeath_Boss (boss, area_num) {
  if (NX_IsDeveloperModeEnabled() == true) {
    local turret_count = 0;
    for (local pois_node_index = 0; pois_node_index < DM_GetArrayNumberOfNodes ("stages/dlc2/points-of-interest.xml", "stages/dlc2/index.xml"); pois_node_index++) {
      if (DM_GetArrayNodeValue ("stages/dlc2/points-of-interest.xml", "stages/dlc2/index.xml", pois_node_index, "area") == area_num.tostring()
      && [ "ENEMY_NORMAL", "ENEMY_STATIONARY" ].find(DM_GetArrayNodeValue ("stages/dlc2/points-of-interest.xml", "stages/dlc2/index.xml", pois_node_index, "type")) != null
      && dlc2_blacklist_puids.find(DM_GetArrayNodeValue ("stages/dlc2/points-of-interest.xml", "stages/dlc2/index.xml", pois_node_index, "puid").tointeger()) == null) {
        turret_count++;
      }
    }
    Mod_TurretsEverywhere_SpawnManaBeads (turret_count, Game_GetPrimaryPlayerActor(), boss);
  }
}


function Mod_TurretsEverywhere_SpawnManaBeads (turret_count, player, altar) {
  local bead_amount = turret_count;
  local modifiers_kvs = Game_GetAllPlayerModifiersAsKeyValueStore (player);
  local search_efficiency_absolute_increase = KeyValueStore_GetKeyValue (modifiers_kvs, "search_efficiency_absolute_increase");
  if (search_efficiency_absolute_increase == null) search_efficiency_absolute_increase = 0.0;
  if (search_efficiency_absolute_increase * 0.01 > m_randf()) {
    bead_amount += turret_count;
  }
  local extra_gatherable_chance_percentage_increase = KeyValueStore_GetKeyValue (modifiers_kvs, "extra_gatherable_chance_percentage_increase");
  if (extra_gatherable_chance_percentage_increase == null) extra_gatherable_chance_percentage_increase = 0.0;
  if (extra_gatherable_chance_percentage_increase * 0.01 > m_randf()) {
    bead_amount += turret_count;
  }
  local material_drop_percentage_increase = KeyValueStore_GetKeyValue (modifiers_kvs, "material_drop_percentage_increase");
  if (material_drop_percentage_increase == null) material_drop_percentage_increase = 0.0;
  bead_amount = bead_amount.tofloat() * (1.0 + material_drop_percentage_increase.tofloat() * 0.01);
  bead_amount = floor(bead_amount);
  Game_SpawnMaterials (player, player, bead_amount + "xMANA_BEAD");
}


function Mod_TurretsEverywhere_PressButton_TombAltarOverground (altar, player) {
  if (NX_IsDeveloperModeEnabled() == true) {
    local stage = Stage_GetFilename();
    if (stage == "stages/dlc2/index.xml") {
      local altar_puid = StageObject_GetPersistentUniqueId (altar);
      local area_num = null;
      for (local pois_node_index = 0; pois_node_index < DM_GetArrayNumberOfNodes ("stages/dlc2/points-of-interest.xml", stage); pois_node_index++) {
        if (DM_GetArrayNodeValue ("stages/dlc2/points-of-interest.xml", stage, pois_node_index, "type") == "TOMB"
        && DM_GetArrayNodeValue ("stages/dlc2/points-of-interest.xml", stage, pois_node_index, "puid") == altar_puid.tostring()) {
          area_num = DM_GetArrayNodeValue ("stages/dlc2/points-of-interest.xml", stage, pois_node_index, "area");
          break;
        }
      }
      if (area_num != null) {
        area_num = area_num.tointeger();
        local turret_count = 0;
        for (local pois_node_index = 0; pois_node_index < DM_GetArrayNumberOfNodes ("stages/dlc2/points-of-interest.xml", stage); pois_node_index++) {
          if (DM_GetArrayNodeValue ("stages/dlc2/points-of-interest.xml", stage, pois_node_index, "area") == area_num.tostring()
          && [ "ENEMY_NORMAL", "ENEMY_STATIONARY" ].find(DM_GetArrayNodeValue ("stages/dlc2/points-of-interest.xml", stage, pois_node_index, "type")) != null
          && dlc2_blacklist_puids.find(DM_GetArrayNodeValue ("stages/dlc2/points-of-interest.xml", stage, pois_node_index, "puid").tointeger()) == null) {
            turret_count++;
          }
        }
        Mod_TurretsEverywhere_SpawnManaBeads (turret_count, player, altar);
      }
    }
  }
}


function Mod_TurretsEverywhere_PressButton_TombAltar (altar, player) {
  if (NX_IsDeveloperModeEnabled() == true) {
    local stage = Stage_GetFilename();
    if (stage != "stages/tombs/tomb-shot-block.xml") {
      local area_num = null;
      for (local pois_node_index = 0; pois_node_index < DM_GetArrayNumberOfNodes ("stages/island/points-of-interest.xml", "stages/island/index.xml"); pois_node_index++) {
        if (DM_GetArrayNodeValue ("stages/island/points-of-interest.xml", "stages/island/index.xml", pois_node_index, "type") == "TOMB"
        && DM_GetArrayNodeValue ("stages/island/points-of-interest.xml", "stages/island/index.xml", pois_node_index, "parm") == stage) {
          area_num = DM_GetArrayNodeValue ("stages/island/points-of-interest.xml", "stages/island/index.xml", pois_node_index, "area");
          break;
        }
      }
      if (area_num != null) {
        area_num = area_num.tointeger();
        local turret_count = 0;
        for (local pois_node_index = 0; pois_node_index < DM_GetArrayNumberOfNodes ("stages/island/points-of-interest.xml", "stages/island/index.xml"); pois_node_index++) {
          if (DM_GetArrayNodeValue ("stages/island/points-of-interest.xml", "stages/island/index.xml", pois_node_index, "area") == area_num.tostring()
          && [ "ENEMY_NORMAL", "ENEMY_STATIONARY" ].find(DM_GetArrayNodeValue ("stages/island/points-of-interest.xml", "stages/island/index.xml", pois_node_index, "type")) != null) {
            turret_count++;
          }
        }
        Mod_TurretsEverywhere_SpawnManaBeads (turret_count, player, altar);
        Actor_SetInteractionEnabled (altar, "mod_turrets_everywhere_on_interval", true);
      }
    }
  }
}


function Mod_TurretsEverywhere_OnInterval_TombAltar (altar, same) {
  if (NX_IsDeveloperModeEnabled() == true && UI_IsScreenInStack ("PauseMenu") != true && Game_IsStoringMaterials() != true) {
    local command = Command_Create ("store_materials");
    Command_SetStageObjectReference (command, Game_GetPrimaryPlayerActor());
    Stage_SendStageObjectCommandWithDelete (Game_GetPrimaryPlayerActor(), command);
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
