// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local throttle_realseconds = 0.5;
local blacklist_item_ids = [
    "items/tools/animal-treats.nut",
    "items/tools/beam-gun.nut",
    "items/tools/builder.nut",
    "items/tools/crossbow.nut",
    "items/tools/dart-gun.nut",
    "items/tools/fish-food-bag.nut",
    "items/tools/fists.nut",
    "items/tools/hands-free.nut",
    "items/tools/hunting-rifle.nut",
    "items/tools/mana-crossbow.nut",
    "items/tools/managun.nut",
    "items/tools/paint-brush.nut",
    "items/tools/seed-bag-mana.nut",
    "items/tools/seed-bag.nut",
    "items/tools/shotgun-sawed-off.nut",
    "items/tools/shotgun.nut",
    "items/tools/unarmed.nut",
    "items/tools/mod-mark-chunk.nut",
    "items/tools/mod-bioweapon.nut",
  ];
local blacklist_animation_actions = [
    "acquired_new_tool",
    "activate_material_transporter",
    "aim",
    "aim_and_fire_weapon",
    "aim_builder_tool",
    "bandage",
    "block_with_shield",
    "catching-fish",
    "change_next_tool",
    "climb_down_ladder_from_top",
    "climb_down_shelter",
    "climb_up_ladder",
    "climb_up_shelter",
    "cough",
    "die",
    "die-2",
    "die-3",
    "die_by_fire",
    "die_of_cold",
    "die_of_gas",
    "die_of_heat",
    "die_of_nothing",
    "digging_once",
    "digging_once_failed",
    "dodge_roll",
    "drown",
    "eat",
    "emote",
    "enter_escapepod",
    "enter_tomb_inside",
    "enter_tomb_outside",
    "exit_tomb",
    "fall",
    "fishing",
    "hit",
    "hit_barbed",
    "hoeing_once",
    "home_portal_used",
    "interaction_loop",
    "interaction_once",
    "landing",
    "landing_damage",
    "landing_dead",
    "lighting_a_fire",
    "melee-hit-effect-60",
    "melee",
    "melee_power_attack",
    "name115",
    "name5195",
    "not_here",
    "pet_animal",
    "pet_animal_low",
    "plant_seed",
    "plant_seed_3x3",
    "primary_throw",
    "recoil",
    "reload",
    "rope_ascend",
    "rope_descend",
    "search-container",
    "secondary_depleted",
    "secondary_drink",
    "secondary_drop",
    "secondary_throw",
    "sitting-down-to-fish",
    "sitting_down",
    "sitting_down_in_chair",
    "sitting_down_in_chair_loop_1",
    "sitting_on_ground",
    "sitting_up",
    "sleep",
    "standing-up-from-fishing",
    "standing_up_from_chair",
    "teleport_in",
    "teleport_out",
    "throw_fish_food",
    "tool_equip",
    "tool_unequip",
    "use_respawn_device",
    "whistle_call",
  ];
local action = {
    "name"      : "auto_attack",
    "title"     : "Automatic attack",
    "desc"      : "Enable continuous attack with a custom keypress. Accessibility mod if you have repetitive strain injury or a mobility impairment."
        + (NX_ProductFeatureExists ("MOBILE_UI") == true
          ? "\n\n" + LocalizeText("On mobile UI you can use the button near the minimap.") : ""),
    "per_player": true,
  };
local stage_kvs = null;
local last_time = [ null, null ];


Include ("scripts/mods/mods-info.nut");
Include ("scripts/mods/mods-controller.nut");


function Mod_AutoAttack_OnUpdate_Stage (tdelta) {
  Mods_Controller_OnUpdate_Stage (action, tdelta);
  if (Game_IsCinemaModeEnabled() != true && UI_IsScreenInStack ("PauseMenu") != true && stage_kvs != null && UI_IsScreenInStack ("CodeEditor") != true) {
    local players = Mods_Controller_GetPlayers (action);
    if (NX_ProductFeatureExists ("MOBILE_UI") == true) {
      UI_SetVisible ("mod_auto_attack", Game_GetWorldState ("MODS", "cheats_used") == "1" && Game_GetPrimaryPlayerControllerTypeAsAsString() == "TOUCH" && KeyValueStore_GetKeyValue (stage_kvs, "force_player_unarmed", false) != true ? true : false);
    }
    foreach (player_index, player_data in players) {
      if (player_data.player == null) {
        KeyValueStore_SetKeyValueBoolean (stage_kvs, "mod_" + action.name + "_player_" + player_index, false);
        last_time[player_index] = null;
      } else {
        local enabled = KeyValueStore_GetKeyValue (stage_kvs, "mod_" + action.name + "_player_" + player_index);
        local now = NX_GetTime();
        if (player_data.key_state != null && (last_time[player_index] == null || last_time[player_index] < now - throttle_realseconds.tofloat() * 1000.0)) {
          last_time[player_index] = now;
          enabled = enabled == true ? false : true;
          KeyValueStore_SetKeyValueBoolean (stage_kvs, "mod_" + action.name + "_player_" + player_index, enabled);
        }
        if (enabled == true && player_data.player != null) {
          local tool_id = Game_GetEquippedItemInActiveSlot (player_data.player, "TOOLS");
          local is_playing_animations = blacklist_animation_actions.map(@(action) Game_IsPlayingAnimationByAction (player_data.player, action));
          if (tool_id != null && blacklist_item_ids.find(tool_id) == null && is_playing_animations.find(true) == null) {
            Game_PlayAnimationByAction (player_data.player, "melee");
          }
        }
      }
    }
  }
}


function Mod_AutoAttack_OnClick_Stage (clicked) {
  if (clicked == "mod_auto_attack" && stage_kvs != null) {
    local enabled = KeyValueStore_GetKeyValue (stage_kvs, "mod_" + action.name + "_player_0");
    enabled = enabled == true ? false : true;
    KeyValueStore_SetKeyValueBoolean (stage_kvs, "mod_" + action.name + "_player_0", enabled);
  }
}


function Mod_AutoAttack_OnEnter_Stage() {
  stage_kvs = Stage_GetKeyValueStore();
  Mods_Controller_OnEnter_Stage (action);
}


function Mod_AutoAttack_OnClick_OptionsUnified (clicked) {
  Mods_Controller_OnClick_OptionsUnified (action, clicked);
}


function Mod_AutoAttack_OnEnter_OptionsUnified (stage_in_stack) {
  Mods_Controller_OnEnter_OptionsUnified (action, stage_in_stack);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
