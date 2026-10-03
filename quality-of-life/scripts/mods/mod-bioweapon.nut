// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local chitin_whitelist_puids = [ 1002238, 1004182, 1004180, 1004183, 1036304, 1036254, 1036334, 1036159, 1036306, 1036333, 1036335, 1038241, 1096308, 1098220, 1130296, 1130307, 1130306, 1130295, 1132144, 1134082, 1134108, 1192386, 1274134, 1276130, 1370106, 1376317, 1380411, 1382314, 1388311, 1390360, 1390358, 1480295, 1480294, 1482345, 1482346, 1484320, 1484316, 1486121, 1486101, 1574272, 1674166, 1770137, 1868126, ];
local material_safetymargin = 2;
local player = null;
local position = null;
local stage = null;
local is_small_stage = null;
local area_num = null;
local was_trigger_held_down = null;


function Mod_BioWeapon_OnMetadataRead_Item() {
  return {
      icon = "items/tools/mod-bioweapon.png"
      name = "Bioweapon |img src='emojis/package.png' scale=1.3 offset=2|"
      description = "|img src='emojis/package.png' scale=0.7 offset=2| Kill every minion in the tower area you are standing in"
      use_description_long_press = "Release the bioweapon"
      destroy_after_owner_death = true
      type = "melee_weapon"
      stance = "hands_free"
      prop = "actors/objects/lab_bottle_triangle.xml"
      prop_bone = "tool"
      prop_mount_scale = 0.85
      prop_mount_angle_x = 90
      prop_mount_angle_y = 180
      prop_mount_offset_x = -0.6
      prop_mount_offset_y = -8.5
      prop_mount_offset_z = 1
      required_material = "POTATO"
      material_cost = 50
    };
}


Include ("scripts/mods/mods-info.nut");


function Mod_BioWeapon_IsPossibleToUse_Item() {
  is_small_stage = true;
  stage = Stage_GetFilename();
  if (stage != null) {
    local stage_info = Stage_GetExternalStageInfo (stage);
    if (stage_info != null) {
      if (stage_info.rawin("width_in_cells") == true && stage_info.rawin("height_in_cells") == true
      && (stage_info.rawget("width_in_cells") > 400 || stage_info.rawget("height_in_cells") > 400)) {
        is_small_stage = false;
      }
    }
  }
  return Game_IsShowingActorNotification (player) != true
      && was_trigger_held_down == null
      && is_small_stage == false
      && Game_GetNumberOfMaterialsStoragePlusCarried (Mod_BioWeapon_OnMetadataRead_Item().required_material) >= Mod_BioWeapon_OnMetadataRead_Item().material_cost + material_safetymargin;
}


function Mod_BioWeapon_OnTriggerDown_Item() {
  if (was_trigger_held_down == null) {
    area_num = null;
    if (! Mod_BioWeapon_IsPossibleToUse_Item()) {
      if (Game_GetNumberOfMaterialsStoragePlusCarried (Mod_BioWeapon_OnMetadataRead_Item().required_material) < Mod_BioWeapon_OnMetadataRead_Item().material_cost + material_safetymargin) {
        local text = LocalizeText("[GREEN]Collect[WHITE] [VAR.required_amount]x[MATERIAL_ICON=[VAR.material_id]] [MATERIAL_NAME=[VAR.material_id]]");
        text = string_replace(text, "[VAR.required_amount]", (Mod_BioWeapon_OnMetadataRead_Item().material_cost + material_safetymargin).tostring());
        text = string_replace(text, "[VAR.material_id]", Mod_BioWeapon_OnMetadataRead_Item().required_material);
        Game_AddActorNotification (player, text);
      }
    } else {
      local cellsize = Stage_GetCellSize();
      if (cellsize == null) cellsize = 60.0;
      cellsize = cellsize.tofloat();
      position = StageObject_GetStagePosition (player);
      if (position != null && stage != null && stage.len() >= 10 && stage.slice(stage.len() - 10) == "/index.xml") {
        local chunk_x = floor(position[0].tofloat() / cellsize / 20.0).tointeger();
        local chunk_y = floor(position[1].tofloat() / cellsize / 20.0).tointeger();
        local chunk = chunk_x.tostring() + "-" + chunk_y.tostring();
        local towers_nodes_count = DM_GetArrayNumberOfNodes ("dysmantle/towers.xml", stage);
        if (towers_nodes_count != null && towers_nodes_count > 0) {
          local tower_id = null;
          for (local towers_node_index = 0; towers_node_index < towers_nodes_count; towers_node_index++) {
            tower_id = DM_GetArrayNodeValue ("dysmantle/towers.xml", stage, towers_node_index, "id");
            local chunkstr = DM_GetArrayNodeValue ("dysmantle/towers.xml", stage, towers_node_index, "chunks");
            if (tower_id != null && chunkstr != null) {
              if (split (chunkstr, ",").find(chunk) != null) {
                area_num = towers_node_index;
                break;
              }
            }
          }
          if (tower_id == null || Game_IsTransmitterInstalled (tower_id, "TRANSMITTER_ENEMY_RESPAWN_DISABLER") != true || Game_GetTowerAreaLevel (tower_id) < 1) {
            Game_AddActorNotification (player, LocalizeText("Level Up Link Towers."));
            area_num = null;
          }
        }
      }
    }
    if (area_num == null) {
      if (Actor_IsAnimationPlaying (player, "not_here") != true) {
        Actor_QueueActionPlayAnimationWithParameters (player, "not_here", 1.0, 0.0, false);
      }
    } else {
      was_trigger_held_down = false;
      Game_DisableMovementForPlayer (player, 1.5, true);
      if (Actor_IsAnimationPlaying (player, "acquired_new_tool") != true) {
        Actor_QueueActionPlayAnimationWithParameters (player, "acquired_new_tool", 1.0, 0.0, false);
      }
    }
  }
}


