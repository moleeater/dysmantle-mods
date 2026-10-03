// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local is_mark_map = false;
local bitmap_cross = null;
local bitmap_black = null;
local cellsize = 60.0;
local stage_attribute = "";
local stage_info = null;
local stage_width = 0;
local triggering_player_index = 0;
local player_bitmap = null;
local players = [
    { "obj": null, "position": null, "angle": null },
    { "obj": null, "position": null, "angle": null },
  ];
local player = null;
local item_id = null;


Include ("scripts/mods/mods-info.nut");


function Mod_MarkChunk_OnMetadataRead_Special() {
  return {
      icon = "items/specials/mod-mark-chunk.png"
      name = "Mark chunk |img src='emojis/package.png' scale=1.3 offset=2|"
      description = "|img src='emojis/package.png' scale=0.7 offset=2| Leave a big X mark on the map to know which map chunk you completed."
      use_description = "Show the stage map."
      use_description_long_press = "Mark the chunk you are standing in."
      destroy_after_owner_death = true
    };
}


function Mod_MarkChunk_OnMetadataRead_Tool() {
  local metadata = Mod_MarkChunk_OnMetadataRead_Special();
  metadata.type <- "melee_weapon";
  metadata.stance <- "hands_free";
  metadata.prop <- "actors/objects/lab_book_opened.xml";
  metadata.prop_bone <- "tool";
  metadata.prop_mount_scale <- 0.6;
  metadata.prop_mount_angle_x <- 175;
  metadata.prop_mount_offset_x <- -1;
  metadata.prop_mount_offset_y <- 1;
  metadata.prop_mount_offset_z <- 2;
  return metadata;
}


function Mod_MarkChunk_IsPossibleToUse_Item() {
  local not_here = true;
  local stage = Stage_GetFilename();
  if (stage != null) {
    not_here = false;
    local stage_info = Stage_GetExternalStageInfo (stage);
    if (stage_info == null) {
      not_here = true;
    } else if (stage_info.rawin("width_in_cells") != true || stage_info.rawin("height_in_cells") != true
    || (stage_info.rawget("width_in_cells") < 400 && stage_info.rawget("height_in_cells") < 400)) {
      not_here = true;
    }
  }
  return ! not_here;
}


function Mod_MarkChunk_OnTriggerClick_Item() {
  if (! Mod_MarkChunk_IsPossibleToUse_Item()) {
    if (Actor_IsAnimationPlaying (player, "not_here") != true) {
      Actor_QueueActionPlayAnimationWithParameters (player, "not_here", 1.0, 0.0, true);
    }
  } else {
    UI_SendScreenMessage ("MapPopup", "Mode", "MOD_MARK_CHUNK");
    local player_index = Game_GetPlayerIndexByActor (player);
    if (player_index == null) player_index = 0;
    UI_SendScreenMessage ("MapPopup", "mod_mark_chunk_player_index_message", player_index.tostring());
    Game_ShowMapPopup (LocalizeText("Old marks only appear after you move close to the chunk once."), null);
  }
}


