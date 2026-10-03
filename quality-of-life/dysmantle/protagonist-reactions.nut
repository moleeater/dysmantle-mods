// MODS vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
if (NX_FileExists ("actors/collectibles/tarot.xml") || NX_FileExists ("scripts/interactions/tarot.nut") || NX_FileExists ("ui/tarot_templates.xml")
|| NX_FileExists ("ui/collectibles/tarotcard.nut") || NX_FileExists ("ui/collectibles/tarotcard.xml")
|| NX_FileExists ("actors/interactives/farming-mushroom_brown.xml") || NX_FileExists ("docs://Mega Quality Of Life Balance Mod/mod-info.xml")
|| NX_FileExists ("ugc://3711913031/mod-info.xml") || NX_FileExists ("ugc://3703339560/mod-info.xml")) return null;


local mods_include_path = "";
mods_include_path = "scripts/mods/mods-by-moleeater.nut"; if (NX_FileExists (mods_include_path)) Include (mods_include_path);
// MODS ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


///
/// Protagonist reacts to world events.
///


function OnInitialize()
{
  is_cold <- false;
  is_heat <- false;
}

///
/// Implemented:  (move functions here from "Ideas:" after they have been implemented.
///

// Adds strings used in these reactions to localization database.
function OnLocalize()
{
  LocalizeText("Test reaction text!");
}

// Called periodically when there's a good spot to a safe spot to e.g. say something.
function OnUpdate(so_self)
{
  if (!is_cold && !is_heat)
  {
    Game_PlayAnimationByAction(so_self, "idle");
  }
// MODS vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mods_by_MoleEater_OnUpdate_ProtagonistReactions") == true) Mods_by_MoleEater_OnUpdate_ProtagonistReactions (so_self);
// MODS ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}

// Gets called each time the played is respawned after death.
function OnRespawnedAfterDeath(so_self, num_times_died)
{
// MODS vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mods_by_MoleEater_OnRespawnedAfterDeath_ProtagonistReactions") == true) Mods_by_MoleEater_OnRespawnedAfterDeath_ProtagonistReactions (so_self, num_times_died);
// MODS ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  switch (num_times_died)
  {
    case 1: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("What just happened? [EMOJI=hushed face]"), 1); break;
    case 2: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("I thought I was dead. [EMOJI=hushed face]"), 1); break;
    case 3: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("Still alive!"), 1); break;
    case 4: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("I don't like dying."), 1); break;
    case 6: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("This does raise some hard questions about existence..."), 1); break;
    case 8: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("Once more into the fray..."), 1); break;
    case 10: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("I guess it is just a vicious cycle."), 1); break;
    case 14: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("Here we go again."), 1); break;
    case 20: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("It feels good to be alive again."), 1); break;
    case 25: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("Immortality's out of bounds, it's a one-round ride... or so I thought."), 1); break;
    case 30: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("A true survivor doesn't die even if he's killed!"), 1); break;
    case 35: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("I ain't no fortunate one."), 1); break;
    case 40: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("My existence will not be vanquished so easily!"), 1); break;
    case 50: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("I have reached my golden deathiversary..."), 1); break;
    case 69: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("I hate dying."), 1); break;
    case 80: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("Another timely escape from the prickly fingers of death!"), 1); break;
    case 99: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("99 red balloons, floating in the summer sky"), 1); break;
    case 100: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("Is 100 deaths really something to celebrate?"), 1); break;
    case 101: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("Oh well, make that 101 deaths..."), 1); break;
    case 111: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("This circle of life, lived through it many times."), 1); break;
    case 150: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("150 deaths ain't nothing. I have to keep my chin up."), 1); break;
    case 200: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("Toward the unknown. Once more!"), 1); break;
    case 250: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("Quarter of a thousand close passes of sweet oblivion. I might be lucky to have survived."), 1); break;
    case 451: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("0451 seems like an important number. Why is that though?"), 1); break;
    case 1000: Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("One thousand times I've died. One thousand times I've come back."), 1); break;
  }
}


// Gets called every 15 minutes of game time.
function OnTimeOfDay(so_self, hours, minutes)
{
// MODS vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mods_by_MoleEater_OnTimeOfDay_ProtagonistReactions") == true) Mods_by_MoleEater_OnTimeOfDay_ProtagonistReactions (so_self, hours, minutes);
// MODS ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}


function OnGatherMaterial(so_self, so_gatherable, material_id)
{
  if (Game_IsShowingActorNotification(so_self))
    return; // Wait for a good spot when not much is happening.
    
  if (Game_GetWorldState("GATHERABLES", "shown_reaction", material_id) != null)
  {
    if (m_randf() < 0.9)
      return; // Replay these occasionally even if shown before.
  }
  else
  {
    Game_SetWorldState("GATHERABLES", "shown_reaction", material_id, "1");
  }

  if (material_id == "MANA_BEAD")
  {
    Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("This seems valuable! [EMOJI=thinking face]"), 1.0);
    return;
  }

  if (material_id == "EGG")
  {
    Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("Oh?"), 1.0);
    return;
  }
  
  if (material_id == "BERRIES")
  {
    Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("Nature's candy? [EMOJI=face with raised eyebrow]"), 1.0);
    return;
  }
}

