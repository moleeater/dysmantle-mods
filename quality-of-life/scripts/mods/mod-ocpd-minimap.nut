// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local interval_realseconds = 3.0;
local update_in_realseconds = 0.0;
local force_player_unarmed = null;


Include ("scripts/mods/mods-info.nut");


function Mod_OCPDMinimap_OnUpdate_Stage (tdelta) {
  update_in_realseconds -= tdelta;
  if (Game_GetWorldStateAsInteger ("MODS", "ocpd_minimap_enabled", 0) == 1) {
    if (update_in_realseconds < 0.0) {
      update_in_realseconds = interval_realseconds;
      if (force_player_unarmed == null) {
        local stage_kvs = Stage_GetKeyValueStore();
        if (stage_kvs != null) {
          force_player_unarmed = KeyValueStore_GetKeyValue (stage_kvs, "force_player_unarmed", false);
        }
      }
      if (force_player_unarmed != true) {
        local objects = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, "MOD_OCPD_MINIMAP");
        if (objects != null && objects.len() > 0) {
          foreach (object in objects) {
            if ((StageObject_HasTag (object, "DISMANTLABLE") != true || (Actor_HasActorFlag (object, "INDESTRUCTIBLE") != true && Actor_HasActorFlag (object, "SOLID") == true))
            && (Game_GetWorldStateAsInteger ("MODS", "preserve_nature", 0) != 1 || StageObject_HasTag (object, "MOD_PRESERVE_NATURE") != true)) {
              Game_RevealActorOnMap (object);
            }
          }
        }
      }
    }
  }
}


function Mod_OCPDMinimap_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_ocpd_minimap_enabled":
        local enabled = UI_GetProperty (clicked, "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "ocpd_minimap_enabled", enabled ? "1" : "0");
        UI_SetVisible ("mod_ocpd_minimap_enabled_notice", enabled);
        break;
      case "mod_ocpd_minimap_enabled_title":
        Mods_Info_Popup (
            LocalizeText("OCPD minimap"),
            LocalizeText("Remaining destroyable, searchable, usable, gatherable, diggable objects are marked on the minimap. Accessibility mod for people having OCPD Obsessive-compulsive personality disorder."));
        break;
    }
  }
}


function Mod_OCPDMinimap_OnEnter_OptionsUnified (stage_in_stack) {
  local enabled = Game_GetWorldStateAsInteger ("MODS", "ocpd_minimap_enabled", 0) == 1 ? true : false;
  UI_SetProperty ("mod_ocpd_minimap_enabled", "checkbox.value", enabled ? 1 : 0);
  UI_SetProperty ("mod_ocpd_minimap_enabled_title", "textbox.text", LocalizeText("OCPD minimap"));
  UI_SetVisible ("mod_ocpd_minimap_enabled_notice", enabled);
  UI_SetProperty ("mod_ocpd_minimap_enabled_notice", "textbox.text", LocalizeText("Notice: causes lag spikes!"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
