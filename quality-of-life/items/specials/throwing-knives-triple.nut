throwable_actor_type <- "actors/tools/throwing-knife.xml";
aiming_type <- "direction"
default_speed <- 1700;
aiming_height <- 50;
is_special_item <- true;

Include("items/utils/throwable.nut");

function OnMetadataRead()
{
  local info = {
    name = "Shiv Trio"
    description = "A trio of perfectly balanced blades thrown out in a cone formation."
    use_description = "Throw three small knives towards the locked target."
    type = "throwable"
    thrown_actor = throwable_actor_type
    tags = "THROWABLE_WEAPON"
    number_of_uses = 2
    additional_uses_per_upgrade_level = 1
    destroy_after_owner_death = false
  };

  return info;
}

function OnModifiersRead()
{
  local modifiers = {
    throwable_weapon_damage_percentage_increase_vs_tag_MONSTER = 15
  };

  return modifiers;
}

function GetModifiersForUpgradeLevel(level)
{

  if (level == 1) {
    local modifiers = {
      throwable_weapon_damage_percentage_increase_vs_tag_MONSTER = 15
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    throwable_weapon_damage_percentage_increase_vs_tag_ANIMAL = 27
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    };
    return modifiers;
  }

  if (level == 2) {
    local modifiers = {
      throwable_weapon_damage_percentage_increase_vs_tag_MONSTER = 30
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    throwable_weapon_damage_percentage_increase_vs_tag_ANIMAL = 55
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    };
    return modifiers;
  }

  if (level == 3) {
    local modifiers = {
      throwable_weapon_damage_percentage_increase_vs_tag_MONSTER = 45
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

function CreateAndThrowThrowable(owner_handle)
{
  for (local i = -1; i <= 1; i++)
  {
    Throw(owner_handle, throwable_actor_type, default_speed, 0.1 * i, aiming_height);
  }
}
