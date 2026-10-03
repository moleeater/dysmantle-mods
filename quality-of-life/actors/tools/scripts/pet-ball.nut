// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-pocket-pets-forever.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function OnGameStart(so_actor)
{
  StageObject_SetKeyValueFloat(so_actor, "timer", 0);
}

function OnThink(so_actor, tdelta)
{
  local timer = StageObject_GetKeyValue(so_actor, "timer");
  if (timer == null)
  {
    StageObject_SetKeyValueFloat(so_actor, "timer", 0);
    return;
  }
  timer += tdelta;
  StageObject_SetKeyValueFloat(so_actor, "timer", timer);

  if (timer >= StageObject_GetKeyValue(so_actor, "explosion_delay"))
  {
    Stage_SendStageObjectCommandWord(so_actor, "self_destruct");
    //Stage_KillActorAndStartDeathAnimation(so_actor);

    local owner = Actor_GetOwner(so_actor);
    if (owner != null)
    {
      local pos = StageObject_GetPosition(so_actor);
      local pet_actor_type = StageObject_GetKeyValue(so_actor, "pet_actor_type");
      if(pet_actor_type == null)
        return;
        
      local handle = Stage_CreateActor(pet_actor_type, pos[0], pos[1], pos[2] - 20);
      StageObject_SetKeyValueStageObjectReference (handle, "pet_owner", owner);
      StageObject_SetKeyValueFloat(handle, "time_to_live", 20);
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
      if (this.rawin ("Mod_PocketPetsForever_OnThink_PetBall") == true) Mod_PocketPetsForever_OnThink_PetBall (so_actor, handle, tdelta);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      Actor_SetActorFlag (handle, "DELETE_ACTOR_AFTER_DEATH", true);
      Actor_SetActorFlag (handle, "INDESTRUCTIBLE", false);
      StageObject_AddTag(handle, "POCKET_PET");
    }
  }
}
