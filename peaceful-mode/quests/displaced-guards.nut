quest <- {
  category =    "TEMPORAL_CHALLENGE"
  name =        "Displaced"
  description = "The base was used for studying some strange structure and something went clearly wrong. Acquire a [GREEN]Digital Wrist Watch[WHITE] and investigate the structure."
  description_when_completed = "The old monsters who attacked the base are now dead. However, the rift is still active and its effects are affecting the world around it."
  image =       "quests/gfx/header-default.png"
  time_limit =  140

  requirements = {
    crafted_recipes = "DIGITAL_WRIST_WATCH"
    xp_level = 30
  }

  phases = [
    {
    id = "PHASE_ENTER_STRUCTURE"
    //reward_xp = 10000
    goals = [

        {
          id = "EQUIPPED_ITEM"
          description = "Have the [RED][ITEM_NAME=[VAR.item_id]][WHITE] equipped."
          item_id = "items/trinkets/digital-wrist-watch.nut"

          function OnUpdate(tdelta)
          {      
          }

        },
        {
          id = "GOAL_ENTER_STRUCTURE"
          description = "Enter the structure."
          quest_marker_stage_object_id = "quest_displaced_warp"


           // Player enters the structure
                    function OnCommandWord(command_word)
                    {
                        if (command_word == "activate")
                        {
                            SetCurrentPhaseGoalCompletedById(id);
                        }
                    }
          
        },
        {
          id = "TIME"
          description = "Finish in [VAR.temporal_challenge_time_limit] seconds."
          time_limited = true
        }


    ]

    },
    {
      id = "PHASE_FIRST_WAVE"
      //reward_xp = 10000
      goals = [
        {
          id = "EQUIPPED_ITEM"
          description = "Have the [RED][ITEM_NAME=[VAR.item_id]][WHITE] equipped."
          item_id = "items/trinkets/digital-wrist-watch.nut"

          function OnUpdate(tdelta)
          {
          }

        },
        {
          id = "GOAL_KILL_ENEMIES"
          required_amount = 3
          description = "Kill the [VAR.required_amount] Tomb Guards."
          actor_type_id_0 = "actors/enemies/tomb-guard.xml"
          //actor_type_id_1 = "actors/enemies/tomb-guard-elite.xml"  


// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
          function OnInitialize()
          {
            local player = Game_GetPrimaryPlayerActor();
            if (!Game_IsItemEquipped(player, quest.phases[0].goals[0].item_id))
            {
              SetQuestFailed();
            }
            else
            {
              SetCurrentPhaseGoalCompletedById(id);
            }
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
            if (destroyed_actor_type == this.actor_type_id_0 /*||  destroyed_actor_type == this.actor_type_id_1 */)
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

      function OnPhaseCompleted()
      {
        WarpToPos("warp_pos_0");
      }
    },
    {
      id = "PHASE_SECOND_WAVE"
      //reward_xp = 10000
      goals = [
        {
          id = "EQUIPPED_ITEM"
          description = "Have the [RED][ITEM_NAME=[VAR.item_id]][WHITE] equipped."
          item_id = "items/trinkets/digital-wrist-watch.nut"

          function OnUpdate(tdelta)
          {
          }

        },
        {
          id = "GOAL_KILL_ENEMIES"
          required_amount = 2
          description = "Kill the [VAR.required_amount] Tomb Guards."
          actor_type_id_0 = "actors/enemies/tomb-guard.xml"
          //actor_type_id_1 = "actors/enemies/tomb-guard-elite.xml"  

          function OnInitialize()
          {
            SetPersistentInteger("num_destroyed", 0);
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            local player = Game_GetPrimaryPlayerActor();
            if (!Game_IsItemEquipped(player, quest.phases[0].goals[0].item_id))
            {
              SetQuestFailed();
            }
            else
            {
              SetCurrentPhaseGoalCompletedById(id);
            }
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
            if (destroyed_actor_type == this.actor_type_id_0 /*||  destroyed_actor_type == this.actor_type_id_1 */)
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

      function OnPhaseCompleted()
      {
        WarpToPos("warp_pos_1");
      }
    },
    {
      id = "PHASE_THIRD_WAVE"
      //reward_xp = 10000
      goals = [
        {
          id = "EQUIPPED_ITEM"
          description = "Have the [RED][ITEM_NAME=[VAR.item_id]][WHITE] equipped."
          item_id = "items/trinkets/digital-wrist-watch.nut"

          function OnUpdate(tdelta)
          {
          }

        },
        {
          id = "GOAL_KILL_ENEMIES"
          required_amount = 2
          description = "Kill the [VAR.required_amount] Tomb Guards."
          actor_type_id_0 = "actors/enemies/tomb-guard.xml"
          //actor_type_id_1 = "actors/enemies/tomb-guard-elite.xml"  


          function OnInitialize()
          {
            SetPersistentInteger("num_destroyed", 0);
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            local player = Game_GetPrimaryPlayerActor();
            if (!Game_IsItemEquipped(player, quest.phases[0].goals[0].item_id))
            {
              SetQuestFailed();
            }
            else
            {
              SetCurrentPhaseGoalCompletedById(id);
            }
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
            if (destroyed_actor_type == this.actor_type_id_0 /*||  destroyed_actor_type == this.actor_type_id_1 */)
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

      function OnPhaseCompleted()
      {
        
        WarpToPos("warp_pos_2");

        
        local so_player = Game_GetAnyPlayerActor();
        local remark = "I feel dizzy.";
        Game_AddActorNotificationWithDelay(so_player,remark,1.0);
      }
    },
    {
      id = "PHASE_FOURTH_WAVE"
      //reward_xp = 10000
      goals = [
        {
          id = "EQUIPPED_ITEM"
          description = "Have the [RED][ITEM_NAME=[VAR.item_id]][WHITE] equipped."
          item_id = "items/trinkets/digital-wrist-watch.nut"

          function OnUpdate(tdelta)
          {
          }

        },
        {
          id = "GOAL_KILL_ENEMIES"
          required_amount = 2
          description = "Kill the [VAR.required_amount] Tomb Guards."
          actor_type_id_0 = "actors/enemies/tomb-guard.xml"
          //actor_type_id_1 = "actors/enemies/tomb-guard-elite.xml"  


          function OnInitialize()
          {
            SetPersistentInteger("num_destroyed", 0);
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            local player = Game_GetPrimaryPlayerActor();
            if (!Game_IsItemEquipped(player, quest.phases[0].goals[0].item_id))
            {
              SetQuestFailed();
            }
            else
            {
              SetCurrentPhaseGoalCompletedById(id);
            }
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
            if (destroyed_actor_type == this.actor_type_id_0 /*||  destroyed_actor_type == this.actor_type_id_1 */)
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

      function OnPhaseCompleted()
      {
        WarpToPos("warp_pos_3");
      }
    },
    {  
      // LAST PHASE. IS DIFFERENT. DO NOT COPY
      id = "PHASE_FIFTH_WAVE"
      reward_xp = 35000
      reward_recipe_id = "RIFT_TOOLKIT"
      goals = [
        {
          id = "EQUIPPED_ITEM"
          description = "Have the [RED][ITEM_NAME=[VAR.item_id]][WHITE] equipped."
          item_id = "items/trinkets/digital-wrist-watch.nut"

          function OnUpdate(tdelta)
          {
          }

        },
        {
          id = "GOAL_KILL_ENEMIES"
          required_amount = 2
          description = "Kill the [VAR.required_amount] Tomb Guards."
          actor_type_id_0 = "actors/enemies/tomb-guard.xml"


          function OnInitialize()
          {
            SetPersistentInteger("num_destroyed", 0);
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            local player = Game_GetPrimaryPlayerActor();
            if (!Game_IsItemEquipped(player, quest.phases[0].goals[0].item_id))
            {
              SetQuestFailed();
            }
            else
            {
              SetCurrentPhaseGoalCompletedById(id);
            }
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
            if (destroyed_actor_type == this.actor_type_id_0 /*||  destroyed_actor_type == this.actor_type_id_1 */)
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

        },
        {
          id = "TIME"
          description = "Finish in [VAR.temporal_challenge_time_limit] seconds."
          time_limited = true
        }
      ]

      function OnPhaseCompleted()
      {
        // Last goal, return to quest start
        WarpToPos("warp_pos_home");

        local so_player = Game_GetAnyPlayerActor();
        local remark = "[EMOJI=face vomiting]";
        Game_AddActorNotificationWithDelay(so_player,remark,6.0)


        Game_SetWorldState("MANA_RIFTS", "enabled", "1");
      }
    }
    
  ]
}

function WarpToPos(kv_pos_id){

  local so_quest_trigger = StageObject_GetById("QUEST_DISPLACED_GUARDS");
  local kvs = StageObject_GetKeyValueStore(so_quest_trigger);
  local target_pos = KeyValueStore_GetKeyValue(kvs, kv_pos_id);
  Game_TeleportPlayers(target_pos[0], target_pos[1], target_pos[2]);
}

function OnUpdate(tdelta)
{
  local player = Game_GetPrimaryPlayerActor();
  
  if (!Game_IsItemEquipped(player, quest.phases[0].goals[0].item_id))
  {
    SetQuestFailed();
  }
  else{
    SetCurrentPhaseGoalCompleted(0);
  }
}

function OnPhaseCompleted(phase_index)
{
  if ("OnPhaseCompleted" in quest.phases[phase_index])
  {
    quest.phases[phase_index].OnPhaseCompleted();
  }
}
