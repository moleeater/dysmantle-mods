// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local cooldown_realseconds = 3.0;
local base_damage = 1.0;
local upgrade_damage = 1.9;
local last_realseconds = null;


Include ("scripts/mods/mods-info.nut");


function Mod_RollAttack_OnCollision_Creature (actor1, actor2) {
  if (Game_IsCinemaModeEnabled() != true && Game_GetWorldStateAsInteger ("MODS", "roll_attack_enabled", 0) == 1) {
    local player = null;
    local enemy = null;
    if (StageObject_HasTag (actor1, "PLAYER") == true && StageObject_HasTag (actor2, "PLAYER") != true) {
      player = actor1;
      enemy = actor2;
    } else if (StageObject_HasTag (actor2, "PLAYER") == true && StageObject_HasTag (actor1, "PLAYER") != true) {
      player = actor2;
      enemy = actor1;
    }
    if (player != null && enemy != null
    && Game_GetCurrentAction (player) == "DodgeAction"
    && StageObject_HasTag (enemy, "TAMED") != true
    && StageObject_GetKeyValue (enemy, "vulnerability_timer", 10.0) > 0.1) {
      local now = NX_GetTimeSecondsElapsedSinceEpoch();
      if (last_realseconds == null || last_realseconds < now - cooldown_realseconds) {
        last_realseconds = now;
        local modifiers_kvs = Game_GetAllPlayerModifiersAsKeyValueStore (player);
        local dodge_roll_speed_percentage_increase = 0.0;
        if (modifiers_kvs != null) {
          dodge_roll_speed_percentage_increase = KeyValueStore_GetKeyValue (modifiers_kvs, "dodge_roll_speed_percentage_increase");
          if (dodge_roll_speed_percentage_increase == null) dodge_roll_speed_percentage_increase = 0.0;
        }
        Stage_DealDamage (player, enemy, base_damage.tofloat() + dodge_roll_speed_percentage_increase.tofloat() * upgrade_damage.tofloat(), "BLUNT");
      }
    }
  }
}


function Mod_RollAttack_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_roll_attack_enabled":
        Game_SetWorldState ("MODS", "roll_attack_enabled", UI_GetProperty ("mod_roll_attack_enabled", "checkbox.value") == 1 ? "1" : "0");
        break;
      case "mod_roll_attack_enabled_title":
        Mods_Info_Popup (
            LocalizeText("Roll attack"),
            LocalizeText("Dodge roll attack enemies to damage them by 1-99 HP, depending on your Dodge Roll Speed. Their health bar will not update."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-roll-attack-video")}] );
        break;
    }
  }
}


function Mod_RollAttack_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_roll_attack_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "roll_attack_enabled", 0));
  UI_SetProperty ("mod_roll_attack_enabled_title", "textbox.text", LocalizeText("Roll attack"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
