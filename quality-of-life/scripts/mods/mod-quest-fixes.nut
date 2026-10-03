// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_QuestFixes_OnGameStart_EscapePod (pod, same) {
  if (StageObject_GetId (pod) == "CROWN_STATION_ESCAPE_POD" && StageObject_GetKeyValue (pod, "required_materials", "") == "5xMANA_CHUNK,5xMANA_BEAD,3xTOMB_ORB,2xMANA_SHARD") {
    StageObject_SetKeyValueString (pod, "required_materials", "5xMANA_BEAD,5xMANA_CHUNK,2xMANA_SHARD,3xTOMB_ORB");
  }
}


function Mod_QuestFixes_OnGameStart_WaterPlane (waterplane, same) {
  if (Stage_GetFilename == "stages/island/index.xml" && StageObject_GetPersistentUniqueId (waterplane) == 6308001) {
    local marker = Stage_GetStageObjectByPUID (6308171);
    if (marker != null) {
      Stage_DeleteStageObject (marker);
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
