// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-electrifying-grenade.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


Include("items/utils/utils.nut");

local owner_handle = 0;
local item_id = null;
local is_throwing = false;

local aim_angle = null;
local aim_pos_x = null;
local aim_pos_y = null;
local aim_pos_z = null;
local predicted_target_pos = null;

function OnInitialize(so_handle_owner, id)
{
  owner_handle = so_handle_owner;
  item_id = id;

  if ("OnCustomInitialize" in this)
  {
    OnCustomInitialize(owner_handle, item_id);
  }

  return true;
}

function OnTriggerClick()
{
  if (is_throwing)
  {
    return;
  }

  if("IsPossibleToUse" in this)
  {
    if(!IsPossibleToUse())
    {
      Game_PlayAnimationByAction(owner_handle, "emote.no");
    
      return;
    }
  }
  

  if (!Game_UseItem(owner_handle, item_id))
  {
    return;
  }

  local so_target = Actor_GetAttributeTargetActor(owner_handle);
  if (so_target == null || Actor_GetAttributeHitPoints(so_target) <= 0.0001)
  {
    local angle = StageObject_GetAngle(owner_handle);
    if (aiming_type == "position")
    {
      so_target = Game_GetNearestEnemyInCone(owner_handle, angle, 180, max_aiming_distance);
    }
    else
    {
      so_target = Game_GetNearestEnemyInCone(owner_handle, angle, 180, 1500);
    }
  }

  if (so_target != null)
  {
    local player_pos = StageObject_GetPosition(owner_handle);
    predicted_target_pos = GetPredictedTargetPos(owner_handle, so_target, default_speed);

    if (aiming_type == "position" && default_speed > 151)
    {
      local dist = GetDistance(player_pos[0], player_pos[1], predicted_target_pos[0], predicted_target_pos[1]);
      if (dist > 1)
      {
        aim_angle = atan2(predicted_target_pos[1] - player_pos[1], predicted_target_pos[0] - player_pos[0]);
        if (dist <= max_aiming_distance)
        {
          aim_pos_x = predicted_target_pos[0];
          aim_pos_y = predicted_target_pos[1];
          aim_pos_z = predicted_target_pos[2];
        }
        else
        {
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
          if (this.rawin ("Mod_ElectrifyingGrenade_OnTrigger_Throwable") == true) {
            local ret = Mod_ElectrifyingGrenade_OnTrigger_Throwable (item_id);
            if (ret != null) max_aiming_distance = ret;
          }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
          aim_pos_x = player_pos[0] + max_aiming_distance * (predicted_target_pos[0] - player_pos[0]) / dist;
          aim_pos_y = player_pos[1] + max_aiming_distance * (predicted_target_pos[1] - player_pos[1]) / dist;
          aim_pos_z = player_pos[2] + max_aiming_distance * (predicted_target_pos[2] - player_pos[2]) / dist;
        }
      }
    }

    if (is_special_item)
    {
      Game_ThrowItem(owner_handle, "secondary_throw", 1.5, predicted_target_pos[0], predicted_target_pos[1]);
    }
    else
    {
      Game_ThrowItem(owner_handle, "primary_throw", 1.5, predicted_target_pos[0], predicted_target_pos[1]);
    }
  }
  else
  {
    if (is_special_item)
    {
      Game_ThrowItem(owner_handle, "secondary_throw", 1.5);
    }
    else
    {
      Game_ThrowItem(owner_handle, "primary_throw", 1.5);
    }
  }

  is_throwing = true;
}

