// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local modifiers_quality_of_life = {
    "unlimited_builds": {
      "modifiers": { "build_limit_increase": 10000.0, },
      "state_name": "enabled",
      "info_title": "Unlimited builds",
      "info_text" : "Increase build limit by 10000 objects to help you build your dream home.",
    },
    "one_hit_objects": {
      "modifiers": { "melee_damage_percentage_increase_vs_tag_MOD_ONE_HIT_OBJECTS": 900.0, },
      "state_name": "enabled",
      "info_title": "One hit objects",
      "info_text" : "Dismantle everything in just one hit using any weapon passing the damage threshold of the object.",
    },
    "instant_death": {
      "modifiers": { "hit_points_percentage_decrease": 97.5, },
      "state_name": "enabled",
      "info_title": "Instant death",
      "info_text" : "One hit kills you, you have 1 HP, so anyone can one-shot you.",
    },
  };


Include ("scripts/mods/mod-modifiers.nut");


function Mod_Modifiers_QualityOfLife_OnEnter_Stage() {
  Mod_Modifiers_OnEnter_Stage (modifiers_quality_of_life);
}


function Mod_Modifiers_QualityOfLife_OnCoopPlayerJoined_ProtagonistReactions (primary_player, coop_player) {
  Mod_Modifiers_OnCoopPlayerJoined_ProtagonistReactions (modifiers_quality_of_life, primary_player, coop_player);
}


function Mod_Modifiers_QualityOfLife_OnClick_OptionsUnified (clicked) {
  Mod_Modifiers_OnClick_OptionsUnified (modifiers_quality_of_life, clicked);
}


function Mod_Modifiers_QualityOfLife_OnEnter_OptionsUnified (stage_in_stack) {
  Mod_Modifiers_OnEnter_OptionsUnified (modifiers_quality_of_life, stage_in_stack);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
