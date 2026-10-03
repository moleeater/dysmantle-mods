quest <- {
  category =    "TEMPORAL_CHALLENGE"
  name =        "The Fangman Cometh"
  item_id = "items/trinkets/dentured-fangs.nut"
  description = "The village you have entered seems quiet. Perhaps this would be a good place to test out those [RED][ITEM_NAME=[VAR.item_id]][WHITE] you have crafted."
  description_when_completed = "A moment of clarity follows after the bloodlust subsides. Was that really necessary?"
  image =       "quests/gfx/header-default.png"
  time_limit =  65

  requirements = {
    crafted_recipes="DENTURED_FANGS"
    xp_level = 25
  }

  phases = [
    {
      id = "PHASE_0"
      reward_xp = 40000
      goals = [
        {
          id = "EQUIPPED_ITEM"
          description = "Have [RED][ITEM_NAME=[VAR.item_id]][WHITE] equipped."
          item_id = "items/trinkets/dentured-fangs.nut"

          function OnUpdate(tdelta)
          {
            local player = Game_GetPrimaryPlayerActor();
            if (!Game_IsItemEquipped(player, item_id))
            {
              SetQuestFailed();
            }
          }
        }
        {
          id = "KILL"
          description = "Kill [VAR.required_amount] ex-humans."
          actor_type_id_0 = "actors/enemies/ex-human-female-melee.xml"
          actor_type_id_1 = "actors/enemies/ex-human-male-melee.xml"
          actor_type_id_2 = "actors/enemies/ex-human-puker.xml"
          actor_type_id_3 = "actors/enemies/ex-human-fast-chaser.xml"
          required_amount = 11

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

          function OnCompleted()
          {
            SetCurrentPhaseGoalCompletedById("EQUIPPED_ITEM");
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
