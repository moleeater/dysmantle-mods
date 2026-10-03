// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local warning_clearance = 120.0;
local slowdown_rate = 2.5;
local slowdown_duration = 2.0;


Include ("scripts/mods/mods-info.nut");


function Mod_TrapWarning_OnGameStart_TrapPit (trappit, same) {
  if (Game_GetWorldStateAsInteger ("MODS", "trap_warning_enabled", 0) == 1 || Game_GetWorldStateAsInteger ("MODS", "traps_on_minimap_enabled", 0) == 1) {
    Game_RevealActorOnMap (trappit);
    Game_SetWorldState ("MODS", "trap_warning_enabled", "1");
  }
}


function Mod_TrapWarning_OnActorEntersRadius_TrapPit (trappit, player) {
  if (Game_IsCinemaModeEnabled() != true && StageObject_HasTag (player, "PLAYER") == true
  && (Game_GetWorldStateAsInteger ("MODS", "trap_warning_enabled", 0) == 1 || Game_GetWorldStateAsInteger ("MODS", "traps_on_minimap_enabled", 0) == 1)) {
    local position = StageObject_GetStagePosition (player);
    if (position != null) {
      Stage_SpawnEffect ("effects/mods/mod-trap-warning.xml", position[0], position[1], position[2] - warning_clearance, 0.0);
      local modifiers_kvs = Game_GetAllPlayerModifiersAsKeyValueStore (player);
      if (modifiers_kvs != null) {
        local time_modifier_percentage_increase = KeyValueStore_GetKeyValue (modifiers_kvs, "time_modifier_percentage_increase");
        if (time_modifier_percentage_increase == null) time_modifier_percentage_increase = 0.0;
        local stage_time_multiplier = (time_modifier_percentage_increase.tofloat() + 100.0) / 100.0;
        local new_stage_time_multiplier = stage_time_multiplier.tofloat() / slowdown_rate.tofloat();
        local new_time_modifier_percentage_increase = new_stage_time_multiplier.tofloat() * 100.0 - 100.0 - time_modifier_percentage_increase.tofloat();
        Game_SetTemporaryModifier (player, "mod_trap_warning", slowdown_duration.tofloat() * new_stage_time_multiplier.tofloat(), "time_modifier_percentage_increase", new_time_modifier_percentage_increase);
      }
    }
  }
}


function Mod_TrapWarning_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_trap_warning_enabled":
        local enabled = UI_GetProperty ("mod_trap_warning_enabled", "checkbox.value") == 1;
        Game_SetWorldState ("MODS", "trap_warning_enabled", enabled ? "1" : "0");
        if (! enabled) {
          Game_SetWorldState ("MODS", "traps_on_minimap_enabled", "0");
        } else {
          local trappits = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, "MOD_TRAP_WARNING");
          if (trappits != null && trappits.len() > 0) {
            foreach (trappit in trappits) {
              Game_RevealActorOnMap (trappit);
            }
          }
        }
        break;
      case "mod_trap_warning_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Trap warning"),
            LocalizeText("Get a warning when you get close to a spikey pit trap.")
                + "\n" + LocalizeText("Reveal spikey pit traps on the minimap."));
        break;
    }
  }
}


function Mod_TrapWarning_OnEnter_OptionsUnified (stage_in_stack) {
  local enabled = Game_GetWorldStateAsInteger ("MODS", "trap_warning_enabled", 0) == 1 || Game_GetWorldStateAsInteger ("MODS", "traps_on_minimap_enabled", 0) == 1;
  UI_SetProperty ("mod_trap_warning_enabled", "checkbox.value", enabled ? 1 : 0);
  UI_SetProperty ("mod_trap_warning_enabled_title", "textbox.text", LocalizeText("Trap warning"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
