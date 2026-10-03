quest <- {
  category =    "TEMPORAL_CHALLENGE"
  name =        "Fast Basketball"
  description = "Clear the basketball field from enemies in 60 seconds."
  description_when_completed = "The basketball court is quiet once more."
  image =       "quests/gfx/header-default.png"
  time_limit =  60.0

  requirements = {
    xp_level = 5
  }

  phases = [
    {
      id = "PHASE_0"
      reward_xp = 3000
      goals = [
        {
          id = "KILL"
          description = "Kill [VAR.required_amount] ex-humans."
          actor_type_id_0 = "actors/enemies/ex-human-female-melee.xml"
          actor_type_id_1 = "actors/enemies/ex-human-male-melee.xml"
          required_amount = 5

          function OnInitialize()
          {
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            SetCurrentPhaseGoalCompletedById(id);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
          }

// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
          function OnUpdate (tdelta) {
            SetCurrentPhaseGoalCompletedById (id);
          }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

          function OnActorStartDying(actor)
          {
            if (!StageObject_HasTag(actor, "QUEST_TARGET"))
              return;

            local destroyed_actor_type = Actor_GetActorType(actor);
            if (destroyed_actor_type == this.actor_type_id_0 ||
              destroyed_actor_type == this.actor_type_id_1)
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
