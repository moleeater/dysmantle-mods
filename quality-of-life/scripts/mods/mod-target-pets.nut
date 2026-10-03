// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local whitelist_actions = [
    "AttackAction",
    "BaseAction",
    "ChaseAction",
    "FollowPathAction",
    "FollowPlayerAction",
    "HordeAttackAction",
    "InvestigateAction",
    "MeleeCombatAction",
    "MoveToAction",
    "PlayAnimationAction",
    "RunAction",
    "UnknownAction",
    "WaitAction",
    "WanderAction",
  ];


function Mod_TargetPets_OnThink_Animal (animal, tdelta) {
  if (Game_IsCinemaModeEnabled() != true
  && (StageObject_HasTag (animal, "PET") == true || StageObject_HasTag (animal, "FIGHTING_ANIMALS") == true)) {
    local action = Game_GetCurrentAction (animal);
    if (action == null || whitelist_actions.find(action) != null) {
      local player = StageObject_GetKeyValueStageObjectReference (animal, "pet_owner");
      if (player == null) {
        player = Game_GetPrimaryPlayerActor();
      }
      if (player != null) {
        local player_target = Actor_GetAttributeTargetActor (player);
        local animal_target = Actor_GetAttributeTargetActor (animal);
        if (player_target != null && StageObject_HasTag (player_target, "PLAYER") != true) {
          if (player_target != animal_target) {
            Game_SetTargetActor (animal, player_target);
          }
          animal_target = Actor_GetAttributeTargetActor (animal);
          if (action != "AttackAction" && StageObject_HasTag (animal_target, "PLAYER") != true) {
            Game_StartAttack (animal, "headpoke", true, true);
          }
        }
      }
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