function OnTriggerHoldDown()
{
  if("IsPossibleToUse" in this)
  {
    if(!IsPossibleToUse())
    {
      Game_PlayAnimationByAction(owner_handle, "emote.no");
    
      return;
    }
  }
  
  local kvs = Engine_GetKeyValueStore();
  local use_aiming = KeyValueStore_GetKeyValue(kvs, "dysmantle_use_special_item_aiming");
  if (use_aiming == null || use_aiming == false)
  {
    return;
  }

  if (aiming_type == "position")
  {
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    if (this.rawin ("Mod_ElectrifyingGrenade_OnTrigger_Throwable") == true) {
      local ret = Mod_ElectrifyingGrenade_OnTrigger_Throwable (item_id);
      if (ret != null) max_aiming_distance = ret;
    }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    Game_StartAiming(owner_handle, aiming_type, aiming_height, max_aiming_distance, max_height, is_special_item, throwable_actor_type);
  }
  else
  {
    Game_StartAiming(owner_handle, aiming_type, aiming_height, 0, 0, is_special_item, throwable_actor_type);
  }
}

function OnTriggerDown()
{
  aim_angle = null;
  aim_pos_x = null;
  aim_pos_y = null;
  aim_pos_z = null;
  predicted_target_pos = null;
}

function OnCommandWord(id, kvs)
{
  if ((is_special_item && id == "trigger_special_item") || (!is_special_item && id == "trigger_tool_item"))
  {
    is_throwing = false;

    if (predicted_target_pos != null)
    {
      local player_pos = StageObject_GetPosition(owner_handle);
      if (abs(predicted_target_pos[1] - player_pos[1]) > 0 || abs(predicted_target_pos[0] - player_pos[0]) > 0)
      {
        local angle = atan2(predicted_target_pos[1] - player_pos[1], predicted_target_pos[0] - player_pos[0]) * 180 / PI;
        StageObject_SetAngle(owner_handle, angle);
      }
    }

    if (aiming_type == "position")
    {
      local throwable_handle = CreateThrowable(owner_handle);

      if (aim_angle == null || aim_pos_x == null || aim_pos_y == null || aim_pos_z == null)
      {
        local angle = StageObject_GetAngle(owner_handle) * PI / 180;
        Actor_SetLinearVelocity(throwable_handle, default_speed * cos(-angle), -default_speed * sin(-angle), -default_speed);
      }
      else
      {
        local owner_pos = StageObject_GetPosition(owner_handle);
        local pos = StageObject_GetPosition(throwable_handle);
        local distance = GetDistance(pos[0], pos[1], aim_pos_x, aim_pos_y);
        Game_SetBallisticTrajectoryWithMaximumHeight(throwable_handle, aim_pos_x, aim_pos_y, aim_pos_z, Clamp(distance / 120.0, 0, 1) * (max_height - aiming_height));
      }
    }
    else
    {
      if ("CreateAndThrowThrowable" in this)
      {
        CreateAndThrowThrowable(owner_handle);
      }
      else
      {
        local throwable_handle = CreateThrowable(owner_handle);
        local angle = StageObject_GetAngle(owner_handle) * PI / 180;
        Actor_SetLinearVelocity(throwable_handle, default_speed * cos(-angle), -default_speed * sin(-angle), 0);
      }
    }
  }

  if ((is_special_item && id == "aiming_end_special_item") || (!is_special_item && id == "aiming_end_tool_item"))
  {
    aim_pos_x = KeyValueStore_GetKeyValue(kvs, "x");
    aim_pos_y = KeyValueStore_GetKeyValue(kvs, "y");
    aim_pos_z = KeyValueStore_GetKeyValue(kvs, "z");
    aim_angle = KeyValueStore_GetKeyValue(kvs, "angle");
    if (aim_angle != null)
    {
      if (!Game_UseItem(owner_handle, item_id))
      {
        return;
      }

// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    if (this.rawin ("Mod_ElectrifyingGrenade_OnCommandWord_Throwable") == true) Mod_ElectrifyingGrenade_OnCommandWord_Throwable (owner_handle, item_id);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

      Actor_QueueActionTurn(owner_handle, aim_angle * 180 / PI, 2);
      if (is_special_item)
      {
        Actor_QueueActionPlayAnimationWithParameters(owner_handle, "secondary_throw", 1.3, 0, true);
      }
      else
      {
        Actor_QueueActionPlayAnimationWithParameters(owner_handle, "primary_throw", 1.3, 0, true);
      }

      is_throwing = true;
    }
  }
}
