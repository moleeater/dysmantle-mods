// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_ExtractBarrier_OnActorEntersRadius_TapeRecorder (recorder, player) {
  if (StageObject_GetId (recorder) == "audio_log_PYRAMID_CYANIDE_GAS" && StageObject_HasTag (player, "PLAYER") == true) {
    local pyramid = Stage_GetStageObjectById ("pyramid", STAGE_OBJECT_TYPE_ACTOR);
    local new_barrier = Stage_CreateActor ("actors/objects/ghost-barrier.xml", 56520.0, 44760.0, 120.0, false);
    StageObject_SetScale (new_barrier, 5.0);
    StageObject_SetAngle (new_barrier, 270.0);
    StageObject_SetParentButRetainStageTransform (new_barrier, pyramid);
    new_barrier = Stage_CreateActor ("actors/objects/ghost-barrier.xml", 56790.0, 45000.0, 120.0, false);
    StageObject_SetScale (new_barrier, 5.0);
    StageObject_SetAngle (new_barrier, 180.0);
    StageObject_SetParentButRetainStageTransform (new_barrier, pyramid);
  }
}


function Mod_ExtractBarrier_OnCollidedInto_GhostBarrier (barrier, player) {
  if (StageObject_HasTag (player, "PLAYER") == true) {
    local pyramid = Stage_GetStageObjectById ("pyramid", STAGE_OBJECT_TYPE_ACTOR);
    if (pyramid != null && StageObject_GetParent (barrier) == pyramid) {
      if (Game_GetWorldState("ARCH_SITE", "INVESTIGATE_PYRAMID") == "1") {
        Stage_DeleteStageObjectQueued (barrier);
      } else {
        if (Game_IsShowingActorNotification (player) != true) {
          Game_AddActorNotification (player, LocalizeText("Investigate the [ORANGE]Pyramid[WHITE]."));
        }
      }
    }
  }
}


function Mod_ExtractBarrier_PressButtonUseInspect_BossMain (boss, player, vanilla_barrier) {
  local ret = null;
  local boss_id = StageObject_GetId (boss);
  if (boss_id != null) {
    switch (boss_id) {
      case "BOSS_LAW":
        local new_barrier = Stage_CreateActor ("actors/objects/ghost-barrier.xml", -1000.0, -375.0, 0.0, false);
        StageObject_SetScale (new_barrier, 1.3);
        StageObject_SetAngle (new_barrier, 180.0);
        StageObject_SetParent (new_barrier, vanilla_barrier);
        break;
      case "BOSS_SWORD":
        local new_barrier = Stage_CreateActor ("actors/objects/ghost-barrier.xml", 15700.0, 16000.0, -60.0, false);
        StageObject_SetScale (new_barrier, 6.0);
        StageObject_SetKeyValueStageObjectReference (boss, "barrier", new_barrier);
        ret = new_barrier;
        break;
    }
  }
  return ret;
}


function Mod_ExtractBarrier_PressButtonUseExtract_BossMain (boss, player, vanilla_barrier) {
  if (vanilla_barrier != null) {
    for (local index = 0; index < StageObject_GetNumberOfChildren (vanilla_barrier); index++) {
      StageObject_SetEnabled (StageObject_GetChildByIndex (vanilla_barrier, index), false);
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
