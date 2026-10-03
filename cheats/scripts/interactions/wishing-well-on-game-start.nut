// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-free-wells.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function OnInteraction(so_self, so_activator)
{
  local id = "puid" + StageObject_GetPersistentUniqueId(so_self);
  local state = Game_GetWorldState("WISHING_WELLS", id);
  local level = state ? (state.tointeger() + 1) : 1;

  local requested_materials = StageObject_GetKeyValue(so_self, "requested_materials");
  if (requested_materials == null || requested_materials == "")
    requested_materials = Game_GetWishingWellRequestedMaterials(so_self, level);
  if (requested_materials == null)
  {
    Actor_SetInteractionEnabled(so_self, "use", false);
    Actor_StopAnimationWithFade(so_self, "idle", 0.3);
    return;
  }

  // Convert old missing material to another one.
  requested_materials = string_replace(requested_materials, "TIMBER", "WOOD");

  StageObject_SetKeyValueString(so_self, "requested_materials", requested_materials);

  local text = "";
  local substrings = split(requested_materials, "x, ");
  foreach (str in substrings)
  {
    if (str.len() <= 2)
    {
      text += str + "x";
    }
    else
    {
      text += "[MATERIAL_ICON=" + str + "]  ";
    }
  }
  rstrip(text);
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_FreeWells_OnGameStart_WishingWell") == true) {
    local ret = Mod_FreeWells_OnGameStart_WishingWell (so_self, so_activator);
    if (ret != null) text = ret;
  }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  Actor_SetInteractionText(so_self, "use", Game_GetConvertedString(text));
  Actor_SetInteractionEnabled(so_self, "use", true);
}
