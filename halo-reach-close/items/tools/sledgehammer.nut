// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
ATTACK_PLAYBACK_SPEED <- 0.7;
ATTACK_DELAY <- 0.0;
POWER_ATTACK_PLAYBACK_SPEED <- 0.85;
POWER_ATTACK_DELAY <- -0.55;
local modifiers = [
    {
      power_attack_damage_percentage_increase = 50.0
      stun_chance_absolute_increase = 20.0
    },
    {
      power_attack_damage_percentage_increase = 60.0
      additional_melee_targets_increase_vs_objects = 1
    },
    {
      stun_chance_absolute_increase = 10.0
      power_attack_damage_percentage_increase = 60.0
      additional_melee_targets_increase_vs_objects = 1
    },
    {
      stun_chance_absolute_increase = 10.0
      power_attack_damage_percentage_increase = 120.0
      additional_melee_targets_increase_vs_objects = 2
    },
    {
      stun_chance_absolute_increase = 20.0
      power_attack_damage_percentage_increase = 120.0
      additional_melee_targets_increase_vs_objects = 2
    },
    {
      stun_chance_absolute_increase = 20.0
      power_attack_damage_percentage_increase = 180.0
      additional_melee_targets_increase_vs_objects = 3
    }
  ];


function OnMetadataRead() {
  return {
      type = "melee_weapon"
      stance = "melee_2h"
      prop = "actors/tools/sledgehammer.xml"
      prop_bone = "tool"
      name = "Sledgehammer"
      description = "Heavyweight tool adept at breaking objects and structures."
      icon = "items/tools/sledgehammer.png"
      attack_cone_angle = 360.0
      basic_attack_range = 240.0
      power_attack_range = 240.0
      damage_increase_per_upgrade_level = 6
    };
}


function OnModifiersRead() {
  return modifiers[0];
}


function GetModifiersForUpgradeLevel (level) {
  return level == null || modifiers.len() <= level.tointeger() ? {} : modifiers[level.tointeger()];
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function OnDamageDealt (so_dealer, so_target, damage_position, damage, is_power_attack) {
  local amplitude = damage * 0.05;
  if (amplitude > 6) {
    amplitude = 6;
  }
  if (is_power_attack) {
    Game_AddCameraShake (amplitude * 1.5, 3.0, 0.75);
  } else {
    Game_AddCameraShake (amplitude, 5.0, 0.5);
  }
}


Include("items/tools/utils/melee-attack.nut");
