// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
ATTACK_PLAYBACK_SPEED <- 1.0;
ATTACK_DELAY <- 0.2;
POWER_ATTACK_DELAY <- -0.6;
STANCE_OVERRIDE <- "khopesh"
local modifiers = [
    {
      power_attack_damage_percentage_increase = 30.0
    },
    {
      power_attack_damage_percentage_increase = 30.0
      critical_hit_damage_percentage_increase = 33.3
    },
    {
      power_attack_damage_percentage_increase = 60.0
      critical_hit_chance_absolute_increase = 2.0
      critical_hit_damage_percentage_increase = 33.3
    },
    {
      power_attack_damage_percentage_increase = 90.0
      critical_hit_chance_absolute_increase = 2.0
      critical_hit_damage_percentage_increase = 66.6
    },
    {
      power_attack_damage_percentage_increase = 120.0
      critical_hit_chance_absolute_increase = 4.0
      critical_hit_damage_percentage_increase = 66.6
    },
    {
      power_attack_damage_percentage_increase = 150.0
      critical_hit_chance_absolute_increase = 5.0
      critical_hit_damage_percentage_increase = 100.0
    }
  ];


function OnMetadataRead() {
  return {
      type = "melee_weapon"
      stance = "melee_2h"
      prop = "actors/tools/khopesh.xml"
      prop_bone = "tool"
      name = "Khopesh"
      description = "Powerful sickle-shaped sword wielded by the ancient tomb guards. Forged from Mana-infused metals."
      icon = "items/tools/khopesh.png"
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
