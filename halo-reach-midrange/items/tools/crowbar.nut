// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
ATTACK_PLAYBACK_SPEED <- 1.0;
ATTACK_DELAY <- 0.0;
POWER_ATTACK_DELAY <- -0.9;
local modifiers = [
    {
      power_attack_damage_percentage_increase = 60.0
    },
    {
      critical_hit_chance_absolute_increase = 0.5
      power_attack_damage_percentage_increase = 8.0
    },
    {
      critical_hit_chance_absolute_increase = 0.5
      power_attack_damage_percentage_increase = 16.0
    },
    {
      critical_hit_chance_absolute_increase = 1.0
      power_attack_damage_percentage_increase = 24.0
    },
    {
      critical_hit_chance_absolute_increase = 1.0
      power_attack_damage_percentage_increase = 32.0
    },
    {
      critical_hit_chance_absolute_increase = 1.5
      power_attack_damage_percentage_increase = 40.0
    }
  ];


function OnMetadataRead() {
  return {
      type = "melee_weapon"
      stance = "melee_1h"
      prop = "actors/tools/crowbar.xml"
      prop_bone = "tool"
      name = "Crowbar"
      description = "Can be used for defense and to break lightweight objects."
      attack_cone_angle = 360.0
      basic_attack_range = 480.0
      power_attack_range = 480.0
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
