// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
ATTACK_PLAYBACK_SPEED <- 0.85;
ATTACK_DELAY <- -0.0;
POWER_ATTACK_DELAY <- -0.9;
local modifiers = [
    {
      power_attack_damage_percentage_increase = 50.0
    },
    {
      slow_chance_absolute_increase = 10.0
    },
    {
      slow_chance_absolute_increase = 10.0
      power_attack_damage_percentage_increase = 50.0
    },
    {
      slow_chance_absolute_increase = 30.0
      power_attack_damage_percentage_increase = 50.0
      additional_melee_targets_increase_vs_objects = 1
    },
    {
      slow_chance_absolute_increase = 30.0
      power_attack_damage_percentage_increase = 100.0
      additional_melee_targets_increase_vs_objects = 1
    },
    {
      slow_chance_absolute_increase = 50.0
      power_attack_damage_percentage_increase = 100.0
      additional_melee_targets_increase_vs_objects = 2
    }
  ];


function OnMetadataRead() {
  return {
      type = "melee_weapon"
      stance = "melee_1h"
      prop = "actors/tools/axe.xml"
      prop_bone = "tool"
      name = "Axe"
      description = "Sharp and sturdy. Can be used to hack things to pieces."
      icon = "items/tools/axe.png"
      attack_cone_angle = 360.0
      basic_attack_range = 480.0
      power_attack_range = 480.0
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


Include("items/tools/utils/melee-attack.nut");
