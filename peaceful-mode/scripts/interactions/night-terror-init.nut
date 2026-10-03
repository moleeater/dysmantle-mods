// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-peaceful-mode.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function GetMetadata()
{
  local data =
  {
    id = "init"
    enabled = true
    trigger_type = "ON_GAME_START"
  };
  return data;
}

function OnInteraction(so_self, so_activator)
{
  local t = 24 * Game_GetWorldTimeRelativeDayBetween0And1AfterMidnight();
  local should_be_visible = !(t > 5 && t < 22) && Game_GetWorldTimeDay() >= 24;
  if (!should_be_visible)
  {
    Stage_DeleteStageObjectQueued(so_self);
    return;
  }
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_PeacefulMode_OnGameStart_Enemy") == true) Mod_PeacefulMode_OnGameStart_Enemy (so_self, so_activator);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}