function Mod_BioWeapon_OnTriggerHoldDown_Item() {
  if (area_num != null && was_trigger_held_down == false) {
    was_trigger_held_down = true;
  }
}


function Mod_BioWeapon_OnTriggerCancel_Item() {
  if (was_trigger_held_down == true && Actor_IsAnimationPlaying (player, "not_here") != true) {
    Actor_QueueActionPlayAnimationWithParameters (player, "not_here", 1.0, 0.0, false);
  }
  was_trigger_held_down = null;
}


function Mod_BioWeapon_OnTriggerUp_Item() {
  if (was_trigger_held_down == true) {
    local angle = StageObject_GetAngle (player);
    if (angle != null) {
      if (Actor_IsAnimationPlaying (player, "lighting_a_fire") != true) {
        Game_DisableMovementForPlayer (player, 1.06, false);
        Actor_QueueActionPlayAnimationWithParameters (player, "lighting_a_fire", 2.0, 0.0, false);
      }
      Stage_RunScriptDelayed (@"NX_PlaySound (""sfx/physics/glass-hit-01"", 0.4, 0.0, 1.0);", 0.8, player);
      Stage_RunScriptDelayed (@"NX_PlaySound (""sfx/physics/glass-break-02"", 0.4, 0.0, 1.0);", 0.95, player);
      Stage_RunScriptDelayed (@"NX_PlaySound (""sfx/ambience/toxic-bubble-pop-01"", 1.0, 0.0, 1.0); NX_PlaySound (""sfx/ambience/toxic-pond-bubbles-loop"", 1.0, 0.0, 1.0);", 1.1, player);
      local radian = m_anglemod (angle * PI / 180.0);
      local position_x = position[0].tofloat() + cos(radian) * 45.0;
      local position_y = position[1].tofloat() + sin(radian) * 45.0;
      local ground_z = Stage_GetGroundZAtPosition (position_x, position_y);
      if (ground_z != null) {
        local script = @"
            Stage_SpawnEffect (""effects/acid-hit-concrete.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat(), 0.0);
            Stage_SpawnEffect (""effects/black-smoke-rising-large.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat(), 0.0);
            Stage_SpawnEffect (""effects/dark-fog.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat() - 10.0, 0.0);
            Stage_SpawnEffect (""effects/dark-smooth-fog.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat() - 10.0, 0.0);
            Stage_SpawnEffect (""effects/ethereal-smoke.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat() - 20.0, 0.0);
            Stage_SpawnEffect (""effects/hurler-shooting-green-splash.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat() - 20.0, 0.0);
            Stage_SpawnEffect (""effects/mana-puddle-death.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat(), 0.0);
            Stage_SpawnEffect (""effects/puke-areal-puddle.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat(), 0.0);
            Stage_SpawnEffect (""effects/puke-fountain.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat() - 20.0, 0.0);
            Stage_SpawnEffect (""effects/puke-projectile.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat(), 0.0);
            Stage_SpawnEffect (""effects/puke-puddle-death.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat(), 0.0);
            Stage_SpawnEffect (""effects/puke-puddle-impact.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat(), 0.0);
            Stage_SpawnEffect (""effects/puke-spit.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat() - 20.0, 0.0);
            Stage_SpawnEffect (""effects/shelter-dweller-death.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat(), 0.0);
            Stage_SpawnEffect (""effects/smelter-smoke.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat(), 0.0);
            Stage_SpawnEffect (""effects/wolf-bite.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat() - 30.0, 0.0);
            Stage_SpawnEffect (""effects/wolf-bite.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat() - 30.0, 0.0);
            Stage_SpawnEffect (""effects/wolf-bite.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat() - 30.0, 0.0);
            Stage_SpawnEffect (""effects/wolf-bite.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat() - 30.0, 0.0);
            Stage_SpawnEffect (""effects/mana-sparkles-green.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat(), 0.0);
            Stage_SpawnEffect (""effects/mana-sparkles-green.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat(), 0.0);
            Stage_SpawnEffect (""effects/mana-sparkles-green.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat(), 0.0);
            Stage_SpawnEffect (""effects/mana-sparkles-green.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat(), 0.0);
            Stage_SpawnEffect (""effects/mana-sparkles-green.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat(), 0.0);
            Stage_SpawnEffect (""effects/mana-sparkles-green.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat(), 0.0);
            Stage_SpawnEffect (""effects/mana-sparkles-green.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat(), 0.0);
            Stage_SpawnEffect (""effects/mana-sparkles-green.xml"", ""$x"".tofloat(), ""$y"".tofloat(), ""$z"".tofloat(), 0.0);
          ";
        script = string_replace(script, "$x", position_x.tostring());
        script = string_replace(script, "$y", position_y.tostring());
        script = string_replace(script, "$z", ground_z.tostring());
        Stage_RunScriptDelayed (script, 1.1, player);
      }
    }
    local destroyed = 0;
    local killed = 0;
    local pois = stage.slice(0, stage.len() - 10) + "/points-of-interest.xml";
    local has_turrets_everywhere = NX_FileExists ("scripts/mods/mod-turrets-everywhere.nut");
    for (local pois_node_index = 0; pois_node_index < DM_GetArrayNumberOfNodes (pois, stage); pois_node_index++) {
      if (DM_GetArrayNodeValue (pois, stage, pois_node_index, "area") == area_num.tostring()
      && [ "ENEMY_NORMAL", "ENEMY_STATIONARY" ].find(DM_GetArrayNodeValue (pois, stage, pois_node_index, "type")) != null) {
        local puid = DM_GetArrayNodeValue (pois, stage, pois_node_index, "puid");
        if (puid != null && Game_IsPUIDMarkedDestroyed (puid.tointeger()) != true
        && (has_turrets_everywhere != true || (stage == "stages/dlc2/index.xml" && chitin_whitelist_puids.find(puid.tointeger()) != null))) {
          local monster = Stage_GetStageObjectByPUID (puid.tointeger());
          if (monster == null) {
            Game_MarkStageObjectPUIDPersistentlyDestroyed (puid.tointeger(), true);
            destroyed++;
          } else {
            local actor_type = Actor_GetActorType (monster);
            if (actor_type != null && StageObject_HasTag (monster, "BOSS") != true && StageObject_HasTag (monster, "MECHANICAL") != true
            && StageObject_IsValid (monster) == true && StageObject_IsEnabled (monster) == true && StageObject_IsVisible (monster) == true) {
              Stage_KillActorAndStartDeathAnimation (monster);
              local health = Actor_GetAttributeHitPoints (monster);
              if (health != null && health > 0.0) {
                if ([ "actors/enemies/mana-spirit.xml", "actors/enemies/boss-mana-spirit.xml", "actors/enemies/night-terror-mana-spirit.xml" ].find(actor_type) != null) {
                  StageObject_SetKeyValueFloat (monster, "vulnerability_timer", 60.0 * 60.0);
                }
                Stage_DealDamage (player, monster, health * 1.1, "EXPLOSIVE");
              }
              killed++;
            }
          }
        }
      }
    }
    if ((killed + destroyed) > 0) {
      Game_TrySpendMaterials (Mod_BioWeapon_OnMetadataRead_Item().required_material, Mod_BioWeapon_OnMetadataRead_Item().material_cost);
      local multiplier = destroyed;
      if (destroyed > 0) {
        local modifiers_kvs = Game_GetAllPlayerModifiersAsKeyValueStore (player);
        local material_drop_percentage_increase = KeyValueStore_GetKeyValue (modifiers_kvs, "material_drop_percentage_increase");
        if (material_drop_percentage_increase == null) material_drop_percentage_increase = 0.0;
        multiplier = multiplier.tofloat() * (1.0 + material_drop_percentage_increase.tofloat() * 0.01);
        multiplier = floor(multiplier);
        local script = @"Game_SpawnMaterials (""$player"".tointeger(), ""$player"".tointeger(), ""$materials"");";
        script = string_replace(script, "$player", player.tostring());
        script = string_replace(script, "$materials", multiplier.tostring() + "xMANA_BEAD");
        Stage_RunScriptDelayed (script, 4.0, player);
      }
      Game_LogEvent ("MOD_BIOWEAPON", (killed + destroyed).tostring(), multiplier.tostring());
    }
  }
  was_trigger_held_down = null;
}


function Mod_BioWeapon_OnInitialize_Item (so_handle_owner, item_id) {
  player = so_handle_owner;
  return true;
}


function Mod_BioWeapon_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_bioweapon_craft":
        if (Game_IsRecipeCrafted ("MOD_BIOWEAPON") != true) {
          Game_CraftRecipe ("MOD_BIOWEAPON", true);
        }
        UI_SetProperty ("mod_bioweapon_craft", "active", false);
        break;
      case "mod_bioweapon_title":
        Mods_Info_Popup (
            LocalizeText("Bioweapon"),
            LocalizeText("Exterminate all minions in a tower area if the tower is over +1 ascension level. Costs 50 potatoes. Helps with ascending all towers to +3."));
        break;
    }
  }
}


function Mod_BioWeapon_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_bioweapon_craft", "active", Game_IsRecipeCrafted ("MOD_BIOWEAPON") == true ? false : true);
  UI_SetProperty ("mod_bioweapon_craft", "button.text", LocalizeText("Craft"));
  UI_SetProperty ("mod_bioweapon_title", "textbox.text", LocalizeText("Bioweapon"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
