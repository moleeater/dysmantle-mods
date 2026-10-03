// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-extract-barrier.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function IsInteractionAvailable(so_self, so_activator)
{
  if (Game_GetWorldState("BOSS", "looted_" + StageObject_GetPersistentUniqueId(so_self).tostring()) != null)
    return false;
  return Actor_GetAttributeHitPoints(so_self) <= 0 || Game_GetWorldState("BOSS", "killed_" + StageObject_GetId(so_self).tostring()) != null;
;
}

function OnInteraction(so_self, so_activator)
{
  Actor_SetActorFlag(so_self, "SKIP_DEATH_EFFECTS", false);
  Actor_PlayAnimation(so_self, "extract_fuel_cell");
  Game_SetWorldState("BOSS", "looted_" + StageObject_GetPersistentUniqueId(so_self).tostring(), "1");
  local barrier = StageObject_GetKeyValue(so_self, "barrier");
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_ExtractBarrier_PressButtonUseExtract_BossMain") == true) Mod_ExtractBarrier_PressButtonUseExtract_BossMain (so_self, so_activator, barrier);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  if (barrier != null)
    StageObject_SetEnabled(barrier, false);
}
