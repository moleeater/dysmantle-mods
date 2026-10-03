// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-starting-stage.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


local owner_handle = 0;

function OnMetadataRead()
{
  local info = {
    name = "Home Portal"
    description = "Transports the user to home and back again."
    use_description = "Teleport to home."
    destroy_after_owner_death = true
  };

  return info;
}

function OnInitialize(so_handle_owner, item_id)
{
  owner_handle = so_handle_owner;
  return true;
}

function OnTriggerDown()
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_StartingStage_OnTriggerDown_HomePortalDevice") == true) {
    local ret = Mod_StartingStage_OnTriggerDown_HomePortalDevice (owner_handle);
    if (ret != null) return ret;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  if (Game_IsStoringMaterials())
    return;

  local current_pos = StageObject_GetStagePosition(owner_handle);
  local current_stage = Stage_GetFilename();
  local kvs_global = Game_GetGlobalKeyValueStore("home_portal");

  local stage_kvs = Stage_GetKeyValueStore();
  local so_portal = StageObject_GetByIdAndType("HOME_PORTAL", STAGE_OBJECT_TYPE_ACTOR);

  if (so_portal == null)
  {
    if (!Game_IsRecipeCrafted("HOME_PORTAL_DEVICE_LONG_RANGE"))
    {
      Game_AddActorNotification(owner_handle, LOC_TEXT("I can't use this here."));
      return;
    }
    
    if (string_contains_string(current_stage, "/tombs/") ||
      string_contains_string(current_stage, "/pet-stages/"))
    {
      Game_AddActorNotification(owner_handle, LOC_TEXT("I can't use this here."));
      return;
    }
  }
  else if (KeyValueStore_GetKeyValue(kvs_global, "open", false))
  {
    local portal_pos = StageObject_GetStagePosition(so_portal);
    local dx = current_pos[0] - portal_pos[0];
    local dy = current_pos[1] - portal_pos[1];
    local dz = current_pos[2] - portal_pos[2];
    local distance = sqrt(dx*dx + dy*dy + dz*dz);
    if (distance < 600)
    {
      Game_AddActorNotification(owner_handle, LOC_TEXT("I'm already here."));
      return;
    }    
  }
  
  if (!KeyValueStore_GetKeyValue(stage_kvs, "persistent", true))
  {
    // NOTE: Tombs appear to be ok too. When teleporting back it just starts from 
    //       the beginning in reset tomb, not where you were, which is just what we want.
    //Game_AddActorNotification(owner_handle, LOC_TEXT("I can't use this here."));
    //return;
  }

  if (StageObject_HasTag(owner_handle, "IN_DANGER"))
  {
    Game_AddActorNotification(owner_handle, LOC_TEXT("There are enemies near. It's not safe to use the device."));
    return;
  }

  Actor_QueueActionPlayAnimationWithParameters(owner_handle, "home_portal_used", 2, 0, true);

  KeyValueStore_SetKeyValueBoolean(kvs_global, "open", true);
  KeyValueStore_SetKeyValuePosition(kvs_global, "teleport_target_pos", current_pos[0], current_pos[1], current_pos[2]);
  KeyValueStore_SetKeyValueString(kvs_global, "teleport_from_stage", current_stage);

  if (so_portal == null)
  {
    // Travel to main island
    Game_FastTravelToExternalStagePointOfInterest("stages/island/index.xml", "HOME_PORTAL");
    //Game_AddActorNotification(owner_handle, LOC_TEXT("I can't use this here."));
    return;
  }

  // Travel on the same stage.
  
  // Old legacy definition for portal actor, not usable for external stage travelling.
  StageObject_SetKeyValueBoolean(so_portal, "open", false);
  
  Actor_InteractWithInteraction(so_portal, so_portal, "init");
  Actor_PlayAnimation(so_portal, "player_exits_portal");
  
  local kvs = StageObject_GetKeyValueStore(so_portal);
  KeyValueStore_SetKeyValuePosition(kvs, "teleport_target_pos", current_pos[0], current_pos[1], current_pos[2]);
  KeyValueStore_SetKeyValueString(kvs, "teleport_from_stage", current_stage);
  

  local angle = StageObject_GetAngle(so_portal);
  StageObject_SetAngle(owner_handle, angle);
  
  local portal_pos = StageObject_GetStagePosition(so_portal);
  
  Game_TeleportPlayers(portal_pos[0] + 60, portal_pos[1] + 10, portal_pos[2]);  
}

function OnCommandWord(id, kvs)
{
  if (id == "trigger_special_item")
  {
  }
}
