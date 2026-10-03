// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-more-item-slots.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


local so_pet = null;
local so_owner = null;

function Pet_Initialize(so_handle_owner, item_id)
{
  so_owner = so_handle_owner;
  return true;
}

function Pet_Summon_Position(pos)
{
  if(so_pet != null)
    return;
  
  local info = OnMetadataRead();
  local old_pet = StageObject_GetKeyValueStageObjectReference (so_owner, "ref_pet");
  
  local last_time_pet_unsummon = StageObject_GetKeyValue(so_owner, "last_pet_time_pet_unsummon");
  
  local time_now = Stage_GetTimeMilliseconds ();
  
  if(last_time_pet_unsummon == time_now)
  {
    pos[0] = StageObject_GetKeyValue(so_owner, "last_pet_pos_x");
    pos[1] = StageObject_GetKeyValue(so_owner, "last_pet_pos_y");
    pos[2] = StageObject_GetKeyValue(so_owner, "last_pet_pos_z");  
  }
  pos = Game_GetValidPosition(pos[0],pos[1],pos[2], 100, 20);
  
  so_pet = Stage_CreateActor(info.pet_actor_type, pos[0], pos[1], pos[2]);
  StageObject_SetGlobal (so_pet, true);
  StageObject_SetKeyValueStageObjectReference (so_owner, "ref_pet", so_pet);
  StageObject_SetKeyValueStageObjectReference (so_pet, "pet_owner", so_owner);    
}

function Pet_Summon()
{
  local owner_pos = StageObject_GetStagePosition(so_owner);
  owner_pos[0] += 30;
  owner_pos[1] += 10;
  owner_pos[2] -= 5;
  Pet_Summon_Position(owner_pos);
}

function Pet_Banish()
{
  if (so_pet != null)
  {
    if(StageObject_IsValid(so_pet))
    {
      local last_pet_pos = StageObject_GetStagePosition(so_pet);
      StageObject_SetKeyValueFloat(so_owner, "last_pet_pos_x", last_pet_pos[0]);
      StageObject_SetKeyValueFloat(so_owner, "last_pet_pos_y", last_pet_pos[1]);
      StageObject_SetKeyValueFloat(so_owner, "last_pet_pos_z", last_pet_pos[2]);
    }  
    Stage_DeleteStageObject(so_pet);
    so_pet = null;
  }
  StageObject_SetKeyValueInteger(so_owner, "last_pet_time_pet_unsummon", Stage_GetTimeMilliseconds());
  StageObject_SetKeyValueStageObjectReference (so_owner, "ref_pet", null); 
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_MoreItemSlots_OnUnequipped_Pet") == true) Mod_MoreItemSlots_OnUnequipped_Pet (so_owner);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}
