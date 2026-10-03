// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_CameraHeading_OnDraw_Stage() {
  local angle = null;
  local engine_kvs = Engine_GetKeyValueStore();
  if (engine_kvs != null && KeyValueStore_GetKeyValue (engine_kvs, "minimap_rotated_based_on_camera", false) != true) {
    local camera = Stage_GetActiveCamera();
    if (camera != null) {
      angle = StageObject_GetAngle (camera);
    }
  }
  if (angle == null) {
    UI_SetVisible ("mod_camera_heading", false);
  } else {
    UI_SetProperty ("mod_camera_heading", "angle.z", m_anglemod ((angle + 90.0) * PI / 180.0));
    UI_SetVisible ("mod_camera_heading", true);
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
