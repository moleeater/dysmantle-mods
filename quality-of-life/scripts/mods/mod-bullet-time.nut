// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local number_of_uses = 6;
local slowdown_base = 1.6;
local slowdown_upgrade = 0.12;
local base_seconds = 1.0;
local upgrade_seconds = 0.2;
local notification_duration = 5.0;
local notification_delay = 0.5;
local player = null;
local item_id = "";


Include ("scripts/mods/mods-info.nut");


function Mod_BulletTime_OnMetadataRead_Item() {
  return {
      icon = "items/specials/mod-bullet-time.png"
      name = "Bullet time |img src='emojis/package.png' scale=1.3 offset=2|"
      description = "|img src='emojis/package.png' scale=0.7 offset=2| Time moves slower, you move the same speed."
      use_description = "Click button for bullet time."
      destroy_after_owner_death = true
      number_of_uses = number_of_uses
    };
}


function Mod_BulletTime_SetTemporaryModifiers (time = 0.0, slowdown = 1.0) {
  local time_modifier_percentage_increase = time == 0.0 ? 0.0 : 100.0 / slowdown.tofloat() - 100.0;
  local move_speed_percentage_increase = time == 0.0 ? 0.0 : 100.0 * slowdown.tofloat() - 100.0;
  local melee_attack_delay_percentage_decrease = time == 0.0 ? 0.0 : 100.0 - 100.0 / slowdown.tofloat();
  local melee_attack_speed_percentage_increase = time == 0.0 ? 0.0 : 100.0 * slowdown.tofloat() - 100.0;
  if (time != 0.0) {
    time = time.tofloat() / slowdown.tofloat();
  }
  foreach (player_index in [0,1]) {
    local player = Game_GetPlayerActor (player_index);
    if (player != null) {
      Game_SetTemporaryModifier (player, "mod_bullet_time", time, "time_modifier_percentage_increase", time_modifier_percentage_increase);
      Game_SetTemporaryModifier (player, "mod_bullet_time", time, "move_speed_percentage_increase", move_speed_percentage_increase);
      Game_SetTemporaryModifier (player, "mod_bullet_time", time, "melee_attack_delay_percentage_decrease", melee_attack_delay_percentage_decrease);
      Game_SetTemporaryModifier (player, "mod_bullet_time", time, "melee_attack_speed_percentage_increase", melee_attack_speed_percentage_increase);
    }
  }
}


function Mod_BulletTime_OnTriggerDown_Item() {
  local global_kvs = Game_GetGlobalKeyValueStore ("MODS");
  KeyValueStore_SetKeyValueBoolean (global_kvs, "mod_bullet_time_used", true);
  local crates_opened = Game_GetMedalProgressAmount ("TIMED_CRATES_OPENED");
  if (crates_opened == null) crates_opened = 0;
  Mod_BulletTime_SetTemporaryModifiers (base_seconds.tofloat() + upgrade_seconds.tofloat() * crates_opened.tofloat(), slowdown_base.tofloat() + slowdown_upgrade.tofloat() * crates_opened.tofloat());
  Game_UseItem (player, item_id);
}


function Mod_BulletTime_OnTriggerCancel_Item() {
  Mod_BulletTime_SetTemporaryModifiers();
}


function Mod_BulletTime_OnInitialize_Item (so_handle_owner, id) {
  player = so_handle_owner;
  item_id = id;
  return true;
}


function Mod_BulletTime_PressButtonUse_TimedCrate (crate, player) {
  local global_kvs = Game_GetGlobalKeyValueStore ("MODS");
  if (KeyValueStore_GetKeyValue (global_kvs, "mod_bullet_time_used", false) == true) {
    Actor_PlayAnimation (crate, "locked");
    Game_AddFloaterNotification (crate, "|img src='mods/mod-bullet-time.png' scale=0.65||img src='emojis/cross mark.png'|", notification_duration, notification_delay);
    return true;
  }
}


function Mod_BulletTime_OnEnter_Campfire() {
  local global_kvs = Game_GetGlobalKeyValueStore ("MODS");
  KeyValueStore_SetKeyValueBoolean (global_kvs, "mod_bullet_time_used", false);
}


function Mod_BulletTime_OnRespawnedAfterDeath_ProtagonistReactions (player, num_times_died) {
  local global_kvs = Game_GetGlobalKeyValueStore ("MODS");
  KeyValueStore_SetKeyValueBoolean (global_kvs, "mod_bullet_time_used", false);
}


function Mod_BulletTime_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_bullet_time_craft":
        if (Game_IsRecipeCrafted ("MOD_BULLET_TIME") != true) {
          Game_CraftRecipe ("MOD_BULLET_TIME", true);
        }
        UI_SetProperty ("mod_bullet_time_craft", "active", false);
        break;
      case "mod_bullet_time_title":
        Mods_Info_Popup (
            LocalizeText("Bullet time"),
            LocalizeText("Activate bullet time, helpful in combat and for tomb puzzles. Duration and slowdown depends on how many Timed Crates you've opened."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-bullet-time-video")}] );
        break;
    }
  }
}


function Mod_BulletTime_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_bullet_time_craft", "active", Game_IsRecipeCrafted ("MOD_BULLET_TIME") == true ? false : true);
  UI_SetProperty ("mod_bullet_time_craft", "button.text", LocalizeText("Craft"));
  UI_SetProperty ("mod_bullet_time_title", "textbox.text", LocalizeText("Bullet time"));
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
