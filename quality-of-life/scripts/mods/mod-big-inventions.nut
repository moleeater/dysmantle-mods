// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_BigInventions_OnEnter_Invent() {
  local nodes_count = DM_GetArrayNumberOfNodes ("ui/Invent.xml", "COMPONENTS");
  if (nodes_count != null && nodes_count > 0) {
    for (local node_index = 0; node_index < nodes_count; node_index++) {
      local name = DM_GetArrayNodeValue ("ui/Invent.xml", "COMPONENTS", node_index, "name");
      if (name != null && name.len() > 7 && name.slice(0,7) == "Recipe_") {
        UI_SetProperty (name, "ui_scale_modifier", 0.0);
        UI_SetProperty (name, "scale", 1.32);
      }
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
