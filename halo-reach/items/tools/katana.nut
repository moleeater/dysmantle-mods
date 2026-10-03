// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
ATTACK_PLAYBACK_SPEED <- 1.0;
ATTACK_DELAY <- 0.05;
POWER_ATTACK_DELAY <- -0.9;
STANCE_OVERRIDE <- "katana"
local modifiers = [
    {
      additional_melee_targets_increase_vs_monsters = 1
    },
    {
      additional_melee_targets_increase_vs_monsters = 1
      melee_damage_percentage_increase_vs_tag_MONSTER = 40.0
    },
    {
      additional_melee_targets_increase_vs_monsters = 1
      melee_damage_percentage_increase_vs_tag_MONSTER = 40.0
      critical_hit_chance_absolute_increase = 1.5
    },
    {
      additional_melee_targets_increase_vs_monsters = 1
      melee_damage_percentage_increase_vs_tag_MONSTER = 80.0
      critical_hit_chance_absolute_increase = 1.5
    },
    {
      additional_melee_targets_increase_vs_monsters = 2
      melee_damage_percentage_increase_vs_tag_MONSTER = 80.0
      critical_hit_chance_absolute_increase = 3.0
    },
    {
      additional_melee_targets_increase_vs_monsters = 2
      melee_damage_percentage_increase_vs_tag_MONSTER = 120.0
      critical_hit_chance_absolute_increase = 3.0
    }
  ];


function OnMetadataRead() {
  return {
      type = "melee_weapon"
      stance = "melee_2h"
      prop = "actors/tools/katana.xml"
      prop_bone = "tool"
      name = "Katana"
      description = "Deadly blade weapon inspired by the Land of the Rising Sun."
      icon = "items/tools/katana.png"
      attack_cone_angle = 360.0
      basic_attack_range = 80.0
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
