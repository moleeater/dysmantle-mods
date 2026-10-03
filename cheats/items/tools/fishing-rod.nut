local mods_include_path = "";
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
mods_include_path = "scripts/mods/mod-plenty-of-fish.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
// MODS by DarthNemesis vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
mods_include_path = "scripts/mods/mod-fishing-shovel.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by DarthNemesis ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


ATTACK_PLAYBACK_SPEED <- 1;
ATTACK_DELAY <- 0.1;
POWER_ATTACK_DELAY <- -0.3;

local owner_handle = null;
local item_id = null;
local is_fishing = false;
local reward_timer = 0.0;
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mod_plenty_of_fish_spot = { "spot": null, "spot_id": null };
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

function OnMetadataRead()
{
  local info = {
    name = "Fishing Rod"
    description = "Used to catch fish. Best used near water."
    use_description = "Start fishing."
    prop = "actors/tools/fishing-rod.xml"
    prop_bone = "tool"
    type = "melee_weapon"
    stance = "melee_2h"
    basic_attack_range = 80.0
    power_attack_range = 120.0
  };

  return info;
}

function OnCustomInitialize(handle, id)
{
  owner_handle = handle;
  item_id = id;
}

function OnCustomTriggerDown(handle)
{
  if (Actor_IsAnimationPlaying(owner_handle, "sitting-down-to-fish") ||
    Actor_IsAnimationPlaying(owner_handle, "standing-up-from-fishing"))
  {
    return;
  }

  if (!is_fishing)
  {
    if (!Game_IsInCombat(owner_handle))
    {
      local fishable_actor = Game_GetFishingTargetActorForActor(owner_handle);
      if (fishable_actor)
      {
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
        if (this.rawin ("Mod_PlentyOfFish_OnCustomTriggerDown_FishingRod") == true) Mod_PlentyOfFish_OnCustomTriggerDown_FishingRod (mod_plenty_of_fish_spot, owner_handle, handle, fishable_actor);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        StartFishing();
      }
      else
      {
// MODS by DarthNemesis vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
        local was_shoveling = false;
        if (this.rawin ("Mod_FishingShovel_OnCustomTriggerDown_FishingRod") == true) {
          was_shoveling = Mod_FishingShovel_OnCustomTriggerDown_FishingRod (owner_handle);
        }
        if (was_shoveling != true) {
          Actor_PlayAnimation(owner_handle, "not_here");
        }
// MODS by DarthNemesis ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      }
    }
  }
  else
  {
    StopFishing();
  }
}

function GetCatchDuration()
{
  local fishable_actor = Game_GetFishingTargetActorForActor(owner_handle);
  if (fishable_actor == null)
    return 100000000;
  local duration = Game_GetFishingTargetCatchDuration(fishable_actor);
  if (duration == null)
    return 100000000;
  return duration * (1 + 0.2 * m_randf(-1, 1));
}

function OnCustomUpdate(handle, tdelta)
{
  if (is_fishing)
  {
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    if (this.rawin ("Mod_PlentyOfFish_OnCustomUpdate_FishingRod") == true) Mod_PlentyOfFish_OnCustomUpdate_FishingRod (mod_plenty_of_fish_spot, owner_handle, handle, tdelta);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    local speed_multiplier = 1.0;
    local modifiers = Game_GetModifiersAsKeyValueStore(owner_handle);
    local fishing_speed_percentage_increase = KeyValueStore_GetKeyValue(modifiers, "fishing_speed_percentage_increase");
    if (fishing_speed_percentage_increase != null)
    {
      speed_multiplier += 0.01 * fishing_speed_percentage_increase;
    }

    reward_timer -= speed_multiplier * tdelta;
    if (reward_timer < 0)
    {
      reward_timer = GetCatchDuration();
      Actor_PlayAnimation(owner_handle, "catching-fish");
    }
  }
}

function OnCustomAttack(owner_handle)
{
}

function OnUnequipped()
{
  StopFishing();
}

function OnCommandWord(id, kvs)
{
  if (id == "fishing_end")
  {
    StopFishing();
  }

  if (id == "trigger_tool_item")
  {
    if (Game_UseItem(owner_handle, item_id))
    {
      Game_SpawnFishingRewardForFisherActor(owner_handle);
    }

    if (!Game_CanItemBeTriggered(owner_handle, item_id))
    {
      StopFishing();
    }
  }

  if (id == "trigger_tool_item_effect")
  {
    local effect = KeyValueStore_GetKeyValueAsString(kvs, "effect");
    if (effect)
    {
      Game_SpawnFishingSplash(owner_handle, item_id, effect);
    }
  }
}

function StartFishing()
{
  if (!is_fishing)
  {
    is_fishing = true;
    reward_timer = GetCatchDuration();
    Stage_SendStageObjectCommandWord(owner_handle, "fishing_start");
    Actor_QueueActionPlayAnimationWithTransition(owner_handle, "fishing", "sitting-down-to-fish", false);

    if (!Game_IsAcknowledged("FIRST_TIME_FISHING_TIP"))
    {
      Game_SetAcknowledged("FIRST_TIME_FISHING_TIP", true);
      local text = LOC_TEXT("Now I'll just wait until it bites. [EMOJI=shushing face]");
      Game_AddActorNotificationWithDelay(owner_handle, text, 1.4);
    }
  }
}

function StopFishing()
{
  if (is_fishing)
  {
    is_fishing = false;
    Actor_QueueActionStopAnimationWithTransition(owner_handle, "fishing", "standing-up-from-fishing", true);
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    if (this.rawin ("Mod_PlentyOfFish_StopFishing_FishingRod") == true) Mod_PlentyOfFish_StopFishing_FishingRod (mod_plenty_of_fish_spot, owner_handle);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  }
}

function IsPossibleToUse()
{
  return Game_GetFishingTargetActorForActor(owner_handle) != null;
}

Include("items/tools/utils/melee-attack.nut");
