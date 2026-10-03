// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Include ("scripts/mods/mods-info.nut");


function Mod_MoreItemSlots_OnUnequipped_Pet (player) {
  if (Game_IsRecipeCrafted ("MOD_MORE_ITEM_SLOTS") == true) {
    local pets = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, "PET");
    if (pets != null && pets.len() > 0) {
      StageObject_SetKeyValueStageObjectReference (player, "ref_pet", pets[0]);
    }
  }
}


function Mod_MoreItemSlots_OnEnter_PauseMenu() {
  local enabled = Game_IsRecipeCrafted ("MOD_MORE_ITEM_SLOTS") == true;
  UI_SetVisible ("InventorySlot_TOOLS_4", enabled);
  UI_SetVisible ("InventorySlot_TOOLS_5", enabled);
  UI_SetVisible ("InventorySlot_SPECIALS_5", enabled);
  foreach (i in [5,6,7,8,9]) {
    UI_SetVisible ("InventorySlot_TRINKETS_" + i.tostring(), enabled);
  }
  UI_SetProperty ("aligner_slot_pets", "aligner.layout", enabled ? 0 : 1);
  UI_SetProperty ("aligner_slot_pets", "aligner.area_width", enabled ? 380 : 0);
  UI_SetProperty ("aligner_slot_pets", "aligner.area_height", enabled ? 236 : 240);
  UI_SetProperty ("aligner_slot_pets", "aligner.automatic_area_width", ! enabled);
  UI_SetProperty ("aligner_slot_pets", "aligner.fixed_num_rows", enabled ? 2 : 1);
  UI_SetProperty ("aligner_slot_pets", "aligner.align_y_axis", enabled);
  UI_SetProperty ("aligner_slot_pets", "position_offset.y", enabled ? -0.719 : 0);
  UI_SetProperty ("aligner_slot_pets", "position_offset.x", enabled ? -0.0038 : 0);
  UI_SetProperty ("category_title_6", "parent", enabled ? "InventorySlot_OUTFITS_0" : "marker_title_holder_5");
  foreach (i in [1,2,3,4,5,6,7,8,9]) {
    UI_SetVisible ("InventorySlot_PETS_" + i.tostring(), enabled);
  }
  foreach (i in [0,1,2,3,4,5,6,7,8,9]) {
    UI_SetProperty ("InventorySlot_PETS_" + i.tostring(), "button.bitmap_color_idle", 1, enabled ? 0.9 : 1, enabled ? 0.9 : 1, 1);
  }
  UI_SetProperty ("marker_inventory", "marker.area_width", enabled ? 682.0 : 385.0);
  UI_SetProperty ("textbox_3", "position.x", enabled ? -0.02 : -0.036);
  UI_SetProperty ("aligner_inventory_slots", "position.x", enabled ? -1.0 : -0.94);
  foreach (i in [0,1,2,3,4]) {
    UI_SetProperty ("marker_title_holder_" + i.tostring(), "marker.area_width", enabled ? (i == 4 ? 1.0 : 305.0) : 19.0);
  }
  foreach (i in [0,1,2,3,5]) {
    UI_SetProperty ("category_title_" + i.tostring(), "position.x", enabled ? (i == 3 ? 316.0 : 0.535) : 1.1);
  }
}


function Mod_MoreItemSlots_OnScreenMessage_PauseMenu (key, value) {
  if (key == "mod_more_item_slots_ui_update") {
    Mod_MoreItemSlots_OnEnter_PauseMenu();
  }
}


function Mod_MoreItemSlots_OnEnter_QuickSwapActiveItems() {
  local enabled = Game_IsRecipeCrafted ("MOD_MORE_ITEM_SLOTS") == true;
  UI_SetVisible ("InventorySlot_TOOLS_4", enabled);
  UI_SetVisible ("InventorySlot_TOOLS_5", enabled);
  UI_SetVisible ("InventorySlot_SPECIALS_5", enabled);
  UI_SetProperty ("panel", "ninepatch.rectangle_width", enabled ? 450.0 : 360.0);
}


function Mod_MoreItemSlots_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_more_item_slots_enabled":
        local enabled = UI_GetProperty ("mod_more_item_slots_enabled", "checkbox.value") == 1 ? true : false;
        Game_CheatCraftOrUncraftRecipe ("MOD_MORE_ITEM_SLOTS", enabled);
        UI_SetVisible ("mod_more_item_slots_enabled_warning", ! enabled);
        UI_SendScreenMessage ("PauseMenu", "mod_more_item_slots_ui_update", "1");
        break;
      case "mod_more_item_slots_enabled_title":
        Mods_Info_Popup (
            LocalizeText("More item slots"),
            LocalizeText("Carry +2 weapons, +5 trinkets, and +9 pets, additional slots open in your inventory. You also get +1 special after you crafted the Special Item Slot."));
        break;
    }
  }
}


function Mod_MoreItemSlots_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_more_item_slots_enabled", "checkbox.value", Game_IsRecipeCrafted ("MOD_MORE_ITEM_SLOTS") == true ? 1 : 0);
  UI_SetProperty ("mod_more_item_slots_enabled_title", "textbox.text", LocalizeText("More item slots"));
  UI_SetProperty ("mod_more_item_slots_enabled_warning", "textbox.text", LocalizeText("Do not forget to remove items from the disabled slots!"));
  UI_SetVisible ("mod_more_item_slots_enabled_warning", false);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
