quest <- {
  category =    "TEMPORAL_CHALLENGE"
  name =        "Haymaker"
  description = "The field is infested with ex-humans. It is time to turn them into fertiliser."
  description_when_completed = "Nature will take care of this problem now."
  image =       "quests/gfx/header-default.png"
  time_limit =  75.0

  requirements = {
    xp_level = 5
  }

  phases = [
    {
      id = "PHASE_0"
      reward_xp = 5000
      goals = [
        {
          id = "KILL"
          description = "Kill [VAR.required_amount] ex-humans."
          actor_type_id_0 = "actors/enemies/ex-human-female-melee.xml"
          actor_type_id_1 = "actors/enemies/ex-human-male-melee.xml"
          actor_type_id_2 = "actors/enemies/ex-human-puker.xml"
          required_amount = 6

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
