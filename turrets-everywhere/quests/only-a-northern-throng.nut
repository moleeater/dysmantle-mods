quest <- {
  category =    "TEMPORAL_CHALLENGE"
  name =        "Only a Northern Throng"
  description = "The rocky passage you are traversing seems suspiciously quiet. The perfect place for an ambush."
  description_when_completed = "There is blood on the snow, luckily it is not yours."
  image =       "quests/gfx/header-default.png"
  time_limit =  75.0

  requirements = {
    xp_level = 10
  }

  phases = [
    {
      id = "PHASE_0"
      reward_xp = 5000
      goals = [
        {
          id = "KILL"
          description = "Kill all [VAR.required_amount] ambushers!"
          actor_type_id_0 = "actors/enemies/ex-human-fast-chaser.xml"
          actor_type_id_1 = "actors/enemies/ex-human-male-melee.xml"
          required_amount = 5

          function OnInitialize()
          {
          }

          function OnActorStartDying(actor)
          {
            if (!StageObject_HasTag(actor, "QUEST_TARGET"))
              return;

            local destroyed_actor_type = Actor_GetActorType(actor);
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            if (destroyed_actor_type.slice(0,15) == "actors/enemies/")
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            {
              local num = GetPersistentInteger("num_destroyed", 0) + 1;
              SetPersistentInteger("num_destroyed", num);
              if (num >= this.required_amount)
                SetCurrentPhaseGoalCompletedById(id);
            }
          }

          function GetProgressText()
          {
            local num = GetPersistentInteger("num_destroyed", 0);
            return num + "/" + this.required_amount;
          }
        }
        {
          id = "TIME"
          description = "Finish in [VAR.temporal_challenge_time_limit] seconds."
          time_limited = true
        }
      ]
    }
  ]
}
