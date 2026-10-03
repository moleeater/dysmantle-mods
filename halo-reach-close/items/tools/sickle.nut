// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
ATTACK_PLAYBACK_SPEED <- 1.0;
ATTACK_DELAY <- 0.0;
POWER_ATTACK_DELAY <- -0.9;
local modifiers = [
    {
      additional_melee_targets_increase_vs_objects = 1
      power_attack_damage_percentage_increase = 15.0
    },
    {
      backstab_critical_chance_absolute_increase = 1.5
    },
    {
      backstab_critical_chance_absolute_increase = 1.5
      additional_melee_targets_increase_vs_objects = 1
    },
    {
      backstab_critical_chance_absolute_increase = 3.0
      additional_melee_targets_increase_vs_objects = 1
    },
    {
      backstab_critical_chance_absolute_increase = 3.0
      additional_melee_targets_increase_vs_objects = 2
    },
    {
      backstab_critical_chance_absolute_increase = 4.5
      additional_melee_targets_increase_vs_objects = 2
    }
  ];


function OnMetadataRead() {
  return {
      type = "melee_weapon"
      stance = "melee_1h"
      prop = "actors/tools/sickle.xml"
      prop_bone = "tool"
      name = "Sickle"
      description = "An agricultural tool convenient for cutting down several foliages and bushes at once."
      attack_cone_angle = 360.0
      basic_attack_range = 240.0
      power_attack_range = 240.0
      damage_increase_per_upgrade_level = 4
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
