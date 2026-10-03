owner_handle <- null;
item_id <- null;


// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-remember-the-seed.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);

function OnEquipped() {
  if (this.rawin ("Mod_RememberTheSeed_OnEquipped_SeedBag") == true) Mod_RememberTheSeed_OnEquipped_SeedBag (owner_handle, item_id);
}

function OnUnequipped() {
  if (this.rawin ("Mod_RememberTheSeed_OnUnequipped_SeedBag") == true) Mod_RememberTheSeed_OnUnequipped_SeedBag (owner_handle, item_id);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function GetDistance(x0, y0, x1, y1)
{
  local dx = x1 - x0;
  local dy = y1 - y0;
  return sqrt(dx * dx + dy * dy);
}

function OnInitialize(handle, id)
{
  owner_handle = handle;
  item_id = id;
  return true;
}

function PlantSeed(area_radius)
{
  local current_action = Game_GetCurrentAction(owner_handle);
  if (!(current_action == "PlayerBaseAction" || current_action == "MeleeCombatAction" || current_action == "RunAction"))
  {
    return;
  }

  local has_enough_seeds = Game_HasEnoughSelectedSeedsToPlant(owner_handle);
  local show_reaction = has_enough_seeds;
  local plant_bed = Game_GetEmptyPlantBedForActor(owner_handle, show_reaction);

  if (plant_bed && has_enough_seeds)
  {
    local speed = 1;
    local kvs = Game_GetAllPlayerModifiersAsKeyValueStore(owner_handle);
    local planting_speed_percentage_increase = KeyValueStore_GetKeyValue(kvs, "planting_speed_percentage_increase");
    if (planting_speed_percentage_increase != null)
    {
      speed += planting_speed_percentage_increase / 100.0;
    }

    local owner_pos = StageObject_GetPosition(owner_handle);
    local plant_bed_pos = StageObject_GetPosition(plant_bed);
    local dist = GetDistance(owner_pos[0], owner_pos[1], plant_bed_pos[0], plant_bed_pos[1]);
    if (dist < 10)
    {
      Actor_QueueActionRunScript(owner_handle, format("StageObject_AddTag(%d, \"IGNORE_SMALL_COLLISIONS\");", owner_handle));
      Actor_QueueActionMoveToDistanceFromActor(owner_handle, plant_bed, 10);
      Actor_QueueActionRunScript(owner_handle, format("StageObject_RemoveTag(%d, \"IGNORE_SMALL_COLLISIONS\");", owner_handle));
    }
    else
    {
      Actor_QueueActionTurnTowardsPosition(owner_handle, plant_bed_pos[0], plant_bed_pos[1], speed);
    }
    if (area_radius > 0)
      Actor_QueueActionPlayAnimationWithParameters(owner_handle, "plant_seed_3x3", 0.8 * speed, 0, true);
    else
      Actor_QueueActionPlayAnimationWithParameters(owner_handle, "plant_seed", speed, 0, true);

  }
  else
  {
    Game_PlayAnimationByAction(owner_handle, "not_here");

    if (!has_enough_seeds)
      Game_AddActorNotification(owner_handle, LOC_TEXT("Not enough seeds."));
  }
}

function OnTriggerClick()
{
  PlantSeed(0);
}

function OnSecondaryTriggerDown()
{
  UI_SendScreenMessage("SelectFarmingSeed", "player_handle", owner_handle.tostring());
  UI_PushScreen("SelectFarmingSeed");
}

function IsPossibleToUse()
{
  return Game_GetEmptyPlantBedForActor(owner_handle, false) != null;
}
