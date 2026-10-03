// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local whitelist_actor_types = [
    "actors/animals/caribou.xml",
    "actors/animals/caribou-baby-calf.xml",
    "actors/animals/deer.xml",
    "actors/animals/deer-baby-fawn.xml",
    "actors/animals/deer-female.xml",
    "actors/animals/deer-male.xml",
    "actors/animals/deer-male-mana.xml",
    "actors/enemies/boomsquito.xml",
    "actors/enemies/doomsquito.xml",
    "actors/enemies/ex-animal-mana-wolf.xml",
    "actors/enemies/ex-animal-wolf.xml",
    "actors/enemies/ex-human-fast-chaser.xml",
    "actors/enemies/ex-human-female-melee.xml",
    "actors/enemies/ex-human-female-melee-advanced.xml",
    "actors/enemies/ex-human-leaper.xml",
    "actors/enemies/ex-human-male-mana-melee.xml",
    "actors/enemies/ex-human-male-melee.xml",
    "actors/enemies/ex-human-male-melee-advanced.xml",
    "actors/enemies/ex-human-mana-chaser.xml",
    "actors/enemies/ex-human-mana-female-melee.xml",
    "actors/enemies/ex-human-mana-puker.xml",
    "actors/enemies/ex-human-mana-stalker.xml",
    "actors/enemies/ex-human-puker.xml",
    "actors/enemies/ex-human-stalker.xml",
    "actors/enemies/mana-spirit.xml",
    "actors/enemies/mortarpod.xml",
    "actors/enemies/spikeball.xml",
    "actors/enemies/tomb-guard.xml",
    "actors/enemies/tomb-guard-mana.xml",
    "actors/enemies/tomb-guard-ranged.xml",
    "actors/enemies/tomb-melee-enemy.xml",
  ];


Include ("scripts/mods/mods-info.nut");


function Mod_HideCorpses_OnGameStart_Creature (creature) {
  if (Game_GetWorldStateAsInteger ("MODS", "hide_corpses_enabled", 0) == 1) {
    local health = Actor_GetAttributeHitPoints (creature);
    if (health == null || health <= 0.0) {
      local actor_type = Actor_GetActorType (creature);
      if (actor_type != null && whitelist_actor_types.find(actor_type) != null) {
        StageObject_SetEnabled (creature, false);
      }
    }
  }
}


function Mod_HideCorpses_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_hide_corpses_enabled":
        local enabled = UI_GetProperty ("mod_hide_corpses_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "hide_corpses_enabled", enabled ? "1" : "0");
        foreach (tag in [ "MONSTER", "ANIMAL" ]) {
          local creatures = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, tag);
          if (creatures != null && creatures.len() > 0) {
            foreach (creature in creatures) {
              local health = Actor_GetAttributeHitPoints (creature);
              if (health == null || health <= 0.0) {
                local actor_type = Actor_GetActorType (creature);
                if (actor_type != null && whitelist_actor_types.find(actor_type) != null) {
                  StageObject_SetEnabled (creature, ! enabled);
                }
              }
            }
          }
        }
        break;
      case "mod_hide_corpses_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Hide corpses"),
            LocalizeText("Clean up the corpses of the minions after resting at a campfire or reloading the game."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-hide-corpses-video")}] );
        break;
    }
  }
}


function Mod_HideCorpses_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_hide_corpses_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "hide_corpses_enabled", 0));
  UI_SetProperty ("mod_hide_corpses_enabled_title", "textbox.text", LocalizeText("Hide corpses"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