// Gets called when a fish is caught (maybe any material though)
function OnCaughtFish(so_self, material_id)
{
  if (material_id == "FISH_D")
  {
    Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("What a great catch! [EMOJI=fish]"), 0.5);
  }
}

// Gets called when a fish would be caught but the spot is depleted
function OnFishingSpotDepleted(so_self, fishing_spot_probability_id)
{
  local options = [];
  options.append(LOC_TEXT("Nothing! It seems there's no more fish here. [EMOJI=thinking face]"));
  options.append(LOC_TEXT("Nothing! Fish don't seem to bite here. Better move on."));
  options.append(LOC_TEXT("Nothing! I should find a new fishing spot. [EMOJI=thinking face]"));
  options.append(LOC_TEXT("Nothing! I seem to have caught all the fish there are in this spot. [EMOJI=smirking face]"));
  options.append(LOC_TEXT("Nothing! Maybe the fish have run away.. with their fish feet. [EMOJI=fish] [EMOJI=foot]"));
  options.append(LOC_TEXT("Nothing! Well, there's plenty of fish in the sea, but just not in this spot. [EMOJI=face with rolling eyes]"));
  options.append(LOC_TEXT("Fish don't seem to be biting anymore. I should switch places."));
  options.append(LOC_TEXT("This spot is devoid of fish. I should probably find another place."));

  local num_options = options.len();
  local r = rand()%num_options;
  local text = options[r];
  Game_AddActorNotificationWithDelay(so_self, text, 0.1);
}

// Gets called when temperature has changed for given threshold or when temperature limits have changed
function OnTemperature(so_self, old_temperature, new_temperature, cold_limit, heat_limit)
{
  is_cold = new_temperature <= cold_limit;
  is_heat = new_temperature >= heat_limit;

  if (is_cold)
  {
    if (!Game_IsPlayingAnimationByAction(so_self, "idle_shiver"))
    {
      Game_PlayAnimationByAction(so_self, "idle_shiver");
      Game_AddActorNotification(so_self, LOC_TEXT("So cold! [EMOJI=cold face]"));
    }
  }
  else
  {
    Game_StopAnimationByAction(so_self, "idle_shiver");
  }

  if (is_heat)
  {
    if (!Game_IsPlayingAnimationByAction(so_self, "idle_heat_damage"))
    {
      Game_PlayAnimationByAction(so_self, "idle_heat_damage");
      Game_AddActorNotification(so_self, LOC_TEXT("So hot.. [EMOJI=hot face]"));
    }
  }
  else
  {
    Game_StopAnimationByAction(so_self, "idle_heat_damage");
  }
}

// Called when the player is low on hit points.
function OnLowHitPoints(so_self, hit_points, hit_points_max)
{
}

// Called only once per interesting (enemy or animal) actor.
function OnSpottedActor(so_self, so_spotted)
{
}

// Called when an interaction becomes available.
function OnLevelUp(so_self, new_level)
{
  local options = [];
  options.append(LOC_TEXT("I have [GREEN]leveled up[WHITE]. I should return to the [ORANGE]campfire[WHITE] and [GREEN]invent[WHITE] something."));
  options.append(LOC_TEXT("I feel older and [GREEN]wiser[WHITE]."));
  options.append(LOC_TEXT("My knowledge of this world is [GREEN]expanding[WHITE]."));
  options.append(LOC_TEXT("I'm getting the hang of this."));
  options.append(LOC_TEXT("Sweet. I'm wiser."));
  options.append(LOC_TEXT("I just thought of something. I should return to the [ORANGE]campfire[WHITE]."));
  options.append(LOC_TEXT("I just had a breakthrough!"));
  options.append(LOC_TEXT("I feel my inner strength growing."));
  options.append(LOC_TEXT("I have newfound clarity."));
  options.append(LOC_TEXT("I feel I have come alive!"));
  options.append(LOC_TEXT("I continue to push boundaries!"));
  options.append(LOC_TEXT("Today is the first day of the rest of my life!"));
  options.append(LOC_TEXT("When I put my mind to it I can overcome anything!"));
  options.append(LOC_TEXT("One step at a time, towards greatness."));
  options.append(LOC_TEXT("The day when I finally get out of this island is ever closer."));
  options.append(LOC_TEXT("One step at a time, towards greatness."));
  options.append(LOC_TEXT("My will is the will that will pierce the Heavens!"));
  options.append(LOC_TEXT("I can picture my eventual triumph! It is just beyond reach."));
  options.append(LOC_TEXT("The key is patience and hard work."));
  options.append(LOC_TEXT("Everything is coming together, piece by piece."));

  local num_options = options.len();
  if (num_options > new_level)
    num_options = new_level;
  local r = rand()%num_options;
  local text = options[r];
  Game_AddActorNotificationWithDelay(so_self, text, 0.1);
}

