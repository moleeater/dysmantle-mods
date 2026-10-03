// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_AscendShelter_HoldDownButtonIsInteractionAvailable_Loudspeaker (loudspeaker, player) {
  local kvs = StageObject_GetKeyValueStore (loudspeaker);
  if (kvs != null) {
    local shelter = KeyValueStore_GetKeyValue (kvs, "spawn_entrance");
    if (shelter != null) {
      if (Game_IsStagePointOfInterestCompleted (loudspeaker) == true
      && Actor_IsInteractionEnabled (loudspeaker, "after_completed") != true
      && Actor_IsInteractionEnabled (loudspeaker, "spawn_check") != true
      && StageObject_GetKeyValue (shelter, "cleared", false) == true) {
        Actor_SetInteractionText (loudspeaker, "mod_ascend_shelter_hold_down_button", "|img src='emojis/package.png' scale=0.5 offset=2| " + LocalizeText("Ascend shelter"));
        return true;
      }
    }
  }
  return false;
}


function Mod_AscendShelter_HoldDownButton_Loudspeaker (loudspeaker, player) {
  local kvs = StageObject_GetKeyValueStore (loudspeaker);
  local wave_number = 0;
  local num_per_burst = null;
  local num_bursts = null;
  do {
    local key = "wave_" + wave_number.tostring() + "_num_per_burst";
    num_per_burst = StageObject_GetKeyValue (loudspeaker, key, null);
    if (num_per_burst != null) {
      if (kvs != null) {
        local kvp = KeyValueStore_GetKeyValueAsPointer (kvs, key);
        KeyValueStore_SetFlagForKeyValue (kvp, "SAVE_STATE", true);
      }
      StageObject_SetKeyValueInteger (loudspeaker, key, num_per_burst.tointeger() + 1);
    }
    key = "wave_" + wave_number.tostring() + "_num_bursts";
    num_bursts = StageObject_GetKeyValue (loudspeaker, key, null);
    if (num_bursts != null) {
      if (kvs != null) {
        local kvp = KeyValueStore_GetKeyValueAsPointer (kvs, key);
        KeyValueStore_SetFlagForKeyValue (kvp, "SAVE_STATE", true);
      }
      StageObject_SetKeyValueInteger (loudspeaker, key, num_bursts.tointeger() + 1);
    }
    wave_number++;
  } while (num_per_burst != null || num_bursts != null);
  Actor_InteractWithInteraction (loudspeaker, player, "activate");
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