function Mod_MarkChunk_OnTriggerHoldDown_Item() {
  if (! Mod_MarkChunk_IsPossibleToUse_Item()) {
    if (Actor_IsAnimationPlaying (player, "not_here") != true) {
      Actor_QueueActionPlayAnimationWithParameters (player, "not_here", 1.0, 0.0, true);
    }
  } else {
    if (Actor_IsAnimationPlaying (player, "acquired_new_tool") != true) {
      Actor_QueueActionPlayAnimationWithParameters (player, "acquired_new_tool", 2.0, 0.0, false);
    }
    local cellsize = Stage_GetCellSize();
    local player_position = StageObject_GetStagePosition (player);
    if (player_position != null) {
      local chunk_x = floor(player_position[0].tofloat() / cellsize.tofloat() / 20.0);
      local chunk_y = floor(player_position[1].tofloat() / cellsize.tofloat() / 20.0);
      local mark_x = (chunk_x.tofloat() + 0.5) * cellsize.tofloat() * 20.0;
      local mark_y = (chunk_y.tofloat() + 0.5) * cellsize.tofloat() * 20.0;
      local mark_z = 0.0;
      local perm_mark = Stage_QueryNearestActorWithType (mark_x, mark_y, mark_z, 1, "actors/mods/mod-mark-chunk.xml");
      if (perm_mark == null) {
        perm_mark = Game_CreatePersistentActor ("actors/mods/mod-mark-chunk.xml", mark_x, mark_y, mark_z, 0.0, 1.0);
      } else {
        local chunk_state_id = string_replace (string_replace (Stage_GetFilename(), "-", "_"), "/", "__") + "___" + chunk_y.tostring();
        local chunkstr = Game_GetWorldState ("MOD_MARK_CHUNK", chunk_state_id);
        if (chunkstr == null) chunkstr = "";
        local chunks = split(chunkstr, ",").map(@(value) value.tointeger());
        local chunk_index = chunks.find(chunk_x);
        if (chunk_index != null) {
          chunks.remove(chunk_index);
          chunkstr = chunks.reduce(@(first, next) (first == null ? "" : first) + (next == null ? "" : "," + next));
          if (chunkstr == null) chunkstr = "";
          if (typeof chunkstr != "string") chunkstr = chunkstr.tostring();
          Game_SetWorldState ("MOD_MARK_CHUNK", chunk_state_id, chunkstr);
        }
        Stage_DeleteStageObjectQueued (perm_mark);
      }
    }
  }
}


function Mod_MarkChunk_OnInitialize_Item (so_handle_owner, id) {
  player = so_handle_owner;
  item_id = id;
  return true;
}


function Mod_MarkChunk_OnGameStart_PermanentMark (perm_mark, same) {
  local position = StageObject_GetStagePosition (perm_mark);
  if (position != null) {
    local poi_marks = Stage_QueryActorsWithTypeInRadius (position[0], position[1], position[2], 1.0, "actors/mods/mod-mark-chunk-poi.xml");
    if (poi_marks != null && poi_marks.len() > 0) {
      foreach (poi_mark in poi_marks) {
        Stage_DeleteStageObjectQueued (poi_mark);
      }
    }
  }
  if (Game_GetWorldStateAsInteger ("MODS", "mark_chunk_enabled", 0) == 1) {
    local poi_mark = Stage_CreateActor ("actors/mods/mod-mark-chunk-poi.xml", 0.0, 0.0, 0.0, false);
    StageObject_SetParent (poi_mark, perm_mark);
  }
  if (position != null) {
    local stage = Stage_GetFilename();
    if (stage != null) {
      local cellsize = Stage_GetCellSize();
      local chunk_x = floor(position[0].tofloat() / cellsize.tofloat() / 20.0);
      local chunk_y = floor(position[1].tofloat() / cellsize.tofloat() / 20.0);
      local chunk_state_id = string_replace (string_replace (stage, "-", "_"), "/", "__") + "___" + chunk_y.tostring();
      local chunkstr = Game_GetWorldState ("MOD_MARK_CHUNK", chunk_state_id);
      if (chunkstr == null) chunkstr = "";
      local chunks = split(chunkstr, ",").map(@(value) value.tointeger());
      if (chunks.find(chunk_x) == null) {
        chunks.append(chunk_x);
        chunks.sort();
        chunkstr = chunks.reduce(@(first, next) (first == null ? "" : first) + (next == null ? "" : "," + next));
        if (chunkstr == null) chunkstr = "";
        if (typeof chunkstr != "string") chunkstr = chunkstr.tostring();
        Game_SetWorldState ("MOD_MARK_CHUNK", chunk_state_id, chunkstr);
      }
    }
  }
}


function Mod_MarkChunk_OnDeathStart_PermanentMark (perm_mark, same) {
  local position = StageObject_GetStagePosition (perm_mark);
  if (position != null) {
    local poi_marks = Stage_QueryActorsWithTypeInRadius (position[0], position[1], position[2], 1.0, "actors/mods/mod-mark-chunk-poi.xml");
    if (poi_marks != null && poi_marks.len() > 0) {
      foreach (poi_mark in poi_marks) {
        Stage_DeleteStageObjectQueued (poi_mark);
      }
    }
  }
}


