// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-roll-attack.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Include("actors/enemies/scripts/common.nut");

local has_line_of_sight = false;
local has_walkable_line_of_sight = false;
local time_target_updated = 0;
local dodge_timer = 0;

function OnGameStart(so_actor)
{
  time_target_updated = Stage_GetTimeMilliseconds() + m_randf(0, 1000);

  local start_wander = StageObject_GetKeyValue(so_actor, "Wander_start_automatically");
  if (start_wander)
  {
    local wander_radius = StageObject_GetKeyValue(so_actor, "Wander_radius");
    Game_StartWander(so_actor, wander_radius, true);
  }

  local start_follow_path = StageObject_GetKeyValue(so_actor, "FollowPath_start_automatically");
  if (start_follow_path)
  {
    Game_StartFollowPath(so_actor, "FollowPath_path");
  }

  StageObject_SetKeyValueBoolean(so_actor, "allow_advanced_chasing", true);
}

function OnThink(so_actor, tdelta)
{
  local action = Game_GetCurrentAction(so_actor);
  local current_time = Stage_GetTimeMilliseconds();
  local so_current_target = Actor_GetAttributeTargetActor(so_actor);

  if (action == "DodgeAction")
  {
    return;
  }

  if (!so_current_target || Actor_GetAttributeHitPoints(so_current_target) <= 0)
  {
    if (time_target_updated + 200 < current_time &&
      action != "InvestigateAction")
    {
      time_target_updated = current_time;
      Game_UpdateTargetActor(so_actor);
    }
  }

  if (so_current_target)
  {
    if (action != "ChaseAction" && action != "AttackAction")
    {
      StartChase(so_actor);
     }
    else if (action == "ChaseAction")
    {
      local distance = GetActorDistance(so_actor, so_current_target);
      if (distance < 45 && has_walkable_line_of_sight)
      {
        local angle = abs(Game_GetAngleDifference(so_current_target, so_actor));
        local target_speed = GetSpeed(so_current_target);
        if (angle < 90 && target_speed > 10)
        {
          Game_StartAttack(so_actor, "melee", true);
        }
        else
        {
          Game_StartAttack(so_actor, "melee", false);
        }
      }
      else if (distance < 100 && has_walkable_line_of_sight)
      {
        dodge_timer += tdelta;
        if (dodge_timer > 0.2)
        {
          dodge_timer = 0;
          if (m_randf() > 0.5)
          {
            if (Game_IsPlayingAnimationByAction(so_current_target, "melee"))
            {
              Game_StartDodge(so_actor, false);
            }
            // else if (m_randf() > 0.5)
            // {
            //     Game_StartDodge(so_actor, true);
            // }
          }
        }
      }
    }
  }

  HandleIdleAnimation(so_actor, tdelta);
}

function OnCircling(so_actor)
{
  if (Game_GetCurrentAction(so_actor) == "ChaseAction")
  {
    StartAttack(so_actor, "melee");
  }
}

function OnTargetChanged(so_actor, so_new_target, so_old_target)
{
  if (so_new_target)
  {
    if (Game_GetCurrentAction(so_actor) == "MoveToAction")
    {
      Game_StopCurrentAction(so_actor);
    }

    StartChase(so_actor);
  }
}

function OnLineOfSightToTargetChanged(so_actor, so_target, has_los)
{
  has_line_of_sight = has_los;
}

function OnWalkableLineOfSightToTargetChanged(so_actor, so_target, has_los)
{
  has_walkable_line_of_sight = has_los;
}

function OnReceiveDamage(so_actor, so_dealer)
{
  local so_current_target = Actor_GetAttributeTargetActor(so_actor);
  if (!so_current_target || !has_line_of_sight)
  {
    Game_SetTargetActor(so_actor, so_dealer);
  }

  dodge_timer = 0;
}

function OnCollision(so_actor, so_enemy)
{
  local so_current_target = Actor_GetAttributeTargetActor(so_actor);
  if (!so_current_target || !has_line_of_sight)
  {
    Game_SetTargetActor(so_actor, so_enemy);
  }
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_RollAttack_OnCollision_Creature") == true) Mod_RollAttack_OnCollision_Creature (so_actor, so_enemy);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}

function OnHearNoise(so_actor, position, noise_type, so_lure)
{
  //HandleLure(so_actor, noise_type, so_lure);
  Game_StartChase(so_actor);
}

function StartChase(so_actor)
{
  Game_StartChase(so_actor);
}

function StartAttack(so_actor, action)
{
  Game_StartAttack(so_actor, action, false);
}
