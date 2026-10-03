// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-electrifying-grenade.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function OnGameStart(so_actor)
{
  StageObject_SetKeyValueFloat(so_actor, "timer", 0);
}

function OnThink(so_actor, tdelta)
{
  local timer = StageObject_GetKeyValue(so_actor, "timer");
  if (timer == null)
  {
    StageObject_SetKeyValueFloat(so_actor, "timer", 0);
    return;
  }
  timer += tdelta;
  StageObject_SetKeyValueFloat(so_actor, "timer", timer);

  if (timer >= StageObject_GetKeyValue(so_actor, "explosion_delay"))
  {
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    if (this.rawin ("Mod_ElectrifyingGrenade_OnThink_ElectricGrenade") == true) Mod_ElectrifyingGrenade_OnThink_ElectricGrenade (so_actor, tdelta);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    Stage_SendStageObjectCommandWord(so_actor, "self_destruct");
    //Stage_KillActorAndStartDeathAnimation(so_actor);
  }
}
