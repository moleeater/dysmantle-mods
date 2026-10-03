// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-walk-over-mortarpods.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-hide-corpses.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


local target_timer = 0;
local puke_timer = 0;
local target_x = 0;
local target_y = 0;
local burst_projectiles_left = 0;

const min_distance = 60;
const max_distance = 360;
const burst_probability = 0.25;
const burst_size = 5;


// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function OnGameStart (mortarpod) {
  if (this.rawin ("Mod_WalkOverMortarpods_OnGameStart_Mortarpod") == true) Mod_WalkOverMortarpods_OnGameStart_Mortarpod (mortarpod);
  if (this.rawin ("Mod_HideCorpses_OnGameStart_Creature") == true) Mod_HideCorpses_OnGameStart_Creature (mortarpod);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function Min(a, b)
{
  return a < b ? a : b;
}

function Max(a, b)
{
  return a > b ? a : b;
}

function Clamp(value, min, max)
{
  return value < min ? min : (value > max ? max : value);
}

function GetDistance(x0, y0, x1, y1)
{
  local dx = x1 - x0;
  local dy = y1 - y0;
  return sqrt(dx * dx + dy * dy);
}

function IsSameDirection(a, b)
{
  return a[0] * b[0] + a[1] * b[1] > 0;
}

function OnThink(so_actor, tdelta)
{
  target_timer += tdelta;
  if (target_timer > 0.2)
  {
    Game_UpdateTargetActor(so_actor, max_distance + 60, 360);
    target_timer -= 0.2;
  }

  local so_current_target = Actor_GetAttributeTargetActor(so_actor);
  if (so_current_target)
  {
    puke_timer -= tdelta;
    if (puke_timer <= 0.0)
    {
      UpdateTargetPosition(so_actor);

      if (burst_projectiles_left < 0)
      {
        if (burst_projectiles_left < -10 || m_randf() < burst_probability)
        {
          burst_projectiles_left = burst_size;
        }
      }

      local playback_speed = burst_projectiles_left > 0 ? 2 : 1;
      local anim = Game_PlayAnimationByActionWithPlaybackSpeed(so_actor, "shoot", playback_speed);
      local duration = anim[1];

      burst_projectiles_left--;

      puke_timer = duration;
      if (burst_projectiles_left <= 0)
      {
        puke_timer += 0.5 + m_randf();
      }
    }
  }
}

function OnTargetChanged(so_actor, so_new_target, so_old_target)
{
  puke_timer = m_randf();
}

function OnCommandWord(so_actor, command_word)
{
  if (command_word == "fire_weapon")
  {
    UpdateTargetPosition(so_actor);

    local pos = StageObject_GetPosition(so_actor);
    local distance = GetDistance(pos[0], pos[1], target_x, target_y);

    local puke_handle = Stage_CreateActor("actors/projectiles/puke-projectile.xml", pos[0], pos[1], pos[2] - 80);
    Actor_SetOwner(puke_handle, so_actor);

    Game_SetBallisticTrajectory(puke_handle, target_x, target_y, 500 + Min(100, distance / 3));
  }
}

function UpdateTargetPosition(so_actor)
{
  local so_current_target = Actor_GetAttributeTargetActor(so_actor);
  if (so_current_target == null)
  {
    return;
  }

  local pos = StageObject_GetPosition(so_actor);
  local target_pos = StageObject_GetPosition(so_current_target);
  local target_velocity = Actor_GetLinearVelocity(so_current_target);

  local mult = Clamp(GetDistance(target_pos[0], target_pos[1], pos[0], pos[1]) / 150, 0, 1.5);
  target_x = target_pos[0] + mult * Clamp(target_velocity[0], -200, 200);
  target_y = target_pos[1] + mult * Clamp(target_velocity[1], -200, 200);

  if (!IsSameDirection([pos[0] - target_pos[0], pos[1] - target_pos[1]], [pos[0] - target_x, pos[1] - target_y]))
  {
    target_x = 0.5 * (target_pos[0] + pos[0]);
    target_y = 0.5 * (target_pos[1] + pos[1]);
  }

  local distance = GetDistance(pos[0], pos[1], target_x, target_y);
  if (distance > max_distance)
  {
    target_x = pos[0] + max_distance * (target_x - pos[0]) / distance;
    target_y = pos[1] + max_distance * (target_y - pos[1]) / distance;
  }
  else if (distance < min_distance)
  {
    target_x = pos[0] + min_distance * (target_x - pos[0]) / distance;
    target_y = pos[1] + min_distance * (target_y - pos[1]) / distance;
  }
}