function Mod_MarkChunk_OnDraw_MapPopup() {
  if (is_mark_map == true) {
    local map_position = UI_GetComponentPositionOnScreen ("Map");
    local map_width = UI_GetProperty ("Map", "width");
    local map_height = UI_GetProperty ("Map", "height");
    if (stage_info != null) {
      if (stage_info.rawin("width_in_cells") == true && stage_info.rawin("height_in_cells") == true
      && (stage_info.rawget("width_in_cells") > 400 || stage_info.rawget("height_in_cells") > 400)
      && map_position != null && map_width != null && map_height != null && bitmap_cross != null) {
        local map_x = map_position[0];
        local map_y = map_position[1];
        local bitmap_size = map_width.tofloat() / stage_info.width_in_cells.tofloat() * 20.0;
        for (local chunk_y = 0; chunk_y < stage_width; chunk_y++) {
          local chunk_state_id = stage_attribute + "___" + chunk_y.tostring();
          local chunkstr = Game_GetWorldState ("MOD_MARK_CHUNK", chunk_state_id);
          if (chunkstr == null) chunkstr = "";
          local chunks = split(chunkstr, ",").map(@(value) value.tointeger());
          foreach (chunk_x in chunks) {
            local bitmap_x = map_x + chunk_x.tofloat() * 20.0 / stage_info.width_in_cells.tofloat() * map_width.tofloat();
            local bitmap_y = map_y + chunk_y.tofloat() * 20.0 / stage_info.height_in_cells.tofloat() * map_height.tofloat();
            NX_SetColor (0.0, 0.0, 0.0);
            NX_SetAlpha (0.6);
            NX_DrawRect (bitmap_x, bitmap_y, bitmap_size, bitmap_size);
            NX_SetColor (1.0, 1.0, 1.0);
            NX_DrawBitmapStretched (bitmap_cross, bitmap_x, bitmap_y, bitmap_size, bitmap_size, 0.4);
          }
        }
        if (player_bitmap != null) {
          foreach (player_index in [triggering_player_index == 0 ? 1 : 0, triggering_player_index]) {
            if (players[player_index].obj != null && players[player_index].position != null && players[player_index].angle != null) {
              local player_x = map_x + players[player_index].position[0].tofloat() / cellsize.tofloat() / stage_info.width_in_cells.tofloat() * map_width.tofloat();
              local player_y = map_y + players[player_index].position[1].tofloat() / cellsize.tofloat() / stage_info.height_in_cells.tofloat() * map_height.tofloat();
              if (Game_GetPlayerActor (1) == null) {
                NX_SetColor (1.0, 1.0, 1.0);
              } else {
                switch (player_index) {
                  case 0: NX_SetColor (0.4, 0.6, 1.0); break;
                  case 1: NX_SetColor (1.0, 0.5, 0.4); break;
                }
              }
              NX_DrawBitmapRS (player_bitmap, player_x, player_y, m_anglemod (players[player_index].angle * PI / 180.0), map_width.tofloat() / stage_info.width_in_cells.tofloat() / 2.0);
            }
          }
        }
      }
    }
  }
}


function Mod_MarkChunk_OnScreenMessage_MapPopup (key, value) {
  if (key != null) {
    switch (key) {
      case "Mode":
        if (value == "MOD_MARK_CHUNK") {
          is_mark_map = true;
        }
        break;
      case "mod_mark_chunk_player_index_message":
        triggering_player_index = value.tointeger();
        break;
    }
  }
}


function Mod_MarkChunk_OnEnter_MapPopup() {
  if (is_mark_map == true) {
    UI_SetActiveScreenProperty ("enter_duration", 0);
    UI_SetActiveScreenProperty ("leave_duration", 0);
    bitmap_cross = NX_GetBitmap ("emojis/cross mark.png");
    cellsize = Stage_GetCellSize();
    local stage = Stage_GetFilename();
    if (stage != null) {
      stage_attribute = string_replace (string_replace (stage, "-", "_"), "/", "__");
      stage_info = Stage_GetExternalStageInfo (stage);
      if (stage_info != null) {
        if (stage_info.rawin("width_in_cells") == true) {
          stage_width = ceil(stage_info.width_in_cells.tofloat() / 20.0);
        }
      }
    }
    player_bitmap = NX_GetBitmap ("map/icon-player-position.png");
    foreach (player_index in [0,1]) {
      players[player_index].obj = Game_GetPlayerActor (player_index);
    }
    foreach (player_index, player_data in players) {
      if (player_data.obj != null) {
        player_data.position = StageObject_GetStagePosition (player_data.obj);
        player_data.angle = StageObject_GetAngle (player_data.obj);
      }
    }
    if (Game_IsRecipeCrafted ("MOD_MARK_CHUNK_SPECIAL") != true) {
      Game_CraftRecipe ("MOD_MARK_CHUNK_SPECIAL", true);
    }
  }
}


