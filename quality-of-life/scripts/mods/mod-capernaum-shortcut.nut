// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local container_puid = 5514095;
local barrels = [
    [ 83466.0, 34106.0,   0.0, 111.0 ],
    [ 83499.0, 34111.0,   0.0,  67.0 ],
    [ 83531.0, 34105.0,   0.0, 222.0 ],
    [ 83520.0, 34136.0,   0.0,  11.0 ],
    [ 83486.0, 34112.0, -48.0, -48.0 ],
    [ 83518.0, 34111.0, -48.0,  48.0 ],
  ];


function Mod_CapernaumShortcut_OnCreate_SuburbCargoContainer (container, same) {
  if (StageObject_GetPersistentUniqueId (container) == container_puid && Stage_GetFilename() == "stages/island/index.xml" && Game_IsPUIDMarkedDestroyed (container_puid) != true) {
    foreach (data in barrels) {
      local barrel = Stage_CreateActor ("actors/objects/exploding-barrel.xml", data[0], data[1], data[2], false);
      StageObject_SetAngle (barrel, data[3]);
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
