throwable_actor_type <- "actors/tools/throwing-knife.xml";
aiming_type <- "direction"
default_speed <- 1700;
aiming_height <- 50;
is_special_item <- true;

Include("items/utils/throwable.nut");

function OnMetadataRead()
{
  local info = {
    name = "Throwing Knives"
    description = "A perfectly balanced blade designed to be thrown at hostile targets."
    use_description = "Throw a knife towards a locked target."
    type = "throwable"
    thrown_actor = throwable_actor_type
    tags = "THROWABLE_WEAPON"
    number_of_uses = 3
    additional_uses_per_upgrade_level = 1
    destroy_after_owner_death = false
  };

  return info;
}

function OnModifiersRead()
{
  local modifiers = {
    throwable_weapon_damage_percentage_increase_vs_tag_MONSTER = 20
  };

  return modifiers;
}

function GetModifiersForUpgradeLevel(level)
{

  if (level == 1) {
    local modifiers = {
      throwable_weapon_damage_percentage_increase_vs_tag_MONSTER = 20
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    throwable_weapon_damage_percentage_increase_vs_tag_ANIMAL = 27
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    };
    return modifiers;
  }

  if (level == 2) {
    local modifiers = {
      throwable_weapon_damage_percentage_increase_vs_tag_MONSTER = 40
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    throwable_weapon_damage_percentage_increase_vs_tag_ANIMAL = 55
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    };
    return modifiers;
  }

  if (level == 3) {
    local modifiers = {
      throwable_weapon_damage_percentage_increase_vs_tag_MONSTER = 60
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    throwable_weapon_damage_percentage_increase_vs_tag_ANIMAL = 82
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    };
    return modifiers;
  }

  local modifiers = {
  };

  return modifiers;
}

function CreateThrowable(owner_handle)
{
  local pos = StageObject_GetPosition(owner_handle);
  local angle = StageObject_GetAngle(owner_handle) * PI / 180;
  local handle = Stage_CreateActor(throwable_actor_type, pos[0], pos[1], pos[2] - aiming_height);
  if (handle != null)
  {
    Actor_SetOwner(handle, owner_handle);
    StageObject_SetKeyValueFloat(handle, "explosion_delay", 2.1);
    StageObject_SetAngle(handle, StageObject_GetAngle(owner_handle) - 180);
  }
  
  return handle;
}
