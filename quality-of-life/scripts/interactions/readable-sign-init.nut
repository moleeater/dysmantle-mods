// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-second-playthrough.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function GetMetadata()
{
  local data =
  {
    id = "init"
    enabled = true
    interaction_text = ""
    interaction_radius = 100
    trigger_type = "ON_GAME_START"
  };
  return data;
}

function OnInteraction(so_self, so_activator)
{
  local text = StageObject_GetKeyValue(so_self, "text");
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_SecondPlaythrough_OnGameStart_ReadableSign") == true) {
    local ret = Mod_SecondPlaythrough_OnGameStart_ReadableSign (so_self, so_activator);
    if (ret == true) text = null;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  if (text != null)
  {
    Actor_SetActorFlag(so_self, "INDESTRUCTIBLE", true);
    StageObject_AddTag(so_self, "PET_IGNORE_ATTACK");

    local puid = StageObject_GetPersistentUniqueId(so_self)

    if (StageObject_GetParent(so_self) != null && !Game_IsPUIDMarkedDestroyed(puid)){
      local so_parent = StageObject_GetParent(so_self);
      Actor_SetActorFlag(so_parent, "INDESTRUCTIBLE", true);
      StageObject_AddTag(so_parent, "PET_IGNORE_ATTACK");
    }


  }

  return;
}
