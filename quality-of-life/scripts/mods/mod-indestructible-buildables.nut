// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local blacklist_actor_types = [
    "actors/buildables/camp-storage-box.xml",
    "actors/buildables/suburb-sandbag-barrier.xml",
    "actors/buildables/turret-machine-gun.xml",
    "actors/buildables/turret-rocket-launcher.xml",
  ];
local interval_realseconds = 0.1;
local last_realseconds = null;


Include ("scripts/mods/mods-info.nut");


function Mod_IndestructibleBuildables_Query() {
  local buildables = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, "BUILDABLE");
  if (buildables != null && buildables.len() > 0) {
    local enabled = Game_GetWorldStateAsInteger ("MODS", "indestructible_buildables_enabled", 0) == 1 ? true : false;
    local player = Game_GetPrimaryPlayerActor();
    foreach (buildable in buildables) {
      local actor_type = Actor_GetActorType (buildable);
      if (actor_type != null && blacklist_actor_types.find(actor_type) == null) {
        if (enabled) {
          if (Actor_HasActorFlag (buildable, "INDESTRUCTIBLE") != true) {
            Actor_SetActorFlag (buildable, "INDESTRUCTIBLE", true);
          }
          local max_health = Actor_GetAttributeMaximumHitPoints (buildable);
          local health = Actor_GetAttributeHitPoints (buildable);
          if (max_health != null && health != null && health > 0.0 && health < max_health && player != null) {
            Stage_HealActor (player, buildable, max_health);
          }
        } else if (Actor_HasActorFlag (buildable, "INDESTRUCTIBLE") == true && StageObject_HasTag (buildable, "PERSISTENT_CREATED_ACTOR") == true) {
          Actor_SetActorFlag (buildable, "INDESTRUCTIBLE", false);
        }
      }
    }
  }
}


function Mod_IndestructibleBuildables_OnGameStart_Platform (platform, same) {
  Mod_IndestructibleBuildables_Query();
  UI_SendScreenMessage ("Stage", "mod_indestructible_buildables_time_message", NX_GetTimeSecondsElapsedSinceEpoch().tostring());
}


function Mod_IndestructibleBuildables_OnScreenMessage_Stage (key, value) {
  if (key == "mod_indestructible_buildables_time_message") {
    last_realseconds = value.tointeger();
  }
}


function Mod_IndestructibleBuildables_OnUpdate_Stage (tdelta) {
  local now = NX_GetTimeSecondsElapsedSinceEpoch();
  if (last_realseconds == null || now - last_realseconds > interval_realseconds) {
    last_realseconds = now;
    Mod_IndestructibleBuildables_Query();
  }
}


function Mod_IndestructibleBuildables_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_indestructible_buildables_enabled":
        Game_SetWorldState ("MODS", "indestructible_buildables_enabled", UI_GetProperty ("mod_indestructible_buildables_enabled", "checkbox.value") == 1 ? "1" : "0");
        Mod_IndestructibleBuildables_Query();
        UI_SendScreenMessage ("Stage", "mod_indestructible_buildables_time_message", NX_GetTimeSecondsElapsedSinceEpoch().tostring());
        break;
      case "mod_indestructible_buildables_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Indestructible buildables"),
            LocalizeText("Protect your house from an accidental swing. Your buildings are indestructible, except the Storage Box, Sandbag, Turrets."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-indestructible-buildables-video")}] );
        break;
    }
  }
}


function Mod_IndestructibleBuildables_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_indestructible_buildables_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "indestructible_buildables_enabled", 0));
  UI_SetProperty ("mod_indestructible_buildables_enabled_title", "textbox.text", LocalizeText("Indestructible buildables"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
