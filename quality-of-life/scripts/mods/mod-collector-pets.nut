// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local default_box_radius = 52.0;
local interval_realseconds = 1.0;
local collect_in_realseconds = 0.0;


Include ("scripts/mods/mods-info.nut");


function Mod_CollectorPets_OnThink_Animal (pet, tdelta) {
  collect_in_realseconds -= tdelta;
  if (Game_GetWorldStateAsInteger ("MODS", "collector_pets_enabled", 0) == 1 && StageObject_HasTag (pet, "PET") == true && StageObject_HasTag (pet, "POCKET_PET") != true) {
    if (collect_in_realseconds < 0.0) {
      collect_in_realseconds = interval_realseconds;
      local player = StageObject_GetKeyValueStageObjectReference (pet, "pet_owner");
      if (player == null) {
        player = Game_GetPrimaryPlayerActor();
      }
      if (player != null) {
        local modifiers_kvs = Game_GetAllPlayerModifiersAsKeyValueStore (player);
        local material_collect_distance_percentage_increase = 0.0;
        if (modifiers_kvs != null) {
          material_collect_distance_percentage_increase = KeyValueStore_GetKeyValue (modifiers_kvs, "material_collect_distance_percentage_increase");
          if (material_collect_distance_percentage_increase == null) material_collect_distance_percentage_increase = 0.0;
        }
        if (material_collect_distance_percentage_increase.tointeger() <= 525) {
          local magnet_radius = default_box_radius * (1.0 + material_collect_distance_percentage_increase.tofloat() * 0.01);
          local pet_position = StageObject_GetStagePosition (pet);
          if (pet_position != null) {
            local materials = Stage_QueryActorsWithTypeInRadius (pet_position[0], pet_position[1], pet_position[2], magnet_radius, "actors/collectibles/material.xml");
            if (materials != null && materials.len() > 0) {
              foreach (material in materials) {
                local material_id = StageObject_GetKeyValue (material, "material_id");
                if (material_id == null || Profile_GetValue ("PLAYER_STATE", "material_autocollect", material_id) != "0") {
                  Game_CollectMaterial (material, player);
                }
              }
            }
          }
        }
      }
    }
  }
}


function Mod_CollectorPets_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_collector_pets_enabled":
        local enabled = UI_GetProperty (clicked, "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "collector_pets_enabled", enabled ? "1" : "0");
        UI_SetVisible ("mod_collector_pets_enabled_notice", enabled);
        break;
      case "mod_collector_pets_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Collector pets") + " |img src='emojis/star.png' scale=1 offset=2|",
            LocalizeText("Pets collect materials near them from the ground into your backpack."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-collector-pets-video")}] );
        break;
    }
  }
}


function Mod_CollectorPets_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetVisible ("mod_collector_pets_enabled_title", IAP_IsItemPurchased ("DLC3") == true);
  local enabled = Game_GetWorldStateAsInteger ("MODS", "collector_pets_enabled", 0) == 1 ? true : false;
  UI_SetProperty ("mod_collector_pets_enabled", "checkbox.value", enabled ? 1 : 0);
  UI_SetProperty ("mod_collector_pets_enabled_title", "textbox.text", "|img src='emojis/star.png' scale=0.4 offset=0|  " + LocalizeText("Collector pets"));
  UI_SetVisible ("mod_collector_pets_enabled_notice", enabled);
  UI_SetProperty ("mod_collector_pets_enabled_notice", "textbox.text", LocalizeText("Notice: causes lag spikes!"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
