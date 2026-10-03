// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-starting-stage.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function OnInteraction(so_self, so_activator)
{
  local id = StageObject_GetId(so_self);
  local pos = StageObject_GetPosition(so_self);
  local so_plane = Stage_QueryNearestActorWithType(pos[0],pos[1],pos[2], 120, "actors/interactives/buried-teleporter-plane.xml");
  //local so_plane = StageObject_GetKeyValue(so_self, "plane");
  if (so_plane != null)
  {
    if (id == null)
    {
      Engine_Warning("Missing buried teleported id!");
      id = "NONE";
    }
    if (Game_IsBuriedTeleporterFound(id))
      Stage_DeleteStageObject(so_plane);
  }

  local set_id = StageObject_GetKeyValue(so_self, "set", "");
  local stage_id = StageObject_GetKeyValue(so_self, "stage", "");
  local is_unlocked = StageObject_GetKeyValue(so_self, "unlocked", "");
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_StartingStage_OnGameStart_BuriedTeleporter") == true) {
    local ret = Mod_StartingStage_OnGameStart_BuriedTeleporter (so_self, so_activator);
    if (ret != null) is_unlocked = ret;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  if (!Game_IsTombDiscovered(stage_id) && is_unlocked == false)
  {
    Actor_SetActorFlag(so_self, "ONLY_VISIBLE_IN_EDITOR", true);
    if (set_id != "")   //Pethub
      StageObject_SetEnabled(so_self, false);
  }

  if (Game_IsTombCompleted(stage_id))
  {
    Actor_PlayAnimation(so_self, "completed");
  }
  else if(Game_IsTombDiscovered(stage_id))
  {
    Actor_PlayAnimation(so_self, "idle");
  }
  if(id != null && Game_GetWorldState ("BURIED_TELEPORTERS", id) == "-1")
    Actor_InteractWithInteraction(so_self, so_self, "pet_digged");

}
