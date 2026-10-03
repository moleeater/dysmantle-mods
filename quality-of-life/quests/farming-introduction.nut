quest <- {
  category =    "SIDE_QUEST"
  name =        "Farming Basics"
  description = "Farming should be looked into, as growing crops can help you to get more ingredients for food."
  description_when_completed = "The first harvest is successful and promises a perpetual source of sustenance."
  image =       "quests/gfx/header-default.png"

  phases = [
    {
      id = "PHASE_0"
      description = ""
      reward_xp = 4500

      goals = [

        {
          id = "SEED_BAG"
          description = "Invent and Craft [GREEN]Seed Bag[WHITE]."

          function OnInitialize()
          {
            Game_SetRecipeUnlocked("SEED_BAG", true, true);
            CheckProgress();
          }

          function OnUpdate(tdelta)
          {
            CheckProgress();
          }

          function CheckProgress()
          {
            if (Game_IsRecipeCrafted("SEED_BAG"))
              SetCurrentPhaseGoalCompletedById(id);
          }
        }

        {
          id = "PLANT_A_SEED"
          description = "Plant a [GREEN]Seed[WHITE]."

          function OnInitialize()
          {
            CheckProgress();
          }

          function OnCommandWord(command)
          {
            if (command == "plant_seed")
              SetCurrentPhaseGoalCompletedById(id);
          }

          function CheckProgress()
          {
          }
        },

        {
          id = "HARVEST_CROPS"
          description = "Harvest [GREEN]Crops[WHITE]."

// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
          reward_recipe_id = "BUILDER"
          function OnPhaseCompleted() {
            Game_SetBuildableUnlocked ("actors/buildables/planter.xml", true, true);
          }
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

          function OnInitialize()
          {
            CheckProgress();
          }
          function OnUpdate(tdelta)
          {
            CheckProgress();
          }
          function CheckProgress()
          {
          }

          function OnActorStartDying(actor)
          {
            if (StageObject_HasTag(actor, "HARVESTABLE"))
              SetCurrentPhaseGoalCompletedById(id);
          }

          function OnActorInteraction(interactive_actor, interactor_actor, interarction_id)
          {
            if (interarction_id == "harvest")
              SetCurrentPhaseGoalCompletedById(id);
          }
        },

      ]
    }
  ]
}
