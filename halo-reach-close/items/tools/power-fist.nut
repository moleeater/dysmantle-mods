// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
ATTACK_PLAYBACK_SPEED <- 0.6;
ATTACK_DELAY <- 0.0;
POWER_ATTACK_PLAYBACK_SPEED <- 1.0;
POWER_ATTACK_DELAY <- -0.5;
STANCE_OVERRIDE <- "powerfist"
local modifiers = [
    {
      additional_melee_targets_increase_vs_objects = 1
      knockback_strength_absolute_increase = 100.0
      power_attack_damage_percentage_increase = 40.0
    },
    {
      knockback_strength_absolute_increase = 100.0
      power_attack_damage_percentage_increase = 40.0
      additional_melee_targets_increase_vs_objects = 1
    },
    {
      knockback_strength_absolute_increase = 200.0
      power_attack_damage_percentage_increase = 80.0
      additional_melee_targets_increase_vs_objects = 1
    },
    {
      knockback_strength_absolute_increase = 300.0
      power_attack_damage_percentage_increase = 120.0
      additional_melee_targets_increase_vs_objects = 2
    },
    {
      knockback_strength_absolute_increase = 400.0
      power_attack_damage_percentage_increase = 160.0
      additional_melee_targets_increase_vs_objects = 2
    },
    {
      knockback_strength_absolute_increase = 500.0
      power_attack_damage_percentage_increase = 200.0
      additional_melee_targets_increase_vs_objects = 3
    }
  ];


function OnMetadataRead() {
  return {
      type = "melee_weapon"
      stance = "hands_free"
      prop = "actors/tools/power-fist.xml"
      prop_bone = "tool"
      name = "Power Fist"
      description = "Mechanical gauntlet that greatly enhances the punch strength."
      attack_cone_angle = 360.0
      basic_attack_range = 240.0
      power_attack_range = 240.0
      damage_increase_per_upgrade_level = 5
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
