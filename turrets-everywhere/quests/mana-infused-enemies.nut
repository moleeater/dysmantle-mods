quest <- {
    category =    "SIDE_QUEST"
    name =        "Blowing a Fuse"
    description = "Some enemies in the [ORANGE]Underworld[WHITE] are Infused with Mana. This makes them tougher until the protective shielding is broken away."
    description_when_completed = "Mana makes the infused enemies tougher and resistant to slashing weapons, but clever use of the other tools available should take care of them."
    image =       "quests/gfx/header-dlc1.png"
  requires_iap = "DLC1"
    

    phases = [
    {
        id = "PHASE_KILL"
        reward_recipe_id = "MANA_CROSSBOW"
        description = ""
        reward_xp = 3000
        goals = [
                    {
                        id = "GOAL_KILL"
                        description = "Use a [GREEN]Blunt[WHITE], [GREEN]Ranged[WHITE] or [GREEN]Explosive[WHITE] weapon to kill [VAR.required_amount] Mana Infused enemies."
                        actor_id = "FORGOTTEN_STASHES_1"
                        required_amount = 6

                        actor_type_id_0 = "actors/enemies/ex-human-mana-female-melee.xml"
                        actor_type_id_1 = "actors/enemies/ex-human-male-mana-melee.xml"
                        actor_type_id_2 = "actors/enemies/ex-human-mana-chaser.xml"
                        actor_type_id_3 = "actors/enemies/ex-human-mana-puker.xml"   


                        function GetProgressText()
                        {
                            local num = GetPersistentInteger("num_destroyed", 0);
                            return num + "/" + this.required_amount;
                            
                        }

                        function OnInitialize(){
                            SetPersistentInteger("num_destroyed", 0);
                            GetProgressText()
                        }                     

                        function OnActorStartDying(actor)
                        {   

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
                    }
                ]
    }    

    ]

}
