const RADIUS = 65;
const KNOCKBACK_STRENGTH = 800;


// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-hide-corpses.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


local timer = 0;


// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function OnGameStart (spikeball) {
  if (this.rawin ("Mod_HideCorpses_OnGameStart_Creature") == true) Mod_HideCorpses_OnGameStart_Creature (spikeball);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function OnThink(so_actor, tdelta)
{
  timer += tdelta;
  if (timer > 0.1)
  {
    local enemies = Game_GetEnemiesInCone(so_actor, 0, 360, RADIUS);
    if (enemies != null)
    {
      local anim = Game_PlayAnimationByAction(so_actor, "attack");
      local duration = anim[1];
      timer = -duration;
    }
    else
    {
      timer = 0;
    }
  }
}

function OnCommandWord(so_actor, command_word)
{
  if (command_word == "fire_weapon")
  {
    local enemies = Game_GetEnemiesInCone(so_actor, 0, 360, RADIUS);
    if (enemies != null)
    {
      local pos = StageObject_GetPosition(so_actor);
      local damage = Actor_GetAttributeDamage(so_actor);
      local damage_type = Actor_GetAttributeDamageType(so_actor);

      foreach (enemy in enemies)
      {
        local kvs = Game_GetAllPlayerModifiersAsKeyValueStore(enemy);
        local tags = kvs == null ? null : KeyValueStore_GetKeyValue(kvs, "tags");

        if (tags != null && Tags_ContainsTag(tags, "BARBED_IMMUNITY"))
          Stage_DealDamage(so_actor, enemy, damage * 0.25, damage_type);
        else
          Stage_DealDamage(so_actor, enemy, damage, damage_type);

        local enemy_pos = StageObject_GetPosition(enemy);
        local v = [enemy_pos[0] - pos[0], enemy_pos[1] - pos[1]];
        local d = sqrt(v[0] * v[0] + v[1] * v[1]);
        if (d > 0)
        {
          v[0] = KNOCKBACK_STRENGTH * (v[0] / d);
          v[1] = KNOCKBACK_STRENGTH * (v[1] / d);
          Actor_SetLinearVelocity(enemy, v[0], v[1], 0);
        }
      }
    }
  }
}
