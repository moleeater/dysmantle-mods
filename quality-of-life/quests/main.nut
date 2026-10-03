quest <- {
  category =    "MAIN_QUEST"
  name =        "Escape the Island"
  description = "Find the means of escaping this wretched place."
  description_when_completed = ""
  image =       "quests/gfx/header-suburb.png"

  phases = [
    {
      id = "GO_TO_EVACUATION_SITE"
      reward_xp = 1500
      goals = [
        {
          id = "GO"
          description = "Go to [LOCATION=EVACUATION_SITE] [GREEN]east[WHITE] of your shelter."
          quest_marker_stage_object_id = "EVACUATION_SITE_ENTRANCE"

          function OnCommandWord(command_word)
          {
            if (command_word == "activate")
            {
              SetCurrentPhaseGoalCompletedById(id);
            }
          }
        }
      ]
    }

    {
      id = "INVESTIGATE_EVACUATION_SITE"
      description = "Investigate the evacuation site."
      goals = [
        {
          id = "EXAMINE_GATE"
          description = "Investigate [LOCATION=EVACUATION_SITE]."
          quest_marker_stage_object_id = "EVACUATION_SITE_INNER_GATE"

          function OnCommandWord(command_word)
          {
            if (command_word == "activate")
            {
              SetCurrentPhaseGoalCompletedById(id);
            }
          }
        }
      ]
    }

    {
      id = "SCAN_FOR_RELAYS"
      description = "Get the gate open to gain access to the [ORANGE]Launchpads[WHITE]."
      reward_xp = 3000
      goals = [
        {
          id = "SCAN"
          description = "Open the Inner Gate at [LOCATION=EVACUATION_SITE]."
          quest_marker_stage_object_id = "evac_inner_gate_terminal"

          function OnInitialize()
          {
            if (Game_GetWorldState("MAIN_QUEST", "LINK_RELAYS_SCANNED") != null)
            {
              SetCurrentPhaseGoalCompletedById(id);
            }
          }

        }
      ]
    }

    {
      id = "ACTIVATE_RELAYS"
      description = "Link network needs to be online for the gate to open."
      reward_xp = 5000
      goals = [
        {
          id = "ACTIVATE_RELAY_2"
          quest_marker_stage_object_id = "LINK_RELAY_2"
          description = "The Fishing Relay"

          function OnCommandWord(command_word)
          {
            if (command_word == "activate")
              CheckCompletion();
          }

          function CheckCompletion()
          {
            if (Game_GetWorldState("MAIN_QUEST", quest_marker_stage_object_id) != null)
              SetCurrentPhaseGoalCompletedById(id);
          }
        }
        {
          id = "ACTIVATE_RELAY_1"
          quest_marker_stage_object_id = "LINK_RELAY_1"
          description = "The Farm Relay"

          function OnCommandWord(command_word)
          {
            if (command_word == "activate")
              CheckCompletion();
          }

          function CheckCompletion()
          {
            if (Game_GetWorldState("MAIN_QUEST", quest_marker_stage_object_id) != null)
              SetCurrentPhaseGoalCompletedById(id);
          }
        }
        {
          id = "ACTIVATE_RELAY_0"
          quest_marker_stage_object_id = "LINK_RELAY_0"
          description = "The Park Relay"

          function OnCommandWord(command_word)
          {
            if (command_word == "activate")
              CheckCompletion();
          }

          function CheckCompletion()
          {
            if (Game_GetWorldState("MAIN_QUEST", quest_marker_stage_object_id) != null)
              SetCurrentPhaseGoalCompletedById(id);
          }
        }
        {
          id = "ACTIVATE_RELAY_3"
          quest_marker_stage_object_id = "LINK_RELAY_3"
          description = "The Graveyard Relay"

          function OnCommandWord(command_word)
          {
            if (command_word == "activate")
              CheckCompletion();
          }

          function CheckCompletion()
          {
            if (Game_GetWorldState("MAIN_QUEST", quest_marker_stage_object_id) != null)
              SetCurrentPhaseGoalCompletedById(id);
          }
        }
        {
          id = "OPEN_GATE"
          description = "Open the gate."
          quest_marker_stage_object_id = "evac_inner_gate_terminal"
        }
      ]
    }

    {
      id = "INVESTIGATE_EVACUATION_SITE_FIND_POD"
      description = "Investigate the evacuation site."
      reward_xp = 5850
      goals = [
        {
          id = "EXAMINE_ESCAPE_POD"
          description = "Find an [GREEN]Escape Pod[WHITE] at [LOCATION=EVACUATION_SITE]."
          quest_marker_stage_object_id = "ESCAPE_POD"
        }
      ]
    }

    {
      id = "INVESTIGATE_LINK_TOWER"
      description = "Investigate the evacuation site."
      goals = [
        {
          id = "SCAN_FOR_FUEL_CELLS"
          description = "Use the [LOCATION=EVACUATION_SITE] [GREEN]Link Tower[WHITE] to scan for [GREEN]Fuel Cells[WHITE]."
          quest_marker_stage_object_id = "TOWER_E_SHORE"
        }
      ]
    }

    {
      id ="FIND_FUEL_CELLS"
      description = "Find and collect [GREEN]Fuel Cells[WHITE] for the escape pod."
      goals = [
        {
          id = "FIND_FULL_CELLS"
          material_id = "FUEL_CELL"
          required_amount = 4
          description = "Find [VAR.required_amount] x [MATERIAL_ICON=FUEL_CELL] Fuel Cells."
          quest_marker_stage_object_id = "BOSS_LAW,BOSS_REAPER,BOSS_SWORD,BOSS_CROWN"
          
          function OnInitialize()
          {
            CheckCompletion();
          }

          function IsBossKilled(id)
          {
            return Game_GetWorldState("BOSS", "killed_" + id) != null;
          }

          function ShouldShowQuestMarker(stage_object_id)
          {
            local num_fuel_cells_collected = GetPersistentInteger("num_collected");
            if (num_fuel_cells_collected == null || num_fuel_cells_collected < 2)
            {
              if (stage_object_id == "BOSS_SWORD")
                return false;
              if (stage_object_id == "BOSS_CROWN")
                return false;
            }

            if (IsBossKilled(stage_object_id))
              return false;

            return true;
          }

          function GetNumberOfFuelCellsInstalled()
          {
            local num = 0;
            if (Game_GetWorldState("MAIN_QUEST", "INSTALLED_FUEL_CELL_1") != null) num++;
            if (Game_GetWorldState("MAIN_QUEST", "INSTALLED_FUEL_CELL_2") != null) num++;
            if (Game_GetWorldState("MAIN_QUEST", "INSTALLED_FUEL_CELL_3") != null) num++;
            if (Game_GetWorldState("MAIN_QUEST", "INSTALLED_FUEL_CELL_4") != null) num++;
            return num;
          }

          function GetProgressText()
          {
            local num = GetPersistentInteger("num_fuel_cells");
            if (num > this.required_amount)
              num = this.required_amount;
            return num + "/" + this.required_amount;
          }

          function OnCollectedMaterial(so_material, so_collector)
          {
            local material_id = StageObject_GetKeyValue(so_material, "material_id");
            if (material_id == "FUEL_CELL")
            {
              local num_materials_collected = GetPersistentInteger("num_fuel_cells", 0) + 1;
              SetPersistentInteger("num_fuel_cells", num_materials_collected);
              CheckCompletion();
            }
          }

          function CheckCompletion()
          {
            local num = GetPersistentInteger("num_fuel_cells");

            local num_collected = GetPersistentInteger("num_collected");
            if (num_collected == null)
              num_collected = 0;

            if (num != num_collected)
            {
              SetPersistentInteger("num_collected", num);
            }

            if (num >= this.required_amount || GetNumberOfFuelCellsInstalled() >= this.required_amount)
              SetCurrentPhaseGoalCompletedById(id);
          }
        }
      ]
    }

    {
      id = "INSTALL_FUEL_CELLS"
      description = "Install [GREEN]Fuel Cells[WHITE] to the escape pod."
      goals = [
        {
          id = "INSTALL_FUEL_CELLS"
          description = "Install the [GREEN]Fuel Cells[WHITE] to the escape pod at [LOCATION=EVACUATION_SITE]."
          required_amount = 4
          quest_marker_stage_object_id = "ESCAPE_POD"

          function GetNumberOfFuelCellsInstalled()
          {
            local num = 0;
            if (Game_GetWorldState("MAIN_QUEST", "INSTALLED_FUEL_CELL_1") != null) num++;
            if (Game_GetWorldState("MAIN_QUEST", "INSTALLED_FUEL_CELL_2") != null) num++;
            if (Game_GetWorldState("MAIN_QUEST", "INSTALLED_FUEL_CELL_3") != null) num++;
            if (Game_GetWorldState("MAIN_QUEST", "INSTALLED_FUEL_CELL_4") != null) num++;
            return num;
          }
          
          function OnInitialize()
          {
            CheckCompletion();
          }
          
          function GetProgressText()
          {
            return GetNumberOfFuelCellsInstalled() + "/" + this.required_amount;
          }

          function CheckCompletion()
          {
            local num = GetNumberOfFuelCellsInstalled();

            local num_installed = GetPersistentInteger("num_installed");
            if (num_installed == null)
              num_installed = 0;

            if (num != num_installed)
            {
              SetPersistentInteger("num_installed", num);
            }

            if (num >= this.required_amount)
              SetCurrentPhaseGoalCompletedById(id);
          }

          function OnCommandWord(command_word)
          {
            if (command_word == "activate")
            {
              CheckCompletion();
            }
          }
        }
      ]
    }

    {
      id = "INSPECT_AFTER_REFUEL"
      description = "Inspect the fueled [ORANGE]Escape Pod[WHITE]."
      goals = [
        {
          id = "INSPECT"
          description = "Inspect the fueled [ORANGE]Escape Pod[WHITE] at [LOCATION=EVACUATION_SITE]."
          quest_marker_stage_object_id = "ESCAPE_POD"
        }
      ]
    }
        
    {
      id = "ENTER_UNDERCROWN"
      description = "Find the [ORANGE]Escape Pod[WHITE]."
      goals = [
        {
          id = "ENTER"
          description = "Enter the [ORANGE]Undercrown East Tunnel[WHITE]."
          quest_marker_stage_object_id = "entrance_undercrown_east"
        }
      ]
    }
            
    {
      id = "FIND_ACCESS_TO_CROWN_STATION"
      description = "Find the way to the [ORANGE]Crown Station[WHITE]."
      
      goals = [
        {
          id = "LOCATE"
          description = "Find the way to the [ORANGE]Crown Station[WHITE]."
          quest_location = "CROWN_ENTRANCE"
          //quest_marker_stage_object_id = "location_crown_entrance"
          
          function OnEnterLocation(location_id, new_location)
                    {
                        if (location_id == quest_location)
                            SetCurrentPhaseGoalCompletedById(id);
                    } 
                    
        }
      ]
    },
    //At Crown Station
    ///

    /*
    {
      id = "PHASE_ROAD_TO_LAUNCHPAD"
      description = ""    

      goals = [

        {
          id = "GOAL_LAUNCHPAD_ROAD"
          description = "Go to the Escape Pod [ORANGE]Launchpad[WHITE]."
          quest_marker_stage_object_id = "location_crown_launch_pad"
          quest_location = "CROWN_LAUNCHPAD_ROAD"
          actor_id = "quest_launchpad_door"

        
          //function OnEnterLocation(location_id, new_location)
                    //{
                    //    if (location_id == quest_location)
                    //        SetCurrentPhaseGoalCompletedById(id);
                    //} 
          

                    function OnCommandWord(command_word)
          {
            if (command_word == "activate")
            {
              SetCurrentPhaseGoalCompletedById(id);
            }
          }


        }

      ]
    },
    */    
    {
      
      id = "PHASE_LOCATE_DOOR"
      description = ""
      goals = [

        {
          
          id = "GOAL_FIND_LOCKED_DOOR"
          description = "Go to the Escape Pod [ORANGE]Launchpad[WHITE]."
          quest_marker_stage_object_id = "location_crown_launch_pad"
          actor_id = "quest_launchpad_door"
          
          function OnInitialize()
          {
            //CheckProgress();
          }

          function OnUpdate(tdelta)
          {
            //CheckProgress();
          }

          function CheckProgress()
          {
            //SetCurrentPhaseGoalCompletedById(id);
          }

          // player tries to open the door that needs launchpad key
          function OnActorInteraction(interactive_actor, interactor_actor, interaction_id)
          {
            if (StageObject_GetId(interactive_actor) == actor_id && interaction_id == "quest_try_open")
            {
              
              SetCurrentPhaseGoalCompletedById(id);

            }
          }

        }

      ]

    },
    {

      id = "PHASE_CROWN_KEY_MESSAGE"
      description = ""
      goals = [
        
        {

          id = "CROWN_KEY"
          description = "Look around for clues where the key could be."
          quest_marker_stage_object_id = "launchpad_key_note"
          

                    function OnCommandWord(command_word)
                    {
                        if (command_word == "activate")
                        {
                            SetCurrentPhaseGoalCompletedById(id);
                        }
                    }
        }

      ]

    },
        {

      id = "PHASE_FIND_KEY"
      description = ""
      goals = [
        
        {
          id = "GOAL_FIND_KEY"
          description = "[GREEN]Search[WHITE] for the [ORANGE]Launchpad Key[WHITE] in [ORANGE]The Fortress[WHITE]."  
          quest_marker_stage_object_id = "founders_office_marker"  

                    function OnInitialize()
                    {
                        CheckProgress();
                    }      

                    function OnCollectibleFound(category, key_id)
                    {
                        if (category == "KEYS" && key_id == "LAUNCHPAD_KEY")
                        {
                            SetCurrentPhaseGoalCompletedById(id);
                        }
                    }  

                    function CheckProgress()
          {
                        if (Game_IsCollectibleFound("KEYS","LAUNCHPAD_KEY"))
            {
              SetCurrentPhaseGoalCompletedById(id);
            }
                    }

        },        
        {

          id = "GOAL_GO_TO_LAUNCHPAD"
          description = "Find the [ORANGE]Escape Pod[WHITE] at the [ORANGE]Launchpad[WHITE]."
          quest_marker_stage_object_id = "CROWN_STATION_ESCAPE_POD"
          quest_location = "CROWN_STATION_LAUNCH_PAD"      

                    /*
                    function OnEnterLocation(location_id, new_location)
                    {
                        if (location_id == quest_location)
                            SetCurrentPhaseGoalCompletedById(id);
                    }
                    */

        }
      ]

    },
    {
      id = "LOAD_MANA_CARGO"
      description = "Mana is too precious to leave behind. Load the Escape Pod with some Mana Chunks and Tomb Orbs."
      
      goals = [
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
        {
          id = "MANA_BEAD"
          description = "Load [MATERIAL_ICON=MANA_BEAD] Mana Beads."
        },
        {
          id = "MANA_CHUNK"
          description = "Load [MATERIAL_ICON=MANA_CHUNK] Mana Chunks."
        },
        {
          id = "MANA_SHARD"
          description = "Load [MATERIAL_ICON=MANA_SHARD] Mana Shards."
        },
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        {
          id = "TOMB_ORB"
          description = "Load [MATERIAL_ICON=TOMB_ORB] Blue Eye Orbs."
        }      
      ]
    }    
    
    {
      id = "ENGINE_WARM_UP"
      description = "Warm up the Escape Pod engine."
      goals = [
        {
          id = "ENGINE_WARM_UP"
          description = "Warm up the engine."
        }    
      ]
    }
        
    {
      id = "ENGINE_FIX"
      description = "Warm up the Escape Pod engine."
      goals = [
        {
          id = "ENGINE_FIX"
          description = "Fix the engine."
        }    
      ]
    }

    {
      id = "ONBOARD_THE_ESCAPE_POD"
      description = "Say goodbyes and board the [ORANGE]Escape Pod[WHITE]."
      reward_string = "???"
      goals = [
        {
          id = "ONBOARD"
          description = "Board the [ORANGE]Escape Pod[WHITE]."
          quest_marker_stage_object_id = "CROWN_STATION_ESCAPE_POD"
        }
      ]
    }    
  ]
}


function CheckAllCurrentQuestGoals()
{
  local current_phase_index = Game_GetQuestPhaseIndex(quest_id);
  foreach (goal in quest.phases[current_phase_index].goals)
  {
    if ("CheckCompletion" in goal && goal.CheckCompletion())
    {
      SetCurrentPhaseGoalCompletedById(goal.id);
    }
  }
}

function Initialize()
{
  CheckAllCurrentQuestGoals();
}

function OnCollectedMaterial(so_material, so_collector)
{
  local current_phase_index = Game_GetQuestPhaseIndex(quest_id);
  foreach (goal in quest.phases[current_phase_index].goals)
  {
    if ("CheckCompletion" in goal && goal.CheckCompletion())
    {
      CheckAllCurrentQuestGoals();
    }
  }
}

function OnQuestCompleted()
{
    local text = LOC_TEXT("Save has been restored to the moment before entering the escape pod. [GREEN]Main Quest[WHITE] is now complete. You can continue completing [GREEN]Side Quests[WHITE] and other activities.");
  text = Game_GetConvertedString(text);
    UI_ShowPopup("", text);
}
