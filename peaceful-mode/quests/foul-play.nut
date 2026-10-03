quest <- {
  category =    "TEMPORAL_CHALLENGE"
  name =        "Foul Play"
  description = "You were always more of a baseball fan than a football fan. Put on your fan gear and play ball."
  description_when_completed = "It is the ninth inning and all bases are full of bodies."
  image =       "quests/gfx/header-default.png"
  time_limit =  80

  requirements = {
    crafted_recipes="BASEBALL_BAT,BASEBALL_CARD,BASEBALL_CAP"
    xp_level = 25
  }

  phases = [
    {
      id = "PHASE_0"
      reward_xp = 44000
      goals = [
        {
          id = "EQUIPPED_ITEM_1"
          description = "Have the [RED][ITEM_NAME=[VAR.item_id]][WHITE] equipped."
          item_id = "items/tools/baseball-bat.nut"
        }
        {
          id = "EQUIPPED_ITEM_2"
          description = "Have the [RED][ITEM_NAME=[VAR.item_id]][WHITE] equipped."
          item_id = "items/headgears/baseball-cap.nut"
        }
        {
          id = "EQUIPPED_ITEM_3"
          description = "Have the [RED][ITEM_NAME=[VAR.item_id]][WHITE] equipped."
          item_id = "items/trinkets/baseball-card.nut"
        }
        {
          id = "KILL"
          description = "Kill [VAR.required_amount] ex-humans."
          actor_type_id_0 = "actors/enemies/ex-human-female-melee.xml"
          actor_type_id_1 = "actors/enemies/ex-human-male-melee.xml"
          actor_type_id_2 = "actors/enemies/ex-human-puker.xml"
          actor_type_id_3 = "actors/enemies/ex-human-fast-chaser.xml"
          actor_type_id_4 = "actors/enemies/ex-human-male-melee-advanced-xml"
          required_amount = 12

// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
          function OnInitialize()
          {
            local player = Game_GetPrimaryPlayerActor();
            for (local goal_index = 0; goal_index < 3; goal_index++)
            {
              if (!Game_IsItemEquipped(player, quest.phases[0].goals[goal_index].item_id))
              {
                SetQuestFailed();
                return;
              }
              else if (!quest.phases[0].goals[goal_index].completed)
              {
                SetCurrentPhaseGoalCompleted(goal_index);
              }
            }
            SetCurrentPhaseGoalCompletedById(id);
          }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
              destroyed_actor_type == this.actor_type_id_1 ||
              destroyed_actor_type == this.actor_type_id_2 ||
              destroyed_actor_type == this.actor_type_id_3 ||
              destroyed_actor_type == this.actor_type_id_4)
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
            SetCurrentPhaseGoalCompletedById("EQUIPPED_ITEM_1");
            SetCurrentPhaseGoalCompletedById("EQUIPPED_ITEM_2");
            SetCurrentPhaseGoalCompletedById("EQUIPPED_ITEM_3");
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

function OnUpdate(tdelta)
{
  local player = Game_GetPrimaryPlayerActor();

  for (local goal_index = 0; goal_index < 3; goal_index++)
  {
    if (!Game_IsItemEquipped(player, quest.phases[0].goals[goal_index].item_id))
    {
      SetQuestFailed();
      return;
    }
    else if (!quest.phases[0].goals[goal_index].completed)
    {
      SetCurrentPhaseGoalCompleted(goal_index);
    }
  }
}
