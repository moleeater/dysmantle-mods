quest <- {
  category =    "TEMPORAL_CHALLENGE"
  name =        "Spirit Trouble"
  description = "Destroy 4 Mana Spirits while inside an active Mana Chamber."
  description_when_completed = "The mana spirits are gone for now. But what they are is still a mystery."
    image =       "quests/gfx/header-dlc1.png"
  time_limit =  60.0
  requires_iap = "DLC1"

  requirements = {
    xp_level = 16
  }

  phases = [
    {
      id = "PHASE_0"
      reward_xp = 15000
      goals = [
        {
          id = "KILL"
          description = "Destroy [VAR.required_amount] Mana Spirits in active Mana Chamber"
          actor_type_id_0 = "actors/enemies/mana-spirit.xml"
          required_amount = 4

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
            if (!StageObject_HasTag(actor, "INSIDE_MANA_CHAMBER"))
              return;

            local destroyed_actor_type = Actor_GetActorType(actor);
            
            if (destroyed_actor_type == this.actor_type_id_0)
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
