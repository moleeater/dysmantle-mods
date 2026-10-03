// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-fix-from-storage.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-free-wells.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-well-prepared.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function IsInteractionAvailable(so_self, so_activator)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_FreeWells_PressButtonUseIsInteractionAvailable_WishingWell") == true) Mod_FreeWells_PressButtonUseIsInteractionAvailable_WishingWell (so_self, so_activator);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_WellPrepared_PressButtonUseUseIsInteractionAvailable_WishingWell") == true) {
    local ret = Mod_WellPrepared_PressButtonUseUseIsInteractionAvailable_WishingWell (so_self, so_activator);
    if (ret != null) return ret;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  local time_now = Game_GetWorldTimeSecondsAsRealTimeSeconds();
  local time_used = StageObject_GetKeyValue(so_self, "time_used");
  local TIME_TO_WAIT = StageObject_GetKeyValue(so_self, "time_to_wait");
  if (time_used != null)
  {
    local time_waited = time_now - time_used;
    if (time_waited < TIME_TO_WAIT)
      return false;
  }

  return !Game_IsStoringMaterials();
}


function OnInteraction(so_self, so_activator)
{
  if (Game_IsStoringMaterials())
  {
    return;
  }

  Game_SaveGame();

  local id = "puid" + StageObject_GetPersistentUniqueId(so_self);
  local state = Game_GetWorldState("WISHING_WELLS", id);
  local level = state ? (state.tointeger() + 1) : 1;

  local requested_materials = StageObject_GetKeyValue(so_self, "requested_materials");
  if (requested_materials)
  {
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    local mod_free_wells_is_enabled = false;
    if (this.rawin ("Mod_FreeWells_PressButtonUseUse_WishingWell") == true) {
      local ret = Mod_FreeWells_PressButtonUseUse_WishingWell (so_self, so_activator);
      if (ret != null) mod_free_wells_is_enabled = ret;
    }
    local mod_fix_from_storage_is_done = false;
    if (mod_free_wells_is_enabled != true && this.rawin ("Mod_FixFromStorage_PressButtonUseUse_WishingWell") == true) {
      local ret = Mod_FixFromStorage_PressButtonUseUse_WishingWell (so_self, so_activator, requested_materials);
      if (ret != null) mod_fix_from_storage_is_done = ret;
    }
    if (mod_free_wells_is_enabled == true || mod_fix_from_storage_is_done == true || Game_ThrowMaterialsToActor(so_activator, so_self, requested_materials))
    {
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      Game_SetWorldState("WISHING_WELLS", id, level.tostring());
      StageObject_SetKeyValueString(so_self, "prev_requested_materials", requested_materials);
      StageObject_SetKeyValueString(so_self, "requested_materials", "");
      Actor_SetInteractionEnabled(so_self, "use", false);
      Actor_PlayAnimation(so_self, "accept");
      Game_LogEvent("WISHING_WELL_ACCEPT");
      Game_ChangeMedalProgressAmount("WISHING_WELLS", 1);
    }
    else
    {
      Game_LogEvent("WISHING_WELL_REJECT");
      Actor_PlayAnimation(so_self, "reject");
      Actor_PlayAnimation(so_activator, "not_here");

      if (Game_IsShowingActorNotification(so_activator))
        return;

      local times_tried = StageObject_GetKeyValue(so_self, "times_tried");
      if (times_tried == null)
        times_tried = 0;
      times_tried++;

      local materials = string_replace(requested_materials, "x", "x[MATERIAL_ICON=");
      materials = string_replace(materials, ",", "] ") + "]";
      local text;

      if (times_tried == 1)
      {
        text = LOC_TEXT("I'm not carrying those materials right now [EMOJI=thinking face]");
      }
      else if (times_tried == 2)
      {
        text = LOC_TEXT("I should come back with [REQUESTED_MATERIALS] later [EMOJI=thinking face]");
      }
      else
      {
        text = LOC_TEXT("Where could I find those materials [EMOJI=thinking face]");
        times_tried = 0;
      }
      StageObject_SetKeyValueInteger(so_self, "times_tried", times_tried);

      text = string_replace(text, "[REQUESTED_MATERIALS]", materials);
      Game_AddActorNotification(so_activator, text);
    }
  }
}
