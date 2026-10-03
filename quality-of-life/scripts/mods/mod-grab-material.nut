// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_GrabMaterial_PressButtonIsInteractionAvailable_Material (material, player) {
  local is_available = false;
  local material_id = StageObject_GetKeyValue (material, "material_id");
  if (material_id != null && Profile_GetValue ("PLAYER_STATE", "material_autocollect", material_id) == "0") {
    is_available = true;
    Actor_SetInteractionText (material, "mod_grab_material_on_press_button_use_material", LocalizeText("Pick Up"));
  }
  return is_available;
}


function Mod_GrabMaterial_PressButton_Material (material, player) {
  Game_CollectMaterial (material, player);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
