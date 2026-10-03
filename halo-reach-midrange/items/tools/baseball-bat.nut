// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
ATTACK_PLAYBACK_SPEED <- 1.0;
ATTACK_DELAY <- 0.05;
POWER_ATTACK_DELAY <- -0.9;
local modifiers = [
    {
      power_attack_damage_percentage_increase = 25.0
    },
    {
      power_attack_damage_percentage_increase = 30.0
    },
    {
      knockback_strength_absolute_increase = 110.0
      power_attack_damage_percentage_increase = 30.0
    },
    {
      knockback_strength_absolute_increase = 110.0
      power_attack_damage_percentage_increase = 60.0
    },
    {
      knockback_strength_absolute_increase = 220.0
      power_attack_damage_percentage_increase = 60.0
    },
    {
      knockback_strength_absolute_increase = 220.0
      power_attack_damage_percentage_increase = 100.0
    }
  ];


function OnMetadataRead() {
  return {
      type = "melee_weapon"
      stance = "melee_2h"
      prop = "actors/tools/baseball-bat.xml"
      prop_bone = "tool"
      name = "Baseball Bat"
      description = "Originally used to hit balls very far, but should double as a handy weapon."
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
