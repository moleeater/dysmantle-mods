quest <- {
  category =    "TEMPORAL_CHALLENGE"
  name =        "Wolves hunt in packs"
  description = "Hungry howls echo in the freezing wind. The howls are getting closer."
  description_when_completed = "The last whimper dies out and silence follows."
  image =       "quests/gfx/header-default.png"
  time_limit =  65.0

  requirements = {
    xp_level = 8
  }

  phases = [
    {
      id = "PHASE_0"
      reward_xp = 5000
      goals = [
        {
          id = "KILL"
          description = "Kill [VAR.required_amount] wolves"
          actor_type_id_0 = "actors/enemies/ex-animal-wolf.xml"
          required_amount = 4

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
