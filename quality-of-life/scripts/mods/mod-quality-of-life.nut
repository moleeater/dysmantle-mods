// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
if (NX_FileExists ("actors/collectibles/tarot.xml") || NX_FileExists ("scripts/interactions/tarot.nut") || NX_FileExists ("ui/tarot_templates.xml")
|| NX_FileExists ("ui/collectibles/tarotcard.nut") || NX_FileExists ("ui/collectibles/tarotcard.xml")
|| NX_FileExists ("actors/interactives/farming-mushroom_brown.xml") || NX_FileExists ("docs://Mega Quality Of Life Balance Mod/mod-info.xml")
|| NX_FileExists ("ugc://3711913031/mod-info.xml") || NX_FileExists ("ugc://3703339560/mod-info.xml")) return null;


local mod_infos = {
    "quality_of_life": {
        "modpack": true,
        "title"  : "|img src='ui/gfx/mods/mod-quality-of-life.png' scale=0.15 offset=2|  " + LocalizeText("Quality of life"),
        "text"   : "110+ quality-of-life mods packed into one modpack, with a settings interface so you can enable what you want.",
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| playlist",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-quality-of-life-playlist")}],
      },
    "obelisk_info": {
        "title"  : LocalizeText("Obelisk info"),
        "text"   : LocalizeText("Obelisk activation screen shows your activated Obelisk and it's buff, helping you to make a decision if you want to switch."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-obelisk-info-video")}],
      },
    "eating_hitpoints": {
        "title"  : LocalizeText("Eating hit points"),
        "text"   : LocalizeText("Eating from your carried materials backpack shows your current health to know how much the vegetable will heal you."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-eating-hp-video")}],
      },
    "camera_heading": {
        "title"  : LocalizeText("Camera heading"),
        "text"   : LocalizeText("Camera frustum angle (the direction the camera is looking) is highlighted on the edges of the minimap with a blue arc. Helps if you are disoriented."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-camera-heading-video")}],
      },
    "focus_tools": {
        "title"  : LocalizeText("Focus tools"),
        "text"   : LocalizeText("On the inventory screen, Tools got an input focus, so your cursor is on the first Tool, and not on the Headgears."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-focus-tools-video")}],
      },
    "colored_markers": {
        "title"  : LocalizeText("Colored markers"),
        "text"   : LocalizeText("The map north point and the waypoint you placed, got recolored, to help it visually separate from all the white icons."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-colored-markers-video")}],
      },
    "stage_name": {
        "title"  : LocalizeText("Stage name"),
        "text"   : LocalizeText("Map screen shows the name of the Tomb or Dungeon you are currently in, so you don't have to exit and re-enter in case you forgot."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-stage-name-video")}],
      },
    "wheat_is_not_corn": {
        "title"  : LocalizeText("Wheat is not corn"),
        "text"   : LocalizeText("Easier to differentiate Wheat material icon from Corn, as it is mirrored to reduce similarity."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-wheat-is-not-corn-video")}],
      },
    "grid_info": {
        "title"  : LocalizeText("Grid info"),
        "text"   : LocalizeText("Your map grid position (like: K23) is shown below the minimap, so you don't have to keep your eyes following the grid lines, nor open the map to check."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-grid-info-video")}],
      },
    "unhide_text_log": {
        "title"  : LocalizeText("Unhide Text log"),
        "text"   : LocalizeText("Text Log menu always visible, even when it does not have any lines in it, so you can see, that it does not have any lines in it."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-unhide-textlog-video")}],
      },
    "unstuck": {
        "title"  : LocalizeText("Unstuck"),
        "text"   : LocalizeText("Unstuck yourself at the pause menu, when using the Amber Pills are disabled and one of the cheats got you stuck, you fell into a pit, or similar."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-unstuck-video")}],
      },
    "poi_info": {
        "title"  : LocalizeText("POI info"),
        "text"   : LocalizeText("Link Tower POI popup cards show the installed Transmitters for the tower.")
            + "\n" + LocalizeText("Obelisk POI popup cards show the unlocked level to the Obelisk.")
            + "\n" + LocalizeText("Fishing Spot POI popup cards show the list of catchable fish for the spot.")
            + "\n" + LocalizeText("Buried Teleporter POI popup cards show the name of the teleporter circle it belongs to."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-poi-info-tower-video")}],
      },
    "confirm_pills": {
        "title"  : LocalizeText("Confirm pills"),
        "text"   : LocalizeText("Prevent accidental misclicks of using Amber Pills by requiring a confirmation on a popup dialog."),
      },
    "sleep_timer": {
        "title"  : LocalizeText("Sleep timer"),
        "text"   : LocalizeText("Shows remaining real world time until you can sleep again, on the campfire screen."),
      },
    "save_material_transporter": {
        "title"  : LocalizeText("Save material transporter"),
        "text"   : LocalizeText("Do not use up your Material Transporter item when your backpack is empty."),
      },
    "yawning": {
        "title"  : LocalizeText("Yawning"),
        "text"   : LocalizeText("Yawn when you are ready to sleep, remembers you every few real life minutes."),
      },
    "ark_elevator": {
        "title"  : LocalizeText("Ark elevator"),
        "text"   : LocalizeText("Save walking all the way down and up the the Ark, you can select the destination floor in elevators."),
      },
    "remember_the_seed": {
        "title"  : LocalizeText("Remember the seed"),
        "text"   : LocalizeText("Re-equiping your seed bags restores your last selected farming seed."),
      },
    "new_game_plus_plus": {
        "title"  : LocalizeText("New game++"),
        "text"   : LocalizeText("Pick additional recipes, tools, features, dishes you want to carry over to your New Game Plus."),
      },
    "keys_to_home": {
        "title"  : LocalizeText("Keys to home"),
        "text"   : LocalizeText("Unlocks the starting shelter in New Game+ if you have the Crown from the previous run."),
      },
    "show_statistics": {
        "title"  : LocalizeText("Show statistics"),
        "text"   : LocalizeText("View your game statistics any time on the Collection tab, not just after you completed the game."),
      },
    "wiki": {
        "title"  : LocalizeText("Wiki"),
        "text"   : LocalizeText("Link wiki articles to a new button on information panels, etc. Playing in English gives you more specific links."),
      },
    "difficulty": {
        "title"  : LocalizeText("Difficulty"),
        "text"   : LocalizeText("Starting a new game allows you to set the cycle number, affecting enemy health, speed, damage and XP."),
      },
    "collapsible_pois": {
        "title"  : LocalizeText("Collapsible POIs"),
        "text"   : LocalizeText("Hide link tower areas you are not interested in by clicking on the title on the Points of Interest screen of Collection tab."),
      },
    "dont_track_dishes": {
        "title"  : LocalizeText("Don't track dishes"),
        "text"   : LocalizeText("Disable tracking materials for dish recipes by default."),
      },
    "starting_stage": {
        "title"  : LocalizeText("Starting stage"),
        "text"   : LocalizeText("Begin your new game right on a DLC map or at another shelter, to increase challenge."),
      },
    "preserve_nature": {
        "title"  : LocalizeText("Preserve nature"),
        "text"   : LocalizeText("Keep all plants, bones and rocks indestructible when you start a new game."),
      },
    "sane_fabricator": {
        "title"  : LocalizeText("Sane fabricator") + " |img src='emojis/star.png' scale=0.5 offset=2|",
        "text"   : LocalizeText("Flower Power fabricator POI only requires the first level recipes to complete in Doomsday DLC2."),
        "dlc"    : "DLC2",
      },
    "home_game_plus": {
        "title"  : LocalizeText("Home game+"),
        "text"   : LocalizeText("Starting shelter has a New Game+ respawner device when you are already in a New Game+, so you can restart easier."),
      },
    "remind_to_extract": {
        "title"  : LocalizeText("Remind to extract"),
        "text"   : LocalizeText("Notifies you to get the fuel cell after killing the mech bosses."),
      },
    "ascend_shelter": {
        "title"  : LocalizeText("Ascend shelter"),
        "text"   : LocalizeText("Replay shelter horde mini-games with a buffed monster count after victory."),
      },
    "accessible_ramps": {
        "title"  : LocalizeText("Accessible ramps"),
        "text"   : LocalizeText("Walk onto Drawbridges and Piers from the side too."),
      },
    "walk_over_mortarpods": {
        "title"  : LocalizeText("Walk over mortar pods"),
        "text"   : LocalizeText("Walk over dead Mortar Pods, you do not collide with their corpses."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-walk-over-mortarpods-video")}],
      },
    "pickup_mines": {
        "title"  : LocalizeText("Pick up mines"),
        "text"   : LocalizeText("Pick up your unused proximity mines and bear traps from the ground after combat.")
            + "\n" + LocalizeText("Requires item upgrade +2."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-pickup-mines-video")}],
      },
    "visible_bushes": {
        "title"  : LocalizeText("Visible bushes"),
        "text"   : LocalizeText("See snow bushes easier, they are darker, having more contrast to the background."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-visible-bushes-video")}],
      },
    "thinner_bushes": {
        "title"  : LocalizeText("Thinner bushes"),
        "text"   : LocalizeText("Pass over every type of undergrowth, skulls and bones, you won't get stuck in a bushy area."),
      },
    "petting_heals": {
        "title"  : LocalizeText("Petting heals player"),
        "text"   : LocalizeText("Heal yourself too by petting your animals by 20HP, because loving animals heals your heart.") + "\n\n" + LocalizeText("Requires Animal Friend level 3 skill."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-petting-heals-video")}],
      },
    "auto_gasmask": {
        "title"  : LocalizeText("Automatic gas mask"),
        "text"   : LocalizeText("Wear the gas mask automatically when needed, while keeping your original headgear on."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-auto-gasmask-video")}],
      },
    "ark_progress": {
        "title"  : LocalizeText("Ark progress"),
        "text"   : LocalizeText("See your Ark quest material collection progress displayed on the front of the Ark entrance.")
            + "\n\n" + LocalizeText("The Ark entryway POI popup cards on both sides (entry and exit) show your material collection progress."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-poi-info-ark-video")}],
      },
    "healing_treat": {
        "title"  : LocalizeText("Healing treat"),
        "text"   : LocalizeText("Heal your tamed deer by dropping Animal Treats on ground. Healing every second by 20 HP, radius increased by upgrade level."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-healing-treat-video")}],
      },
    "flower_power": {
        "title"  : LocalizeText("Flower Power") + " |img src='emojis/star.png' scale=0.5 offset=2|",
        "text"   : LocalizeText("Enables collecting exotic flowers."),
        "dlc"    : "DLC2",
      },
    "grab_material": {
        "title"  : LocalizeText("Grab material"),
        "text"   : LocalizeText("Pick up ignored materials manually when auto-collect is disabled on them."),
      },
    "build_on_ground": {
        "title"  : LocalizeText("Build on ground"),
        "text"   : LocalizeText("Build Workbenches, Kitchen Stoves, Planters directly on the ground, without a platform."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-build-on-ground-video")}],
      },
    "console_dupes": {
        "title"  : LocalizeText("Console duplicates"),
        "text"   : LocalizeText("Developer console does not hide duplicate lines any more, saving you to put NX_GetTime().tostring() on every line."),
      },
    "mods_ui": {
        "title"  : LocalizeText("Mods UI tweaks"),
        "text"   : LocalizeText("Better workflow for mod developers with a few small changes on the Mods UI. More compact and highlights important info."),
      },
    "event_log": {
        "title"  : LocalizeText("Event Log"),
        "text"   : LocalizeText("Replay the path you walked from the start with the vanilla Game Event Log on the Collection tab."),
      },
    "nonlinear_volume": {
        "title"  : LocalizeText("Non-linear volume"),
        "text"   : LocalizeText("Easier to fine-tune adjust low volume ranges on the non-linear scaled volume sliders in the Audio Settings."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-nonlinear-volume-video")}],
      },
    "touchable_refiner": {
        "title"  : LocalizeText("Touchable refiner"),
        "text"   : LocalizeText("Fix the add/remove buttons on the refiner UI being too small for mobile screens."),
      },
    "pet_pointer": {
        "title"  : LocalizeText("Pet pointer") + " |img src='emojis/star.png' scale=0.5 offset=2|",
        "text"   : LocalizeText("Shows the reward pet, recipe or dish for the Buried Teleporters in the Pet Hub."),
        "dlc"    : "DLC3",
      },
    "pocket_pets_forever": {
        "title"  : LocalizeText("Pocket pets forever") + " |img src='emojis/star.png' scale=0.5 offset=2|",
        "text"   : LocalizeText("Upgrade the pocket ball to increase the time spawned pets are alive. To despawn them, rest at a campfire."),
        "dlc"    : "DLC3",
      },
    "allow_99_percent_pois": {
        "title"  : LocalizeText("Allow 99% POIs") + " |img src='emojis/star.png' scale=0.5 offset=2|",
        "text"   : LocalizeText("Ignore the Underworld completion POIs when counting towards 100% achievement."),
        "dlc"    : "DLC1",
      },
    "tall_mushrooms": {
        "title"  : LocalizeText("Tall mushrooms"),
        "text"   : LocalizeText("Raise mushroom gatherables higher above the ground to be more noticable."),
      },
    "reveal_teleporters": {
        "title"  : LocalizeText("Reveal teleporters") + " |img src='emojis/star.png' scale=0.5 offset=2|",
        "text"   : LocalizeText("Break the ground where the Buried Teleporters are without the pets having to find them. Requires Sonar Toolkit."),
        "dlc"    : "DLC3",
      },
    "fast_weapon_switch": {
        "title"  : LocalizeText("Fast weapon switch"),
        "text"   : LocalizeText("Cycle your primary weapon tools without that short lag, switch to your 3rd tool faster."),
      },
    "booksmart_pets": {
        "title"  : LocalizeText("Booksmart pets") + " |img src='emojis/star.png' scale=0.5 offset=2|",
        "text"   : LocalizeText("Ignore readable objects when pets are looking for what to attack."),
        "dlc"    : "DLC3",
      },
    "loudspeaker_no_friendly_fire": {
        "title"  : LocalizeText("Loudspeaker no friendly fire"),
        "text"   : LocalizeText("No more accidental drive-by from your melee weapons, they cannot damage the Shelter loudspeakers."),
      },
    "cut_gatherables": {
        "title"  : LocalizeText("Cut gatherables"),
        "text"   : LocalizeText("Slash mushrooms, all berry bushes and flowers with melee weapons, don't have to pick them manually."),
      },
    "hunting_knives": {
        "title"  : LocalizeText("Hunting knives"),
        "text"   : LocalizeText("Increases the damage dealt by knives against animals, to one-shot deer."),
      },
    "fix_from_storage": {
        "title"  : LocalizeText("Fix from storage"),
        "text"   : LocalizeText("Activate Ropebridges, Terminals, Obelisks, Mana Chambers, Wishing Wells with materials from your Campfire Storage Box."),
      },
    "wild_crops": {
        "title"  : LocalizeText("Wild crops"),
        "text"   : LocalizeText("Neglected plant beds have a chance to get a wild crop grow randomly, so you can not lock yourself out of inventing dishes."),
      },
    "easier_gathering": {
        "title"  : LocalizeText("Easier gathering"),
        "text"   : LocalizeText("Gather and search faster and farther, the interaction only needs a button press and can be done from 2x the range away."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-easier-gathering-video")}],
      },
    "minimap_extra": {
        "title"  : LocalizeText("Minimap extra"),
        "text"   : LocalizeText("Reveal nearby turrets, flowers, diggables, eggs, workbenches, refiners on the minimap. Adds keys, items, dishes, flowers, Night Terrors, refiners to the world map."),
        "buttons": [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
            "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-minimap-extra-video")}],
      },
    "target_pets": {
        "title"  : LocalizeText("Target pets") + " |img src='emojis/star.png' scale=0.5 offset=2|",
        "text"   : LocalizeText("Your pets and deer will attack the monster you are targetting."),
        "dlc"    : "DLC3",
      },
    "trophies": {
        "title"  : LocalizeText("Trophies"),
        "text"   : LocalizeText("Get a trophy after defeating bosses. You can place it your house as a buildable 3D object.")
            + "\n\n" + LocalizeText("Model posing was done by ariannadiangelo, thanks!"),
      },
    "dodge_cliffs": {
        "title"  : LocalizeText("Dodge cliffs"),
        "text"   : LocalizeText("Stop accidentally dodge rolling into the water off the cliffs because of the auto-targetting."),
      },
    "heavy_keys": {
        "title"  : LocalizeText("Heavy keys"),
        "text"   : LocalizeText("Ground flying key collectibles by increasing the gravity affecting it, so it won't get stuck at unreachable places."),
      },
    "bypass_catacomb": {
        "title"  : LocalizeText("Bypass catacomb") + " |img src='emojis/star.png' scale=0.5 offset=2|",
        "text"   : LocalizeText("Skip tracking back through the catacombs when you go from the Underworld to the main island."),
        "dlc"    : "DLC1",
      },
    "ark_single_deposit": {
        "title"  : LocalizeText("Ark single deposit"),
        "text"   : LocalizeText("Bulk dump the required number of materials into an Ark container."),
      },
    "capernaum_shortcut": {
        "title"  : LocalizeText("Capernaum shortcut"),
        "text"   : LocalizeText("Open up the path to south by exploding the shipping container with barrels."),
      },
    "sound_muffler": {
        "title"  : LocalizeText("Sound muffler"),
        "text"   : LocalizeText("Lowers the volume of annoying, overwhelming or triggering sound effects.")
            + "\n\nIncludes: mana hum, eat, drink, exhale, death, grunts, rustle, swinging, refiners, pets, monkeys, coyotes, birds, headscratch, material hits, air raid siren",
      },
    "snowfall": {
        "title"  : LocalizeText("Snowfall"),
        "text"   : LocalizeText("Immerse yourself in the winter landscape with drifting snow and howling winds."),
      },
    "restless_crates": {
        "title"  : LocalizeText("Restless crates"),
        "text"   : LocalizeText("Skip resting at the campfires to open timed crates, going near one is enough to reset the timer.")
            + "\n" + LocalizeText("Needs at least 1 crate already opened."),
      },
    "ostrich_nests": {
        "title"  : LocalizeText("Ostrich nests"),
        "text"   : LocalizeText("Enlarge bird nests to make them more visible."),
      },
    "extract_barrier": {
        "title"  : LocalizeText("Extract barrier"),
        "text"   : LocalizeText("Blocks you from leaving the Law and Sword mech boss arenas without extracting the Fuel Cell."),
      },
    "explode_shards": {
        "title"  : LocalizeText("Explode shards"),
        "text"   : LocalizeText("Apply explosive damage to all mana prop shard objects in the world."),
      },
    "planter_basics": {
        "title"  : LocalizeText("Planter basics"),
        "text"   : LocalizeText("Unlocks the Planter buildable and the Builder's Kit when completing the Farming Basics quest."),
      },
    "quest_fixes": {
        "title"  : LocalizeText("Quest fixes"),
        "text"   : LocalizeText("Various bugfixes for the quests."),
      },
    "did_i_dieded": {
        "title"  : LocalizeText("Did i dieded?"),
        "text"   : LocalizeText("Keeps showing your death counter even if you did not die yet."),
      },
    "link_gas_leaks": {
        "title"  : LocalizeText("Link gas leaks"),
        "text"   : LocalizeText("Parent orphan gas clouds to their nearby pipes or barrels, so they will disappear."),
      },
    "big_inventions": {
        "title"  : LocalizeText("Big inventions"),
        "text"   : LocalizeText("Enlarge icons on campfire invention screen to fill the empty space."),
      },
    "tabula_rasa_farms": {
        "title"  : LocalizeText("Tabula Rasa farms"),
        "text"   : LocalizeText("Adds 2 farmlands in the northwest and southeast corner of Tabula Rasa."),
      },
    "walkable_ark": {
        "title"  : LocalizeText("Walkable Ark"),
        "text"   : LocalizeText("Clear the walkable path of Ark containers on completion."),
      },
  };


Include ("scripts/mods/mods-info.nut");


function Mod_QualityOfLife_OnClick_OptionsUnified (clicked) {
  if (clicked != null && clicked.len() > 4 + 6 && clicked.slice(0, 4) == "mod_" && clicked.slice(clicked.len() - 6) == "_title") {
    local mod_name = clicked.slice(4, clicked.len() - 6);
    if (mod_infos.rawin(mod_name) == true) {
      local mod_data = mod_infos[mod_name];
      local buttons = [];
      if (mod_data.rawin("buttons") == true) {
        buttons = mod_data["buttons"];
      }
      Mods_Info_Popup (LocalizeText(mod_data.title), LocalizeText(mod_data.text), buttons);
    }
  }
}


function Mod_QualityOfLife_OnEnter_OptionsUnified (stage_in_stack) {
  if (Game_GetWorldState ("MODS", "quality_of_life_used") != "1") {
    Game_SetWorldState ("MODS", "quality_of_life_used", "1");
  }
  UI_SetVisible ("mods_incompatibility", false);
  UI_SetVisible ("mods_notingame", stage_in_stack == true ? false : true);
  UI_SetVisible ("mods_notingame_spacer", stage_in_stack == true ? false : true);
  UI_SetVisible ("mod_quality_of_life_title", stage_in_stack == true ? true : false);
  UI_SetProperty ("mod_quality_of_life_navigation_accordion", "accordion.text_left", "    |img src='ui/gfx/mods/mod-quality-of-life.png' scale=0.05 offset=2|  Navigation");
  UI_SetVisible ("mod_quality_of_life_navigation_accordion", stage_in_stack == true ? true : false);
  UI_SetProperty ("mod_quality_of_life_traversal_accordion", "accordion.text_left", "    |img src='ui/gfx/mods/mod-quality-of-life.png' scale=0.05 offset=2|  Traversal");
  UI_SetVisible ("mod_quality_of_life_traversal_accordion", stage_in_stack == true ? true : false);
  UI_SetProperty ("mod_quality_of_life_weapons_accordion", "accordion.text_left", "    |img src='ui/gfx/mods/mod-quality-of-life.png' scale=0.05 offset=2|  Weapons");
  UI_SetVisible ("mod_quality_of_life_weapons_accordion", stage_in_stack == true ? true : false);
  UI_SetProperty ("mod_quality_of_life_completionist_accordion", "accordion.text_left", "    |img src='ui/gfx/mods/mod-quality-of-life.png' scale=0.05 offset=2|  Completionist");
  UI_SetVisible ("mod_quality_of_life_completionist_accordion", stage_in_stack == true ? true : false);
  UI_SetProperty ("mod_quality_of_life_animals_accordion", "accordion.text_left", "    |img src='ui/gfx/mods/mod-quality-of-life.png' scale=0.05 offset=2|  Animals");
  UI_SetVisible ("mod_quality_of_life_animals_accordion", stage_in_stack == true ? true : false);
  UI_SetProperty ("mod_quality_of_life_other_accordion", "accordion.text_left", "    |img src='ui/gfx/mods/mod-quality-of-life.png' scale=0.05 offset=2|  Other");
  UI_SetVisible ("mod_quality_of_life_other_accordion", stage_in_stack == true ? true : false);
  UI_SetProperty ("mod_quality_of_life_difficulty_accordion", "accordion.text_left", "    |img src='ui/gfx/mods/mod-quality-of-life.png' scale=0.05 offset=2|  Difficulty");
  UI_SetVisible ("mod_quality_of_life_difficulty_accordion", stage_in_stack == true ? true : false);
  UI_SetProperty ("mod_quality_of_life_alwayson_accordion", "accordion.text_left", "    |img src='ui/gfx/mods/mod-quality-of-life.png' scale=0.05 offset=2|  Always active");
  if (NX_ProductFeatureExists ("MOBILE_UI") == true) {
    UI_SetProperty ("mod_quality_of_life_alwayson", "aligner.fixed_num_columns", 2);
  }
  UI_SetVisible ("mod_quality_of_life_alwayson_accordion", stage_in_stack == true ? true : false);
  foreach (mod_name, mod_data in mod_infos) {
    local modpack = mod_data.rawin("modpack") == true ? mod_data.rawget("modpack") : null;
    if (modpack != true && NX_ProductFeatureExists ("MOBILE_UI") == true) {
      UI_SetProperty ("mod_" + mod_name + "_title", "scale", 1.0);
    }
    UI_SetProperty ("mod_" + mod_name + "_title", "textbox.text", mod_data.title);
    local dlc = mod_data.rawin("dlc") == true ? mod_data.rawget("dlc") : null;
    if (dlc != null && IAP_IsItemPurchased (dlc) != true) {
      UI_SetVisible ("mod_" + mod_name + "_title", false);
    }
  }
  UI_SetVisible ("mod_quality_of_life_bottom_spacer", stage_in_stack == true ? true : false);
  UI_SetVisible ("mods_info", stage_in_stack == true ? true : false);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
