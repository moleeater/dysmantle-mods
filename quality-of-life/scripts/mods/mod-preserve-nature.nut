// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local blacklist_puids = {
    "stages/island/index.xml": [
        6198046, 6198047, // Q14 train rocks
      ],
    "stages/dlc1/index.xml": [
        1326114, // G20 digging rock
      ],
    "stages/dlc2/index.xml": [
        1954167, // K9 linktower root
        512224, // C9 crate rock
        1134085, 1132280, 1134099, // F20 crate rocks & root
        1412131, // H18 digging snag
      ],
  };


Include ("scripts/mods/mods-info.nut");


function Mod_PreserveNature_OnGameStart_Object (object, same) {
  local enabled = Game_GetWorldStateAsInteger ("MODS", "preserve_nature", 0) == 1 ? true : false;
  if (Actor_HasActorFlag (object, "INDESTRUCTIBLE") != enabled) {
    local is_blacklisted = false;
    local stage = Stage_GetFilename();
    if (stage != null && blacklist_puids.rawin(stage) == true) {
      local puid = StageObject_GetPersistentUniqueId (object);
      if (puid != null && blacklist_puids[stage].find(puid) != null) {
        is_blacklisted = true;
      }
    }
    if (! enabled || ! is_blacklisted) {
      Actor_SetActorFlag (object, "INDESTRUCTIBLE", enabled);
    }
  }
}


function Mod_PreserveNature_OnEnter_Stage() {
  local stage = Stage_GetFilename();
  if (Profile_GetValue ("!SAVE_STATE", "mod_preserve_nature", "enabled") == "true") {
    Profile_SetValue ("!SAVE_STATE", "mod_preserve_nature", "enabled", "");
    Game_SetWorldState ("MODS", "preserve_nature", "1");
    local objects = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, "MOD_PRESERVE_NATURE");
    if (objects != null && objects.len() > 0) {
      local stage_blacklist = null;
      if (stage != null && blacklist_puids.rawin(stage) == true) {
        stage_blacklist = blacklist_puids[stage];
      }
      foreach (object in objects) {
        if (Actor_HasActorFlag (object, "INDESTRUCTIBLE") != true) {
          local is_blacklisted = false;
          if (stage_blacklist != null) {
            local puid = StageObject_GetPersistentUniqueId (object);
            if (puid != null && stage_blacklist.find(puid) != null) {
              is_blacklisted = true;
            }
          }
          if (! is_blacklisted) {
            Actor_SetActorFlag (object, "INDESTRUCTIBLE", true);
          }
        }
      }
    }
  }
}


function Mod_PreserveNature_OnClick_FirstGameOptions (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_preserve_nature":
        Profile_SetValue ("!SAVE_STATE", "mod_preserve_nature", "enabled", UI_GetProperty ("mod_preserve_nature", "checkbox.value") == 1 ? "true" : "");
        break;
      case "mod_preserve_nature_title":
        Mods_Info_Popup (
            LocalizeText("Preserve nature"),
            LocalizeText("Keep all plants, bones and rocks indestructible when you start a new game."));
        break;
    }
  }
}


function Mod_PreserveNature_OnEnter_FirstGameOptions() {
  UI_SetProperty ("mod_preserve_nature", "checkbox.value", 0);
  UI_SetProperty ("mod_preserve_nature_title", "textbox.text", "|img src='emojis/package.png' scale=0.7 offset=2|   " + LocalizeText("Preserve nature"));
  Mod_PreserveNature_OnClick_FirstGameOptions ("mod_preserve_nature");
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
