// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-camera-distance.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-remind-to-extract.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
mods_include_path = "scripts/mods/mod-trophies.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function SetSpawnersActive(so_self, enabled)
{
  local pos = StageObject_GetStagePosition(so_self);
  local list = Stage_QueryActorsWithTypeInRadius(pos[0], pos[1], pos[2], 1000, "actors/interactives/spawner.xml");
  foreach (so in list)
  {
    StageObject_SetKeyValueBoolean(so, "active", enabled);
  }
}

function OnInteraction(so_self, so_activator)
{
  local kvs = Stage_GetKeyValueStore();
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  local distance = 0.0;
  if (this.rawin ("Mod_CameraDistance_OnDeathStart_BossMain") == true) {
    distance = Mod_CameraDistance_OnDeathStart_BossMain (so_self, so_activator);
  }
  KeyValueStore_SetKeyValueFloat(kvs, "camera_distance_modifier", distance);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  local id = StageObject_GetId(so_self).tostring();
  Game_SetWorldState("BOSS", "killed_" + id, "1");
  SetSpawnersActive(so_self, false);

  Achievements_UnlockAchievement(id);
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mod_Trophies_OnDeathStart_BossMain") == true) Mod_Trophies_OnDeathStart_BossMain (so_self, so_activator);
  if (this.rawin ("Mod_RemindToExtract_OnDeathStart_BossMain") == true) Mod_RemindToExtract_OnDeathStart_BossMain (so_self, so_activator);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}
