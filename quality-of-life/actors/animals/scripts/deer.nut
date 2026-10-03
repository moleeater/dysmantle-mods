// MODS vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-clone-deer.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-collector-pets.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-hide-corpses.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-roll-attack.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-target-pets.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


local update_timer = 0;
local flee_countdown = -1;


// MODS vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function OnCollision (so_actor, so_enemy) {
  if (this.rawin ("Mod_RollAttack_OnCollision_Creature") == true) Mod_RollAttack_OnCollision_Creature (so_actor, so_enemy);
}
// MODS ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function OnGameStart(so_actor)
{
// MODS vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_CloneDeer_OnGameStart_Animal") == true) Mod_CloneDeer_OnGameStart_Animal (so_actor);
  if (this.rawin ("Mod_HideCorpses_OnGameStart_Creature") == true) Mod_HideCorpses_OnGameStart_Creature (so_actor);
// MODS ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    Game_StartWander(so_actor, -1, false);
}

function OnThink(so_actor, tdelta)
{
// MODS vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_CollectorPets_OnThink_Animal") == true) Mod_CollectorPets_OnThink_Animal (so_actor, tdelta);
  if (this.rawin ("Mod_TargetPets_OnThink_Animal") == true) Mod_TargetPets_OnThink_Animal (so_actor, tdelta);
// MODS ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    local current_action = Game_GetCurrentAction(so_actor);

    if (current_action == "FollowPlayerAction" || current_action == "AttackAction")
    {
        return;
    }

    update_timer += tdelta;
    if (update_timer > 0.1)
    {
        update_timer = 0;
        if (current_action == "FleeAction")
        {
            flee_countdown = -1;
        }
        else
        {
            local so_current_target = Actor_GetAttributeTargetActor(so_actor);
            if (so_current_target != null && so_current_target != 0)
            {
                Game_UpdateTargetActor(so_actor, 600, 360);
            }
            else
            {
                Game_UpdateTargetActor(so_actor, 600, 180);
            }

            so_current_target = Actor_GetAttributeTargetActor(so_actor);
            if (so_current_target != null && so_current_target != 0 && StageObject_HasTag(so_current_target, "ENEMY_AND_PLAYER_BASE_AI"))
            {
                if (flee_countdown < 0)
                {
                    local enemy_modifiers = Game_GetModifiersAsKeyValueStore(so_current_target);
                    local animal_friend_effect = KeyValueStore_GetKeyValue(enemy_modifiers, "animal_friend_effect_percentage_increase");
                    if (animal_friend_effect != null)
                    {
                        flee_countdown = animal_friend_effect * 0.1;
                    }
                    else
                    {
                        flee_countdown = 0.00001;
                    }
                }
            }
            else
            {
                flee_countdown = -1;
            }
        }
    }

    if (flee_countdown >= 0)
    {
        flee_countdown -= tdelta;
        if (flee_countdown < 0)
        {
            local so_current_target = Actor_GetAttributeTargetActor(so_actor);
            if (so_current_target != null)
            {
                local target_velocity = Actor_GetLinearVelocity(so_current_target);
                if (target_velocity[0] > 1 || target_velocity[1] > 1 || target_velocity[2] > 1)
                {
                    StartFleeFromEnemy(so_actor, so_current_target, true, false);
                }
            }
        }
    }
}

function OnHearNoise(so_actor, position, noise_type, so_lure)
{
    if (noise_type == "Treat")
    {
        Game_SetTargetActor(so_actor, 0);
        Game_StartInvestigate(so_actor, noise_type, so_lure);
    }
    else if (so_lure == 0)
    {
        StartFleeFromPosition(so_actor, position, true, false);
    }
}

function OnReceiveDamage(so_actor, so_dealer)
{
    local dealer_is_player = StageObject_HasTag(so_dealer, "PLAYER");
    StartFleeFromEnemy(so_actor, so_dealer, true, dealer_is_player);
}

function StartFleeFromEnemy(so_actor, so_enemy, use_path_planning, ignore_tamed_tag)
{
    if (so_enemy != 0)
    {
        local position = StageObject_GetPosition(so_enemy);
        StartFleeFromPosition(so_actor, position, use_path_planning, ignore_tamed_tag);
    }
}

function StartFleeFromPosition(so_actor, position, use_path_planning, ignore_tamed_tag)
{
    if (!ignore_tamed_tag && StageObject_HasTag(so_actor, "TAMED"))
    {
        return;
    }

    if (position != null)
    {
        local current_action = Game_GetCurrentAction(so_actor);
        if (current_action == "FleeAction" || current_action == "InvestigateAction")
        {
            return;
        }

        Game_StartFlee(so_actor, position[0], position[1], use_path_planning);
    }
}
