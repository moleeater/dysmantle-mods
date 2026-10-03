// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_SaferChasms_OnGameStart_Chasm (chasm, same) {
  if (Game_GetWorldStateAsInteger ("MODS", "safer_chasms_enabled", 0) == 1 && Stage_GetFilename() != "stages/pet-stages/pet-stage-fight-5.stage") {
    Actor_SwitchColliderModel (chasm, "models/mods/mod-safer-chasms.model");
  } else {
    Actor_SwitchColliderModel (chasm, "models/objects/chasm-12x6-collider.model");
  }
}


function Mod_SaferChasms_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_safer_chasms_enabled":
        local enabled = UI_GetProperty ("mod_safer_chasms_enabled", "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "safer_chasms_enabled", enabled ? "1" : "0");
        local stage = Stage_GetFilename();
        local chasms = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, "CHASM");
        if (chasms != null && chasms.len() > 0) {
          foreach (chasm in chasms) {
            if (enabled && stage != "stages/pet-stages/pet-stage-fight-5.stage") {
              Actor_SwitchColliderModel (chasm, "models/mods/mod-safer-chasms.model");
            } else {
              Actor_SwitchColliderModel (chasm, "models/objects/chasm-12x6-collider.model");
            }
          }
        }
        break;
      case "mod_safer_chasms_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Safer chasms"),
            LocalizeText("Your character will refuse to walk into chasms and will stop at the edge."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-safer-chasms-video")}] );
        break;
    }
  }
}


function Mod_SaferChasms_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_safer_chasms_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "safer_chasms_enabled", 0));
  UI_SetProperty ("mod_safer_chasms_enabled_title", "textbox.text", LocalizeText("Safer chasms"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
