// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_ArkSingleDeposit_GetAmountToDeposit_ArkMaterialContainer (container, material_id) {
  local num_deposited = Game_GetWorldStateAsInteger ("ARK_MATERIALS", material_id, 0);
  local num_required = StageObject_GetKeyValue (container, "required_amount", 0);
  local num_to_deposit = num_required - num_deposited;
  return Game_GetNumberOfMaterialsStoragePlusCarried (material_id) >= num_to_deposit ? num_to_deposit : null;
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
