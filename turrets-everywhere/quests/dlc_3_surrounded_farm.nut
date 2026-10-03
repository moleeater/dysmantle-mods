quest <- {
  category =    "TEMPORAL_CHALLENGE"
  name =        "Surrounded Farm"
  description = "Clear the farm from of a nasty pack of wolfies in 60 seconds."
  description_when_completed = "The farm is quiet once more. But where did those wolves come from? There is still something going on in this place." 
  image =       "quests/gfx/header-dlc3.png"
  requires_iap = "DLC3"
  time_limit =  60.0

  requirements = {
    xp_level = 5
  }

  phases = [
    {
      id = "PHASE_0"
      reward_xp = 10000
      goals = [
        {
          id = "KILL"
          description = "[GREEN]Kill[DEFAULT] [VAR.required_amount] nasty wolves."
          actor_type_id_0 = "actors/enemies/DLC3-boss-alpha-wolf.xml"
          actor_type_id_1 = "actors/enemies/ex-animal-wolf.xml"
          required_amount = 7

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
              
              if (num >= this.required_amount){                
              
                SetCurrentPhaseGoalCompletedById(id);

              }
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