// Called when depositing materials into the wishing well.
function OnWishingWellDeposit(so_self, so_well, success)
{
  local options = [];
  options.append(LOC_TEXT("Well that's something."));
  options.append(LOC_TEXT("Well well well."));
  options.append(LOC_TEXT("Oh well."));
  options.append(LOC_TEXT("I'm well!"));
  options.append(LOC_TEXT("All's well that ends well."));
  options.append(LOC_TEXT("I am very well!"));
  options.append(LOC_TEXT("This is very fine and well"));
  options.append(LOC_TEXT("Could this be called wellfare?"));
  options.append(LOC_TEXT("This place is well established."));
  options.append(LOC_TEXT("My backpack is swelling with materials!"));
  options.append(LOC_TEXT("Well here goes nothing!"));

  local num_options = options.len();
  local r = rand()%num_options;
  local text = options[r];
  Game_AddActorNotificationWithDelay(so_self, text, 0.1);
}

function OnDugUpRandomTreasure(so_self, material_id)
{
  local options = [];
  options.append(LOC_TEXT("Nice!"));
  options.append(LOC_TEXT("Wow!"));
  options.append(LOC_TEXT("Found something!"));
  options.append(LOC_TEXT("My shovel hit something!"));
  options.append(LOC_TEXT("What do we have here?"));
  options.append(LOC_TEXT("I found something hidden!"));
  options.append(LOC_TEXT("Digging is an honest job."));

  local num_options = options.len();
  local r = rand()%num_options;//(3*num_options);
  if (r >= options.len())
    return;
  local text = options[r];
  Game_AddActorNotificationWithDelay(so_self, text, 0.1);
}

function OnHoeing(so_self, is_valid_location)
{
  if (!is_valid_location)
  {
    Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("This is not good soil for plants."), 0.1);
  }
}

function OnPlanting(so_self, is_valid_location)
{
  if (!is_valid_location)
  {
    Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("The ground must be shaped with a hoe before planting seeds."), 0.1);
  }
  else
  {
    local times_planted = Game_GetWorldState("FARMING", "times_planted");
    if (times_planted == null)
    {
      times_planted = 1;
      Game_SetWorldState("FARMING", "times_planted", times_planted.tostring());
      Game_AddActorNotificationWithDelay(so_self, LOC_TEXT("There! Now I'll just wait for it to grow."), 1.0);
    }
  }
}


