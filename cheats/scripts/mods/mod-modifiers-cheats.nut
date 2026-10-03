// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local modifiers_cheats = {
    "speedhack": {
      "modifiers": { "time_modifier_percentage_increase": 125.0, },
      "state_name": "enabled",
      "info_title": "Speedhack",
      "info_text" : "Maximize game speed to make everything happen faster.",
      "limit_stages": [ "is_tomb", "is_pet_stage", "has_force_player_unarmed" ],
    },
    "stealth": {
      "modifiers": {
        "enemy_aggro_range_percentage_decrease": 100.0,
        "animal_friend_effect_percentage_increase": 200.0,
      },
      "state_name": "enabled",
      "info_title": "Stealth",
      "info_text" : "Minimize enemy aggro distance so you can casually walk past the monsters.",
    },
    "temperature_protection": {
      "modifiers": {
        "cold_protection_absolute_increase": 70.0,
        "heat_protection_absolute_increase": 80.0,
      },
      "state_name": "enabled",
      "info_title": "Temperature protection",
      "info_text" : "Ignore temperature changes, both hot and cold, without equipping anything.",
    },
    "god_mode": {
      "modifiers": {
        "damage_reduction_percentage_increase_vs_damage_type_UNSPECIFIED": 155.0,
        "damage_reduction_percentage_increase_vs_damage_type_SLASHING": 155.0,
        "damage_reduction_percentage_increase_vs_damage_type_PIERCING": 155.0,
        "damage_reduction_percentage_increase_vs_damage_type_FIRE": 155.0,
        "damage_reduction_percentage_increase_vs_damage_type_POISON": 155.0,
        "damage_reduction_percentage_increase_vs_damage_type_EXPLOSIVE": 155.0,
        "damage_reduction_percentage_increase_vs_damage_type_PROJECTILE": 155.0,
      },
      "state_name": "enabled",
      "info_title": "God mode",
      "info_text" : "No damage from enemies and some puzzle objects.",
    },
    "faster_melee": {
      "modifiers": {
        "melee_attack_delay_percentage_decrease": 100.0,
        "melee_attack_speed_percentage_increase": 100.0,
      },
      "state_name": "enabled",
      "info_title": "Faster melee",
      "info_text" : "Melee attacks are faster, no attack delays and attack speeds are doubled.",
      "video_url" : "https://e934.short.gy/dysmantle-mod-faster-melee-video",
    },
    "instant_farming": {
      "modifiers": { "plant_grow_speed_percentage_increase": 5900000.0, },
      "state_name": "enabled",
      "info_title": "Instant farming",
      "info_text" : "Farm crops grow to full size immediatelly.",
      "video_url" : "https://e934.short.gy/dysmantle-mod-instant-farming-video",
    },
    "speed_fishing": {
      "modifiers": { "fishing_speed_percentage_increase": 19000.0, },
      "state_name": "enabled",
      "info_title": "Speed fishing",
      "info_text" : "Fishing is so fast, fish are flying out of the water. No need for equipping trinket.",
      "video_url" : "https://e934.short.gy/dysmantle-mod-speed-fishing-video",
    },
    "more_melee_targets": {
      "modifiers": {
        "additional_melee_targets_increase_vs_monsters": 900.0,
        "additional_melee_targets_increase_vs_objects": 900.0,
      },
      "state_name": "enabled",
      "info_title": "More melee targets",
      "info_text" : "Attack +90 additional monsters and objects on every melee swing.",
    },
    "material_magnet_plus": {
      "modifiers": { "material_collect_distance_percentage_increase": 1.0, },
      "state_name": "percent",
      "max_value": 6000.0,
      "info_title": "Material magnet+",
      "info_text" : "Collect materials from far away, magnet radius increased. Higher values need faster CPU.",
      "video_url" : "https://e934.short.gy/dysmantle-mod-material-magnet-plus-video",
    },
    "loot_drop_bonus": {
      "modifiers": { "material_drop_percentage_increase": 100.0, },
      "state_name": "amount",
      "max_value": 9.0,
      "info_title": "Loot drop bonus",
      "info_text" : "Extra materials dropped from objects, gatherables, mana beads.",
    },
    "one_hit_enemies": {
      "modifiers": {
        "melee_damage_percentage_increase_vs_tag_ANIMAL": 1500.0,
        "melee_damage_percentage_increase_vs_tag_BOSS": 325000.0,
        "melee_damage_percentage_increase_vs_tag_MECHANICAL": 9400.0,
        "melee_damage_percentage_increase_vs_tag_MONSTER": 87500.0,
        "throwable_weapon_damage_percentage_increase_vs_tag_ANIMAL": 600.0,
        "throwable_weapon_damage_percentage_increase_vs_tag_BOSS": 130000.0,
        "throwable_weapon_damage_percentage_increase_vs_tag_MECHANICAL": 3800.0,
        "throwable_weapon_damage_percentage_increase_vs_tag_MONSTER": 35000.0,
      },
      "state_name": "enabled",
      "info_title": "One hit enemies",
      "info_text" : "Kill everything in just one hit: monsters, minions, bosses, mechanical turrets, animals, deer.",
    },
  };


