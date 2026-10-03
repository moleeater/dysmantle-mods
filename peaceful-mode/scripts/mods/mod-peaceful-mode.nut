// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_PeacefulMode_Damage (enemy, actor_type = null) {
  if (actor_type == null) {
    actor_type = Actor_GetActorType (enemy);
  }
  local player = Game_GetPrimaryPlayerActor();
  local health = Actor_GetAttributeHitPoints (enemy);
  if (player != null && health != null && health > 0.0) {
    Stage_DealDamage (player, enemy, health * 1.1, "EXPLOSIVE");
    health = Actor_GetAttributeHitPoints (enemy);
    if (health != null && health > 0.0 && actor_type != "actors/enemies/boomsquito.xml") {
      Engine_Warning("mod-peaceful-mode enemy health is still not 0, actor type: " + actor_type);
    }
  }
}


function Mod_PeacefulMode_OnInterval_Enemy (enemy, same) {
  if (StageObject_IsValid (enemy) == true && StageObject_IsEnabled (enemy) == true && StageObject_IsVisible (enemy) == true && actor_type != null) {
    local name = StageObject_GetId (enemy);
    if (name == null || name.len() < 16 || name.slice(0, 16) != "BOSS_ADD_TURRET_") {
      Mod_PeacefulMode_Damage (enemy);
    }
  }
}


function Mod_PeacefulMode_OnGameStart_Enemy (enemy, same) {
  if (Game_GetWorldState ("MODS", "peaceful_mode_used") != "1") {
    Game_SetWorldState ("MODS", "peaceful_mode_used", "1");
    Game_LogEvent ("MOD_PEACEFUL_MODE");
  }
  local stage = Stage_GetFilename();
  local actor_type = Actor_GetActorType (enemy);
  if (StageObject_IsValid (enemy) == true && StageObject_IsEnabled (enemy) == true && StageObject_IsVisible (enemy) == true
  && stage != "stages/tombs/tomb-everlasting-duty.xml" && actor_type != null) {
    if (Actor_HasInteraction (enemy, "extract") != true) {
      if (Actor_HasActorFlag (enemy, "DELETE_ACTOR_AFTER_DEATH") != true) {
        Actor_SetActorFlag (enemy, "DELETE_ACTOR_AFTER_DEATH", true);
      }
    }
    switch (actor_type) {
      case "actors/enemies/mana-spirit.xml":
      case "actors/enemies/boss-mana-spirit.xml":
      case "actors/enemies/night-terror-mana-spirit.xml":
        StageObject_SetKeyValueFloat (enemy, "vulnerability_timer", 60.0 * 60.0);
        Mod_PeacefulMode_Damage (enemy, actor_type);
        break;
      case "actors/enemies/turret-lab-machinegun-hidden.xml":
        local name = StageObject_GetId (enemy);
        if (name == null || name.len() < 16 || name.slice(0, 16) != "BOSS_ADD_TURRET_") {
          Actor_QueueActionSendCommandWord (enemy, enemy, "open");
////local open_command = Command_Create("open");
////local kvs = Command_GetKeyValueStore(open_command);
////KeyValueStore_SetKeyValueBoolean(kvs, "instant", false);
        }
        break;
      default:
        Mod_PeacefulMode_Damage (enemy, actor_type);
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