function OnCoopPlayerJoined(so_primary_player, so_coop_player)
{
// MODS vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mods_by_MoleEater_OnCoopPlayerJoined_ProtagonistReactions") == true) Mods_by_MoleEater_OnCoopPlayerJoined_ProtagonistReactions (so_primary_player, so_coop_player);
// MODS ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  local num = Game_GetWorldStateAsInteger("COOP_REACTIONS", "times_joined", 0);
  local comment_num = num%50;
  num++;
  Game_SetWorldState("COOP_REACTIONS", "times_joined", num.tostring());

  // Game_ClearActorDialogQueue("plr");
  // Game_AddActorDialog("plr", so_primary_player, "Text");
  // Game_AddActorDialog("plr", so_coop_player, "Text");
  
  if (comment_num == 0)
  {
    Game_AddActorNotificationWithDelay(so_primary_player, LOC_TEXT("Are you.. me?"), 1.5);
    Game_AddActorNotificationWithDelay(so_coop_player, LOC_TEXT("It's complicated."), 3.0);
  }
  else if (comment_num == 3)
  {
    Game_AddActorNotificationWithDelay(so_primary_player, LOC_TEXT("Hi."), 1.5);
    Game_AddActorNotificationWithDelay(so_coop_player, LOC_TEXT("Hey."), 2.0);
  }
  else if (comment_num == 5)
  {
    Game_AddActorNotificationWithDelay(so_coop_player, LOC_TEXT("Did you miss me?"), 1.5);
    Game_AddActorNotificationWithDelay(so_primary_player, LOC_TEXT("Sure."), 3.0);
  }
  else if (comment_num == 8)
  {
    Game_AddActorNotificationWithDelay(so_coop_player, LOC_TEXT("It's me again!"), 1.5);
    Game_AddActorNotificationWithDelay(so_primary_player, ("..."), 3.0);
  }
  else if (comment_num == 10)
  {
    Game_AddActorNotificationWithDelay(so_coop_player, LOC_TEXT("Marco!"), 1.5);
    Game_AddActorNotificationWithDelay(so_primary_player, ("Polo!"), 3.0);
  }
  else if (comment_num == 13)
  {
    Game_AddActorNotificationWithDelay(so_coop_player, LOC_TEXT("I know you missed me."), 1.5);
    Game_AddActorNotificationWithDelay(so_primary_player, LOC_TEXT("Let's just do this."), 3.0);
  }
  else if (comment_num == 14)
  {
    Game_AddActorNotificationWithDelay(so_coop_player, LOC_TEXT("I know you missed me."), 1.5);
    Game_AddActorNotificationWithDelay(so_primary_player, LOC_TEXT("Less talking please."), 3.0);
  }
  else if (comment_num == 15)
  {
    Game_AddActorNotificationWithDelay(so_coop_player, LOC_TEXT("I know what you are thinking right now!"), 1.5);
    Game_AddActorNotificationWithDelay(so_primary_player, LOC_TEXT("You think you have me figured out, huh?"), 3.0);
  }
  else if (comment_num == 16)
  {
    Game_AddActorNotificationWithDelay(so_coop_player, LOC_TEXT("I am he as you are he as you are me."), 1.5);
    Game_AddActorNotificationWithDelay(so_primary_player, LOC_TEXT("...What?"), 3.0);
  }
  else if (comment_num == 20)
  {
    Game_AddActorNotificationWithDelay(so_coop_player, LOC_TEXT("So, do you come here often?"), 1.5);
    Game_AddActorNotificationWithDelay(so_primary_player, LOC_TEXT("You're the one to speak!"), 3.0);
  }
  else if (comment_num == 100)
  {
    Game_AddActorNotificationWithDelay(so_coop_player, LOC_TEXT("This is the one hundreth time we've gotten together. So let's make this time special!"), 1.5);
    Game_AddActorNotificationWithDelay(so_primary_player, LOC_TEXT("Sure, sounds good. I think you are starting to grow on me. Just a little."), 3.0);
  }
  
}

function OnCoopPlayerRevived(so_primary_player, so_coop_player)
{
  local options = [];
  options.append(LOC_TEXT("Good to be back."));
  options.append(LOC_TEXT("Did you miss me?"));
  options.append(LOC_TEXT("You couldn't do this alone."));
  options.append(LOC_TEXT("I'm here to help."));
  options.append(LOC_TEXT("Thanks. [EMOJI=folded hands]"));
  options.append(LOC_TEXT("I don't mind dying."));
  options.append(LOC_TEXT("I'm back!"));
  options.append(LOC_TEXT("Together we are stronger!"));
  options.append(LOC_TEXT("Sorry, that was my mistake!"));

  local num_options = options.len();
  local r = rand()%(4*num_options);
  if (r >= options.len())
    return;
  local text = options[r];
  Game_AddActorNotificationWithDelay(so_coop_player, text, 1.1);
}

function OnCoopPlayerTeleportedBackToPrimaryPlayer(so_primary_player, so_coop_player)
{
  local options = [];
  options.append(LOC_TEXT("You can't leave me."));
  options.append(LOC_TEXT("Are you trying to run away from me?"));
  options.append(LOC_TEXT("Don't you like me?"));
  options.append(LOC_TEXT("There's no escape."));
  options.append(LOC_TEXT("Welcome back."));
  options.append(LOC_TEXT("Don't wander too far."));
  options.append(LOC_TEXT("Are you trying to avoid me?"));
  options.append(LOC_TEXT("I think there is danger around the corner so stay close!"));

  local num_options = options.len();
  local r = rand()%(4*num_options);
  if (r >= options.len())
    return;
  local text = options[r];
  Game_AddActorNotificationWithDelay(so_primary_player, text, 0.75);
}

function OnDeath(so_self)
{
// MODS vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if (this.rawin ("Mods_by_MoleEater_OnDeath") == true) Mods_by_MoleEater_OnDeath (so_self);
// MODS ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Game_StopAnimationByAction(so_self, "idle");
  Game_StopAnimationByAction(so_self, "idle_shiver");
  Game_StopAnimationByAction(so_self, "idle_heat_damage");
}

function OnMaterialEaten(so_self, material_id)
{
}

function OnDishEaten(so_self, recipe_id, material_list)
{
}


///
/// Ideas:
///

// Called when an interaction becomes available.
function OnNewInteraction(so_self, so_interactive_actor, interaction_id)
{

}