function Mod_MarkChunk_OnLeave_MapPopup() {
  is_mark_map = false;
  UI_SetActiveScreenProperty ("enter_duration", 0.33);
  UI_SetActiveScreenProperty ("leave_duration", 0.33);
}


function Mod_MarkChunk_OnClick_OptionsUnified (clicked) {
  if (clicked != null) {
    switch (clicked) {
      case "mod_mark_chunk_craft":
        if (Game_IsRecipeCrafted ("MOD_MARK_CHUNK") != true) {
          Game_CraftRecipe ("MOD_MARK_CHUNK", true);
        }
        if (Game_IsRecipeCrafted ("MOD_MARK_CHUNK_SPECIAL") != true) {
          Game_CraftRecipe ("MOD_MARK_CHUNK_SPECIAL", false);
        }
        if (Game_IsRecipeCrafted ("MOD_MARK_CHUNK") == true) {
          UI_SetVisible ("mod_mark_chunk_craft", false);
          UI_SetVisible ("mod_mark_chunk_enabled", true);
          Game_SetWorldState ("MODS", "mark_chunk_enabled", "1");
          UI_SetProperty ("mod_mark_chunk_enabled", "checkbox.value", 1);
        }
        break;
      case "mod_mark_chunk_enabled":
        local enabled = UI_GetProperty (clicked, "checkbox.value") == 1 ? true : false;
        Game_SetWorldState ("MODS", "mark_chunk_enabled", enabled ? "1" : "0");
        local poi_marks = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, "MOD_MARK_CHUNK_POI");
        if (poi_marks != null && poi_marks.len() > 0) {
          foreach (poi_mark in poi_marks) {
            Stage_DeleteStageObjectQueued (poi_mark);
          }
        }
        if (enabled) {
          local perm_marks = Stage_QueryStageObjectsWithTag (STAGE_OBJECT_TYPE_ACTOR, "MOD_MARK_CHUNK");
          if (perm_marks != null && perm_marks.len() > 0) {
            foreach (perm_mark in perm_marks) {
              local poi_mark = Stage_CreateActor ("actors/mods/mod-mark-chunk-poi.xml", 0.0, 0.0, 0.0, false);
              StageObject_SetParent (poi_mark, perm_mark);
            }
          }
        }
        break;
      case "mod_mark_chunk_title":
        Mods_Info_Popup (
            LocalizeText("Mark chunk"),
            LocalizeText("Check grids off with an X mark on the map to know which part you've completed. A help for your OCPD."),
            [{"text": "|#ffffff||img src='ui/gfx/mods/mods-videos-youtube.png' scale=0.5 offset=1||#000000| demonstration",
              "OpenURL": LocalizeText("https://e934.short.gy/dysmantle-mod-mark-chunk-video")}] );
        break;
    }
  }
}


function Mod_MarkChunk_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetProperty ("mod_mark_chunk_enabled", "checkbox.value", Game_GetWorldStateAsInteger ("MODS", "mark_chunk_enabled", 0));
  UI_SetProperty ("mod_mark_chunk_title", "textbox.text", LocalizeText("Mark chunk"));
  UI_SetProperty ("mod_mark_chunk_craft", "button.text", LocalizeText("Craft"));
  local crafted = Game_IsRecipeCrafted ("MOD_MARK_CHUNK") == true ? true : false;
  UI_SetVisible ("mod_mark_chunk_craft", crafted ? false : true);
  UI_SetVisible ("mod_mark_chunk_enabled", crafted ? true : false);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
