// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local island_puids = {};
island_puids[1010118] <- [ 1010137, 1202081, ];
island_puids[2750110] <- [ 2750178, ];
island_puids[3528208] <- [ 3528253, 3720219, ];
island_puids[3528209] <- [ 3720220, ];
island_puids[3918210] <- [ 3918206, ];
island_puids[3918209] <- [ 3918207, 3918208, ];
island_puids[3918238] <- [ 4110158, ];
island_puids[4110160] <- [ 3918247, 4110159, ];
island_puids[4494332] <- [ 4494330, ];
island_puids[4494333] <- [ 4494331, ];
island_puids[4496349] <- [ 4496348, ];


function Mod_LinkGasLeaks_OnGameStart_GasCloud (gascloud, same) {
  if (Stage_GetFilename() == "stages/island/index.xml") {
    local puid = StageObject_GetPersistentUniqueId (gascloud);
    local parent_puid = null;
    foreach (possible_parent_puid, possible_gascloud_puids in island_puids) {
      if (possible_gascloud_puids.find(puid) != null) {
        parent_puid = possible_parent_puid;
        break;
      }
    }
    if (parent_puid != null) {
      if (Game_IsPUIDMarkedDestroyed (parent_puid) == true) {
        Game_MarkStageObjectPersistentlyDestroyed (gascloud, true);
        Stage_DeleteStageObjectQueued (gascloud);
      } else {
        local parent = Stage_GetStageObjectByPUID (parent_puid);
        if (parent != null) {
          StageObject_SetParentButRetainStageTransform (gascloud, parent);
        }
      }
    }
  }
}


function Mod_LinkGasLeaks_OnGameStart_Object (object, same) {
  if (Stage_GetFilename() == "stages/island/index.xml") {
    local puid = StageObject_GetPersistentUniqueId (object);
    if (puid != null && island_puids.rawin(puid) == true) {
      foreach (gascloud_puid in island_puids[puid]) {
        local gascloud = Stage_GetStageObjectByPUID (gascloud_puid);
        if (gascloud != null) {
          StageObject_SetParentButRetainStageTransform (gascloud, object);
        }
      }
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
