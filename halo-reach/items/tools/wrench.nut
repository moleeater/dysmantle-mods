// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
ATTACK_PLAYBACK_SPEED <- 0.73;
ATTACK_DELAY <- -0.225;
POWER_ATTACK_DELAY <- -0.9;
local modifiers = [
    {
      power_attack_damage_percentage_increase = 40.0
    },
    {
      power_attack_damage_percentage_increase = 40.0
    },
    {
      power_attack_damage_percentage_increase = 40.0
      additional_melee_targets_increase_vs_objects = 1
    },
    {
      power_attack_damage_percentage_increase = 80.0
      additional_melee_targets_increase_vs_objects = 1
    },
    {
      power_attack_damage_percentage_increase = 80.0
      additional_melee_targets_increase_vs_objects = 2
    },
    {
      power_attack_damage_percentage_increase = 120.0
      additional_melee_targets_increase_vs_objects = 2
    }
  ];


function OnMetadataRead() {
  return {
      type = "melee_weapon"
      stance = "melee_2h"
      prop = "actors/tools/wrench.xml"
      prop_bone = "tool"
      name = "Wrench"
      description = "Tool originally used for applying torque to objects like nuts and bolts. Great for smashing things apart."
      attack_cone_angle = 360.0
      basic_attack_range = 65.0
      power_attack_range = 100.0
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
