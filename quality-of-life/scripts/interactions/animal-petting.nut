// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-no-petting.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-petting-heals.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function GetMetadata()
{
  local data =
  {
    id = "pet"
    enabled = true
    interaction_text = "Pet"
    interaction_radius = 45
    actor_activator_tags_required_for_interaction = "ANIMAL_FRIEND"
    trigger_type = "PRESS_BUTTON"
    controller_button = "USE"
  };
  return data;
}


function IsInteractionAvailable(so_self, so_activator)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_NoPetting_PressButtonUseIsInteractionAvailable_AnimalFriend") == true) {
    local ret = Mod_NoPetting_PressButtonUseIsInteractionAvailable_AnimalFriend (so_self, so_activator);
    if (ret != null) return ret;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  if (StageObject_HasTag(so_self, "PET"))
  {
    if(StageObject_HasTag(so_activator, "IN_DANGER"))
      return false;
    if(Game_IsInCombat(so_self))
      return false;
    if(Game_IsInCombat(so_activator))
      return false;

    local petting_allowed = StageObject_GetKeyValue (so_self, "petting_allowed", false);
    if(petting_allowed == false)
      return false;

    local owner = StageObject_GetKeyValue(so_self, "pet_owner", null);
    if(owner == so_activator)
      return true;

    return false;
  }

  local value = StageObject_GetKeyValue(so_self, "times_petted");
  if (value != null && value >= 3)
    return false;

  return Actor_GetAttributeHitPoints(so_self) > 0 &&
    Game_IsFeatureAvailable("ANIMAL_PETTING") &&
    !Actor_IsAnimationPlaying(so_self, "petted") &&
    !Actor_IsAnimationPlaying(so_activator, "pet_animal");
}


function GetPettingAnimationId(so_animal)
{
  local kvs = ActorType_GetKeyValueStore(Actor_GetActorType(so_animal));
  local petting_height = KeyValueStore_GetKeyValue(kvs, "petting_height");
  if (petting_height == null)
    return "pet_animal";
  return "pet_animal_" + petting_height;
}

function OnInteraction(so_self, so_activator)
{
  local pos = StageObject_GetPosition(so_self);
  Actor_QueueActionPlayAnimation(so_activator, "tool_unequip", false);
  Actor_QueueActionTurnTowardsPosition(so_activator, pos[0], pos[1]);

  local petting_animation_id = GetPettingAnimationId(so_self);
  Actor_QueueActionPlayAnimation(so_activator, petting_animation_id, true);
  //Actor_QueueActionPlayAnimation(so_activator, "emote.fistpump", true);
  Actor_QueueActionPlayAnimation(so_self, "petted", true);
  Actor_QueueActionPlayAnimation(so_activator, "tool_equip", false);
  Game_AddFloaterNotification(so_self, "[EMOJI=two hearts]", 3, 1.5);

  if (Actor_GetAttributeHitPoints(so_self) <
    Actor_GetAttributeMaximumHitPoints(so_self))
    Stage_HealActor(so_activator, so_self, 20);
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_PettingHeals_PressButtonUse_AnimalFriend") == true) Mod_PettingHeals_PressButtonUse_AnimalFriend (so_self, so_activator);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  local value = StageObject_GetKeyValue(so_self, "times_petted");
  if (value == null)
    value = 0;
  StageObject_SetKeyValueInteger(so_self, "times_petted", value+1);
  StageObject_SetKeyValueInteger(so_self, "last_petted", Game_GetWorldTimeSecondsAsRealTimeSeconds());
}
