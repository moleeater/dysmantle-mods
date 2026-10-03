// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_CutGatherables_OnGameStart_Gatherable (gatherable, same) {
  if (StageObject_GetKeyValue (gatherable, "disable_gather", false) == true) {
    Actor_SetActorFlag (gatherable, "SOLID", false);
    StageObject_RemoveTag (gatherable, "TABLEWARE");
  } else {
    local actor_type = Actor_GetActorType (gatherable);
    local actor_type_kvs = ActorType_GetKeyValueStore (actor_type);
    local requires_skill = KeyValueStore_GetKeyValue (actor_type_kvs, "requires_skill");
    if (Game_IsFeatureAvailable ("GATHERER") == true && (requires_skill == null || Game_IsRecipeCrafted (requires_skill) == true)) {
      Actor_SetActorFlag (gatherable, "SOLID", true);
      StageObject_AddTag (gatherable, "TABLEWARE");
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
