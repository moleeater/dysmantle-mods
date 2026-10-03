// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
if (NX_FileExists ("actors/collectibles/tarot.xml") || NX_FileExists ("scripts/interactions/tarot.nut") || NX_FileExists ("ui/tarot_templates.xml")
|| NX_FileExists ("ui/collectibles/tarotcard.nut") || NX_FileExists ("ui/collectibles/tarotcard.xml")
|| NX_FileExists ("actors/interactives/farming-mushroom_brown.xml") || NX_FileExists ("docs://Mega Quality Of Life Balance Mod/mod-info.xml")
|| NX_FileExists ("ugc://3711913031/mod-info.xml") || NX_FileExists ("ugc://3703339560/mod-info.xml")) return null;


local mods_include_path = "";
mods_include_path = "scripts/mods/mods-by-moleeater.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


///
/// Game Settings. This file defines basic game settings in scriptable fashion.
///


function GetTestGameIds()
{
  // These are used in the main menu test game launcher.
  // These ids (for example "AfterSuburb") need to be handled in OnSetupNewGame function (see below).
  // There also needs to exist global marker with id such as "player_start_AfterSuburb".
  return "AfterSuburb,LatestUpdate,dlc";
}

// Called when a new game is started. Parm 'game_id' refers to game start id.
function OnSetupNewGame(game_id, so_player)
{
// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mods_by_MoleEater_OnSetupNewGame") == true) Mods_by_MoleEater_OnSetupNewGame (game_id, so_player);
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  if (game_id == "AfterSuburb")
  {
    local target_xp = Game_GetExperiencePointsRequiredForLevel(13) + 150;
    Game_AddExperiencePoints(target_xp);
    Game_SetWorldState("CUTSCENES", "DEERS_1", "1");
    Game_SetFeatureAvailable("MAP", true);

    Game_CraftRecipe("THROWING_KNIVES");
    Game_CraftRecipe("THROWING_KNIVES_TRIPLE");
    Game_CraftRecipe("COOKING_POT");
    Game_CraftRecipe("MACHETE");
    Game_CraftRecipe("BASEBALL_BAT");
    Game_CraftRecipe("COUNTERWEIGHT");
    Game_CraftRecipe("MONSTER_LURE");
    Game_CraftRecipe("HOT_WATER_BOTTLE");
    Game_CraftRecipe("ICE_BRICK");
    Game_CraftRecipe("OUTFIT_OUTDOORSMAN");
    Game_CraftRecipe("COWBOY_HAT");
    Game_CraftRecipe("FUR_HAT");
    Game_CraftRecipe("BAG_OF_BLOOD");
    Game_CraftRecipe("BUILDER");

    Game_CraftRecipe("DISH_CACTUS_JUICE");
    Game_CraftRecipe("DISH_CORNCOB");
    Game_CraftRecipe("DISH_HAMBURGER");
    
    for (local i = 0; i < 4; i++)
      Game_UpgradeRecipe("CROWBAR");

    for (local i = 0; i < 4; i++)
      Game_UpgradeRecipe("MACHETE");

    for (local i = 0; i < 3; i++)
      Game_UpgradeRecipe("BASEBALL_BAT");

    for (local i = 0; i < 2; i++)
      Game_UpgradeRecipe("THROWING_KNIVES");

    for (local i = 0; i < 2; i++)
      Game_UpgradeRecipe("THROWING_KNIVES_TRIPLE");

    for (local i = 0; i < 3; i++)
      Game_UpgradeRecipe("BACKPACK");


    Game_SetWorldState("BOSS_INTROS", "SUBURB_GATEKEEPER", "1");
    Game_SetWorldState("CUTSCENES", "INTRO_CREDITS", "1");

    Game_RevealPointOfInterestOnMap("TOWER_E");

    for (local x = 80400; x < 93000; x += 1000)
      Game_RevealMapAtPointRadius(x, 31600, 2600);

    return;
  }

  if (game_id == "LatestUpdate")
  {
    OnSetupNewGame("AfterSuburb", so_player);

    Game_RevealPointOfInterestOnMap("TOWER_E_SHORE");
    Game_RevealPointOfInterestOnMap("TOWER_NE_MID");
    Game_RevealPointOfInterestOnMap("TOWER_SE_MID");

    local target_xp = Game_GetExperiencePointsRequiredForLevel(20) + 150;
    Game_AddExperiencePoints(target_xp);

    Game_CraftRecipe("THROWING_KNIVES");
    Game_CraftRecipe("COOKING_POT");
    Game_CraftRecipe("COOKING_STAND");
    Game_CraftRecipe("FLASHLIGHT");
    Game_CraftRecipe("BANDAGES");
    Game_CraftRecipe("PAIN_KILLERS");
    Game_CraftRecipe("COFFEE_THERMOS");
    Game_CraftRecipe("SHOVEL");
    Game_CraftRecipe("SEED_BAG");
    Game_CraftRecipe("FISHING_ROD");
    Game_CraftRecipe("MACHETE");
    Game_CraftRecipe("COMPASS");
    Game_CraftRecipe("BASEBALL_BAT");
    Game_CraftRecipe("AXE");
    Game_CraftRecipe("WRENCH");
    Game_CraftRecipe("HOE");
    Game_CraftRecipe("FRAG_GRENADE");
    Game_CraftRecipe("THROWING_KNIVES_TRIPLE");
    Game_CraftRecipe("OUTFIT_ARMOR-LIGHT");
    Game_CraftRecipe("OUTFIT_OUTDOORSMAN");
    Game_CraftRecipe("OUTFIT_LUMBERJACK");
    Game_CraftRecipe("COWBOY_HAT");
    Game_CraftRecipe("FUR_HAT");
    Game_CraftRecipe("BAG_OF_BLOOD");
    Game_CraftRecipe("LACES");
    Game_CraftRecipe("ACUPUNCTURE_NEEDLES");
    Game_CraftRecipe("BASEBALL_CARD");
    Game_CraftRecipe("MACHINED_SPRING");
    Game_CraftRecipe("BASEBALL_CAP");
    Game_CraftRecipe("COUNTERWEIGHT");
    Game_CraftRecipe("SHOCK_ABSORBER");
    Game_CraftRecipe("ICE_BRICK");
    Game_CraftRecipe("JAR_OF_LARD");
    Game_CraftRecipe("TACKLE");
    Game_CraftRecipe("HOT_WATER_BOTTLE");
    Game_CraftRecipe("CAMO_NETTING");
    Game_CraftRecipe("GYROSCOPE");
    Game_CraftRecipe("ROPE_AND_HOOK");
    Game_CraftRecipe("COMPRESSOR_COMMON");
    Game_CraftRecipe("SLEEPING_BAG");
    Game_CraftRecipe("STORAGE_BOX_TAKE_AWAY");
    Game_CraftRecipe("LINK_TOWER_TOOLKIT");
    Game_CraftRecipe("TRANSMITTER_ENEMY_RESPAWN_DISABLER");
    Game_CraftRecipe("LOCKPICK_SIMPLE");
    Game_CraftRecipe("LOCKPICK_COMPLEX");
    Game_CraftRecipe("AMBER_MANA_PILLS");
    Game_CraftRecipe("MONSTER_LURE");
    Game_CraftRecipe("OUTFIT_WINTER_COAT");
    Game_CraftRecipe("OUTFIT_SAFARI");
    Game_CraftRecipe("DENTURED_FANGS");
    Game_CraftRecipe("BOONEY_HAT");
    Game_CraftRecipe("GAS_MASK");

    Game_CraftRecipe("DISH_SMOKED_FISH_PASTA");
    Game_CraftRecipe("DISH_FISH_SALAD");
    Game_CraftRecipe("DISH_MUSHROOM_OMELETTE");
    Game_CraftRecipe("DISH_POTATO_SALAD");
    Game_CraftRecipe("DISH_BONE_MARROW");
    Game_CraftRecipe("DISH_BAKED_POTATOES");
    Game_CraftRecipe("DISH_GARLIC_MUSHROOMS");
    Game_CraftRecipe("DISH_FISHNCHIPS");
    Game_CraftRecipe("DISH_SMOOTHIE");
    Game_CraftRecipe("DISH_EGGSNBACON");
    Game_CraftRecipe("DISH_BREAD");
    Game_CraftRecipe("DISH_CORNCOB");
    Game_CraftRecipe("DISH_TOMATO_SOUP");
    Game_CraftRecipe("DISH_FISH_SOUP");
    Game_CraftRecipe("DISH_CHILI_SOUP");
    Game_CraftRecipe("DISH_HAMBURGER");
    Game_CraftRecipe("DISH_TOMATO_BRUSCHETTA");
    Game_CraftRecipe("DISH_PELOPONNESIAN_VEGETABLES");
    Game_CraftRecipe("DISH_MUSHROOM_SKEWER");
    Game_CraftRecipe("DISH_FISHSTICKS");
    Game_CraftRecipe("DISH_CARROT_JUICE");
    Game_CraftRecipe("DISH_STRAWBERRY_CAKE");
    Game_CraftRecipe("DISH_ONION_RINGS");
    Game_CraftRecipe("DISH_CACTUS_JUICE");
    Game_CraftRecipe("DISH_FLANK_STEAK");
    Game_CraftRecipe("DISH_PANCAKE");

    for (local i = 0; i < 5; i++)
      Game_UpgradeRecipe("CROWBAR");

    for (local i = 0; i < 4; i++)
      Game_UpgradeRecipe("BACKPACK");

    for (local i = 0; i < 4; i++)
      Game_UpgradeRecipe("MACHETE");

    for (local i = 0; i < 4; i++)
      Game_UpgradeRecipe("BASEBALL_BAT");

    for (local i = 0; i < 3; i++)
      Game_UpgradeRecipe("AXE");

    for (local i = 0; i < 3; i++)
      Game_UpgradeRecipe("WRENCH");

    Game_RevealMapAtPointRadius(85000, 31600, 10200);

    //Game_SetLinkTowerActivated(TOWER_E, true);

    for (local x = 90400; x < 100000; x += 1000)
      Game_RevealMapAtPointRadius(x, 31600, 2600);

    return;
  }

  if (game_id == "South")
  {
    OnSetupNewGame("AfterSuburb", so_player);

    Game_RevealPointOfInterestOnMap("TOWER_E_SHORE");
    Game_RevealPointOfInterestOnMap("TOWER_NE_MID");
    Game_RevealPointOfInterestOnMap("TOWER_SE_MID");
    Game_CraftRecipe("COMPASS");

    Game_SetWorldState("BOSS_INTROS", "SUBURB_GATEKEEPER", "1");
    Game_SetWorldState("CUTSCENES", "INTRO_CREDITS", "1");

    local target_xp = Game_GetExperiencePointsRequiredForLevel(14) + 150;
    Game_AddExperiencePoints(target_xp);

    Game_CraftRecipe("THROWING_KNIVES");    
    Game_CraftRecipe("THROWING_KNIVES_TRIPLE");
    Game_CraftRecipe("BAG_OF_BLOOD");
    Game_CraftRecipe("COOKING_POT");
    Game_CraftRecipe("COOKING_STAND");
    Game_CraftRecipe("ROPE_AND_HOOK");
    Game_CraftRecipe("LOCKPICK_SIMPLE");
    Game_CraftRecipe("FLASHLIGHT");
    Game_CraftRecipe("BANDAGES");
    Game_CraftRecipe("COFFEE_THERMOS");
    Game_CraftRecipe("COUNTERWEIGHT");
    Game_CraftRecipe("GYROSCOPE");
    Game_CraftRecipe("SHOVEL");
    Game_CraftRecipe("SEED_BAG");
    Game_CraftRecipe("FISHING_ROD");
    Game_CraftRecipe("MACHETE");
    Game_CraftRecipe("OUTFIT_OUTDOORSMAN");
    Game_CraftRecipe("COWBOY_HAT");
    Game_CraftRecipe("ICE_BRICK");
    Game_CraftRecipe("BASEBALL_CAP");
    Game_CraftRecipe("DISH_TOMATO_SOUP");
    Game_CraftRecipe("DISH_CORNCOB");
    Game_CraftRecipe("DISH_CHILI_SOUP");


    for (local i = 0; i < 3; i++)
      Game_UpgradeRecipe("CROWBAR");

    for (local i = 0; i < 3; i++)
      Game_UpgradeRecipe("BACKPACK");

    for (local i = 0; i < 2; i++)
      Game_UpgradeRecipe("MACHETE");

    Game_RevealMapAtPointRadius(85000, 31600, 10200);

    //Game_SetLinkTowerActivated(TOWER_E, true);

    for (local x = 90400; x < 100000; x += 1000)
      Game_RevealMapAtPointRadius(x, 31600, 2600);

    return;
  }

  if (game_id == "dlc")
  {
    local target_xp = Game_GetExperiencePointsRequiredForLevel(7) + 150;
    Game_AddExperiencePoints(target_xp);
    Game_SetWorldState("CUTSCENES", "DEERS_1", "1");
    Game_SetFeatureAvailable("MAP", true);

    Game_CraftRecipe("ROPE_AND_HOOK");    
    Game_CraftRecipe("SHOVEL");
    Game_CraftRecipe("THROWING_KNIVES");
    Game_CraftRecipe("COOKING_POT");
    Game_CraftRecipe("FLASHLIGHT");
    Game_CraftRecipe("MACHETE");
    Game_CraftRecipe("BASEBALL_BAT");
    Game_CraftRecipe("COUNTERWEIGHT");
    Game_CraftRecipe("MONSTER_LURE");
    Game_CraftRecipe("HOT_WATER_BOTTLE");
    Game_CraftRecipe("ICE_BRICK");
    Game_CraftRecipe("OUTFIT_OUTDOORSMAN");
    Game_CraftRecipe("COWBOY_HAT");
    Game_CraftRecipe("BAG_OF_BLOOD");
    Game_CraftRecipe("BUILDER");
    Game_CraftRecipe("BANDAGES");
    Game_CraftRecipe("LINK_TOWER_TOOLKIT");

    Game_CraftRecipe("DISH_CACTUS_JUICE");
    Game_CraftRecipe("DISH_CORNCOB");
    Game_CraftRecipe("DISH_HAMBURGER");
    
    //3
    for (local i = 0; i < 4; i++)
      Game_UpgradeRecipe("CROWBAR");

    //4
    for (local i = 0; i < 4; i++)
      Game_UpgradeRecipe("BACKPACK");

    for (local i = 0; i < 4; i++)
      Game_UpgradeRecipe("MACHETE");

    for (local i = 0; i < 3; i++)
      Game_UpgradeRecipe("BASEBALL_BAT");

    for (local i = 0; i < 2; i++)
      Game_UpgradeRecipe("THROWING_KNIVES");



    Game_SetWorldState("BOSS_INTROS", "SUBURB_GATEKEEPER", "1");
    Game_SetWorldState("CUTSCENES", "INTRO_CREDITS", "1");

    /*if(!Game_IsQuestCurrent("quests/dlc_1_main.nut")){
      
      //Game_ShowQuestStartDialog ("quests/dlc_1_main.nut", true);
      Game_SetQuestAvailable("quests/myth-tablets.nut");
      Game_SetQuestAvailable("quests/dlc_1_main.nut");
      Game_SetQuestTracked ("quests/dlc_1_main.nut",true,true);
    }*/

    Game_RevealPointOfInterestOnMap("TOWER_E");

    for (local x = 80400; x < 93000; x += 1000)
      Game_RevealMapAtPointRadius(x, 31600, 2600);



    return;
  }
}


// Returns the experience points required to reach given level. Level 1 requirement is always 0.
function GetExperiencePointsRequiredForLevel(level)
{
  local points = (1000+20*level)*level*level;
  points = 100 * floor(points/100);
  //NX_Print("Level " + level + " XP = " + points);
  return points;
}


// Polled each time player enters a stage, so this can query game values and react accordingly.
function GetMonsterHitPointsMultiplier()
{
  return 1.0;
}

///
/// NOT IMPLEMENTED:
///

// Called when enemy boss is born. You can use this to adjust the difficulty level of the boss enemy.
function OnEnemyBossBirth(so_enemy)
{
}
