// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local mods_include_path = "";
mods_include_path = "scripts/mods/mod-ignore-death-counter.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


function OnInteraction(so_self, so_activator)
{
    Actor_PlayAnimation(so_self,"open");
    Actor_ClearActionQueue(so_activator);
    Actor_QueueActionWait(so_activator, 0.5);

    if (StageObject_GetKeyValue(so_self, "looted_corpse"))
        return;

    StageObject_SetKeyValueBoolean(so_self, "looted_corpse", true);

// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    local num_times_died = Game_GetNumberOfTimesDied();
    if (this.rawin ("Mod_IgnoreDeathCounter_HoldDownButton_PyramidTombKingSarcophage") == true) {
      local ret = Mod_IgnoreDeathCounter_HoldDownButton_PyramidTombKingSarcophage (so_self, so_activator);
      if (ret != null) num_times_died = ret;
    }
    if (num_times_died == 0) {
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        local pos = StageObject_GetPositionWithOffset(so_self, 0, 0, -5);
        local so_body = Stage_CreateActor("actors/players/dead-body.xml", pos[0], pos[1], pos[2]);
        local angle = StageObject_GetAngle(so_self);
        StageObject_SetScale(so_body, 0.98);
        StageObject_SetAngle(so_body, angle);
        Actor_PlayAnimation(so_body, "death_pose_sarcophage");
        StageObject_SetKeyValueBoolean(so_body, "pyramid_tomb", true);

        local create_key = true;
        if (create_key)
        {
            local pos = StageObject_GetPositionWithOffset(so_self, 0, 0, -45);
            local so = Game_CreateKeyActor(pos[0], pos[1], pos[2], "SURREAL_KEY");
            Actor_SetLinearVelocity(so, 0, 300, -600);
        }
        Game_AddActorNotificationWithDelay(so_activator, LOC_TEXT("There it is..."), 0.5);
    }
    else
    {
        Game_AddActorNotificationWithDelay(so_activator, LOC_TEXT("Empty! Maybe I should have came here sooner... [EMOJI=thinking face]"), 0.5);
    }
}
