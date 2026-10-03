// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local interval_realseconds = 15.0;
local query_radius = 600.0;
local animation_speed = 5.0;


function Mod_AutoGasmask_OnActorEntersRadius200Warning_GasCloud (gascloud, player) {
  if (Game_IsRecipeCrafted ("GAS_MASK") != true) {
    Game_AddActorNotification (player, LOC_TEXT("The gas is getting to my lungs. I need a [GREEN]Gas Mask[WHITE]."));
    Actor_PlayAnimation (player, "cough");
  }
  return true;
}


function Mod_AutoGasmask_OnActorEntersRadius200Slowdown_GasCloud (gascloud, player) {
  if (Game_IsRecipeCrafted ("GAS_MASK") != true) {
    Game_SetTemporaryModifier (player, "GAS_SLOWDOWN_MOVE_SPEED", 3.0, "move_speed_percentage_increase", -60.0);
    Game_SetTemporaryModifier (player, "GAS_SLOWDOWN_RUNNING_SPEED", 3.0, "running_speed_percentage_increase", -100.0);
  } else if (Game_GetEquippedItemInActiveSlot (player, "HEADGEARS") != "items/headgears/gas-mask.nut") {
    if (this.rawin("Game_GetPlayerPersistentKeyValueStore") != true) {
      Engine_Warning("mod ERROR: update your game to at least v1.4.0.35");
    } else {
      local player_kvs = Game_GetPlayerPersistentKeyValueStore (Game_GetPlayerIndexByActor (player));
      local last_worldseconds = KeyValueStore_GetKeyValue (player_kvs, "mod_auto_gasmask_equipped_epoch", 0);
      if (last_worldseconds == 0) {
        if (Actor_IsAnimationPlaying (player, "emote.shocked") != true) {
          Actor_QueueActionPlayAnimationWithParameters (player, "emote.shocked", animation_speed, 0.0, false);
        }
        local command = Command_Create ("add_actor_prop");
        Command_SetStageObjectReference (command, player);
        local command_kvs = Command_GetKeyValueStore (command);
        KeyValueStore_SetKeyValueString (command_kvs, "prop_id", "gas-mask");
        Stage_SendStageObjectCommandWithDelete (player, command);
      }
      KeyValueStore_SetKeyValueInteger (player_kvs, "mod_auto_gasmask_equipped_epoch", Game_GetWorldTimeInSeconds());
      local kvp = KeyValueStore_GetKeyValueAsPointer (player_kvs, "mod_auto_gasmask_equipped_epoch");
      if (kvp != null) {
        KeyValueStore_SetFlagForKeyValue (kvp, "SAVE_STATE", true);
      }
    }
  }
  return true;
}


function Mod_AutoGasmask_OnActorLeavesRadius200Slowdown_GasCloud (gascloud, player) {
  Game_SetTemporaryModifier (player, "GAS_SLOWDOWN_MOVE_SPEED", 0.0, "move_speed_percentage_increase", 0.0);
  Game_SetTemporaryModifier (player, "GAS_SLOWDOWN_RUNNING_SPEED", 0.0, "running_speed_percentage_increase", 0.0);
  return true;
}


function Mod_AutoGasmask_OnActorEntersRadius90_GasCloud (gascloud, player) {
  if (Game_IsRecipeCrafted ("GAS_MASK") != true) {
    Stage_KillActorAndStartDeathAnimation (player, "die_of_gas");
    Game_SetPlayerActorCauseOfDeath (player, "GAS");
  }
  return true;
}


function Mod_AutoGasMask_Remove (player, play_animation = true) {
  if (play_animation == true && Actor_IsAnimationPlaying (player, "emote.shocked") != true) {
    Actor_QueueActionPlayAnimationWithParameters (player, "emote.shocked", animation_speed, 0.0, false);
  }
  local command = Command_Create ("remove_actor_prop");
  Command_SetStageObjectReference (command, player);
  local command_kvs = Command_GetKeyValueStore (command);
  KeyValueStore_SetKeyValueString (command_kvs, "prop_id", "gas-mask");
  Stage_SendStageObjectCommandWithDelete (player, command);
  if (this.rawin("Game_GetPlayerPersistentKeyValueStore") == true) {
    local player_kvs = Game_GetPlayerPersistentKeyValueStore (Game_GetPlayerIndexByActor (player));
    KeyValueStore_SetKeyValueInteger (player_kvs, "mod_auto_gasmask_equipped_epoch", 0);
    local kvp = KeyValueStore_GetKeyValueAsPointer (player_kvs, "mod_auto_gasmask_equipped_epoch");
    if (kvp != null) {
      KeyValueStore_SetFlagForKeyValue (kvp, "SAVE_STATE", true);
    }
  }
}


function Mod_AutoGasMask_OnUpdate_ProtagonistReactions (player) {
  if (Game_IsRecipeCrafted ("GAS_MASK") == true && Game_IsCinemaModeEnabled() != true && this.rawin("Game_GetPlayerPersistentKeyValueStore") == true) {
    local player_kvs = Game_GetPlayerPersistentKeyValueStore (Game_GetPlayerIndexByActor (player));
    local last_worldseconds = KeyValueStore_GetKeyValue (player_kvs, "mod_auto_gasmask_equipped_epoch", 0);
    if (last_worldseconds == 0) {
      Mod_AutoGasMask_Remove (player, false);
    } else {
      if (Game_GetEquippedItemInActiveSlot (player, "HEADGEARS") == "items/headgears/gas-mask.nut") {
        Mod_AutoGasMask_Remove (player, false);
      } else {
        last_worldseconds = last_worldseconds.tofloat();
        local world_time_multiplier = 20.0;
        local engine_kvs = Engine_GetKeyValueStore();
        if (engine_kvs != null) {
          world_time_multiplier = KeyValueStore_GetKeyValue (engine_kvs, "world_time_multiplier", 20.0);
        }
        local position = StageObject_GetStagePosition (player);
        if (last_worldseconds < Game_GetWorldTimeInSeconds() / world_time_multiplier.tofloat() - interval_realseconds.tofloat()
        && Stage_QueryNearestActorWithType (position[0], position[1], position[2], query_radius, "actors/interactives/gas-cloud.xml") == null) {
          Mod_AutoGasMask_Remove (player);
        }
      }
    }
  }
}


function Mod_AutoGasMask_OnEnter_Stage() {
  if (Game_IsRecipeCrafted ("GAS_MASK") == true) {
    foreach (player_index in [0,1]) {
      local player = Game_GetPlayerActor (player_index);
      if (player != null) {
        Mod_AutoGasMask_Remove (player, false);
      }
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
