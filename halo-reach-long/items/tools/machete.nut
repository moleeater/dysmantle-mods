// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
ATTACK_PLAYBACK_SPEED <- 1.0;
ATTACK_DELAY <- 0.02;
POWER_ATTACK_DELAY <- -0.6;
local modifiers = [
    {
      critical_hit_damage_percentage_increase = 30.0
      power_attack_damage_percentage_increase = 30.0
    },
    {
      critical_hit_damage_percentage_increase = 30.0
    },
    {
      critical_hit_damage_percentage_increase = 30.0
      melee_damage_percentage_increase_vs_tag_MONSTER = 10.0
    },
    {
      critical_hit_damage_percentage_increase = 60.0
      melee_damage_percentage_increase_vs_tag_MONSTER = 10.0
    },
    {
      critical_hit_damage_percentage_increase = 60.0
      melee_damage_percentage_increase_vs_tag_MONSTER = 20.0
    },
    {
      critical_hit_damage_percentage_increase = 90.0
      melee_damage_percentage_increase_vs_tag_MONSTER = 20.0
    }
  ];


function OnMetadataRead() {
  return {
      type = "melee_weapon"
      stance = "melee_1h"
      prop = "actors/tools/machete.xml"
      prop_bone = "tool"
      name = "Machete"
      description = "A weapon with a broad blade usable both in combat and gardening."
      icon = "items/tools/machete.png"
      attack_cone_angle = 360.0
      basic_attack_range = 960.0
      power_attack_range = 960.0
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