Include ("scripts/mods/mod-modifiers.nut");


function Mod_Modifiers_Cheats_OnEnter_Stage() {
  Mod_Modifiers_OnEnter_Stage (modifiers_cheats);
  Game_CheatCraftOrUncraftRecipe ("MOD_MATERIAL_MAGNET_PLUS", false);
  Game_RemoveWorldState ("MODS", "material_magnet_plus_enabled");
  Game_RemoveWorldState ("MODS", "foraging_enabled");
  Game_RemoveWorldState ("MODS", "stunning_pets_enabled");
  Game_RemoveWorldState ("MODS", "hypercritical_enabled");
  foreach (player_index in [0,1]) {
    local player = Game_GetPlayerActor (player_index);
    if (player != null) {
      Game_SetTemporaryModifier (player, "mod_material_magnet_plus_enabled", 0.0, "material_collect_distance_percentage_increase", 0.0);
      Game_SetTemporaryModifier (player, "mod_foraging_enabled", 0.0, "extra_gatherable_chance_percentage_increase", 0.0);
      Game_SetTemporaryModifier (player, "mod_foraging_enabled", 0.0, "search_efficiency_absolute_increase", 0.0);
      if (Game_GetWorldState ("MODS", "stealth_enabled", "0") == "1") {
        Game_SetTemporaryModifier (player, "mod_stealth_enabled", 50000000.0, "animal_friend_effect_percentage_increase", 200.0);
      }
      Game_SetTemporaryModifier (player, "mod_stunning_pets_enabled", 0.0, "pet_stun_chance_absolute_increase", 0.0);
      Game_SetTemporaryModifier (player, "mod_hypercritical_enabled", 0.0, "critical_hit_chance_absolute_increase", 0.0);
      Game_SetTemporaryModifier (player, "mod_hypercritical_enabled", 0.0, "critical_hit_damage_percentage_increase", 0.0);
    }
  }
}


function Mod_Modifiers_Cheats_OnCoopPlayerJoined_ProtagonistReactions (primary_player, coop_player) {
  Mod_Modifiers_OnCoopPlayerJoined_ProtagonistReactions (modifiers_cheats, primary_player, coop_player);
}


function Mod_Modifiers_Cheats_OnClick_OptionsUnified (clicked) {
  if (clicked == "mod_instant_farming_enabled") {
    UI_SetVisible ("mod_instant_farming_enabled_warning", true);
  }
  Mod_Modifiers_OnClick_OptionsUnified (modifiers_cheats, clicked);
}


function Mod_Modifiers_Cheats_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_instant_farming_enabled_warning", "textbox.text", LocalizeText("To trigger the change, you need to rest at a campfire."));
  UI_SetVisible ("mod_instant_farming_enabled_warning", false);
  Mod_Modifiers_OnEnter_OptionsUnified (modifiers_cheats, stage_in_stack);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
