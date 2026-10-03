// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local heal_amount = 20.0;
local notification_duration = 3.0;
local notification_delay = 1.5;


function Mod_PettingHeals_PressButtonUse_AnimalFriend (deer, player) {
  if (Game_IsRecipeCrafted ("SKILL_ANIMAL_FRIEND_3") == true && StageObject_HasTag (deer, "TAMED") == true) {
    local health = Actor_GetAttributeHitPoints (player);
    local max_health = Actor_GetAttributeMaximumHitPoints (player);
    if (health != null && health > 0.0 && max_health != null && health < max_health) {
      Game_AddFloaterNotification (player, "[EMOJI=two hearts]", notification_duration, notification_delay);
      Stage_HealActor (deer, player, heal_amount);
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
