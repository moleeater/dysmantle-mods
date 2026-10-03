// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
if (NX_FileExists ("actors/collectibles/tarot.xml") || NX_FileExists ("scripts/interactions/tarot.nut") || NX_FileExists ("ui/tarot_templates.xml")
|| NX_FileExists ("ui/collectibles/tarotcard.nut") || NX_FileExists ("ui/collectibles/tarotcard.xml")
|| NX_FileExists ("actors/interactives/farming-mushroom_brown.xml") || NX_FileExists ("docs://Mega Quality Of Life Balance Mod/mod-info.xml")
|| NX_FileExists ("ugc://3711913031/mod-info.xml") || NX_FileExists ("ugc://3703339560/mod-info.xml")) return null;


local durations = [
    { "unit": "years"  , "seconds": 365.0 * 24.0 * 60.0 * 60.0 },
    { "unit": "months" , "seconds": 30.0 * 24.0 * 60.0 * 60.0 },
    { "unit": "weeks"  , "seconds": 7.0 * 24.0 * 60.0 * 60.0 },
    { "unit": "days"   , "seconds": 24.0 * 60.0 * 60.0 },
    { "unit": "hours"  , "seconds": 60.0 * 60.0 },
    { "unit": "minutes", "seconds": 60.0 },
    { "unit": "seconds", "seconds": 1.0 },
  ];


function Mods_Changelog_OnClick_OptionsUnified (clicked) {
  if (clicked == "mods_changelog") {
    UI_PushScreen ("VersionNotes");
  }
}


function Mods_Changelog_OnEnter_OptionsUnified (stage_in_stack) {
  UI_SetVisible ("mods_changelog_spacer", true);
  UI_SetVisible ("mods_changelog", true);
}


function Mods_Changelog_OnEnter_VersionNotes() {
  local hide_vanilla = UI_IsScreenInStack ("OptionsUnified") == true ? true : false;
  local is_mobile = NX_ProductFeatureExists ("MOBILE_UI") == true ? true : false;
  UI_SetVisible ("panel", hide_vanilla == true ? false : true);
  if (this.rawin("UI_CreateComponent") != true) {
    Engine_Warning("mod ERROR: update your game to at least v1.4.0.40");
  } else {
    UI_SetProperty ("panel", "position.x", 0.305);
    UI_SetProperty ("TF", "touchfield.area_width", 620);
    UI_SetProperty ("aligner_1", "position.x", -0.517);
    UI_SetProperty ("TF_upper", "position.x", -0.49);
    UI_SetProperty ("panel_upper", "position.x", -0.506);
    local components = [
        {
          "name": "mods_changelog_panel",
          "inherit": "DecayNinePatchPanel",
          "align": NX_ALIGN_VCENTER | NX_ALIGN_HCENTER,
          "position.y": 0.4988,
          "position.x": hide_vanilla ? 0.5 : 0.795,
          "ninepatch.rectangle_height": 608,
          "ninepatch.rectangle_width": hide_vanilla ? is_mobile ? 1000 : 671 : 445,
        },
        {
          "parent": "mods_changelog_panel", "name": "mods_changelog_title",
          "inherit": "SmallTextbox",
          "align": NX_ALIGN_VCENTER | NX_ALIGN_HCENTER,
          "scale": 1.3,
          "position.y": -0.44,
          "shader_effect": "FontBlackShadowOutline",
          "textbox.text_align": 12,
          "textbox.textbox_width": hide_vanilla ? 480 : 310,
          "textbox.text": "|img src='emojis/package.png' scale=0.6 offset=2| " + LocalizeText("Mods") + (hide_vanilla ? " " + LocalizeText("Change Log") : ""),
          "localize": false,
        },
        {
          "parent": "mods_changelog_panel", "name": "mods_changelog_innerpanel",
          "inherit": "DecayNinePatchPanelInner",
          "align": NX_ALIGN_HCENTER,
          "scale": 0.84,
          "position.y": -0.409,
          "ninepatch.rectangle_height": 642,
          "ninepatch.rectangle_width": hide_vanilla ? is_mobile ? 1155 : 769 : 498,
        },
        {
          "parent": "mods_changelog_panel", "name": "mods_changelog_touch",
          "inherit": "DefaultTouchField",
          "align": NX_ALIGN_HCENTER,
          "position.y": -0.385,
          "touchfield.area_height": 510,
          "touchfield.area_width": hide_vanilla ? is_mobile ? 940 : 630 : 400,
          "touchfield.automatic_content_height": true,
          "touchfield.content_width": hide_vanilla ? is_mobile ? 930 : 610 : 300,
          "touchfield.clip_children": true,
          "touchfield.axis_x_enabled": false,
          "touchfield.gamepad_scroll_speed": 200,
          "touchfield.bm_scroll_indicator": "ui/gfx/scroll-indicator.png",
        },
        {
          "parent": "mods_changelog_innerpanel", "name": "mods_changelog_scrollbar",
          "inherit": "EditorSliderScrollbar",
          "align": NX_ALIGN_VCENTER | NX_ALIGN_RIGHT,
          "scale": 1.18,
          "position.x": hide_vanilla && is_mobile ? 0.485 : 0.48,
          "position.y": 0.5,
          "slider.linked_view": "mods_changelog_touch",
          "slider.ninepatch_height": 520,
          "slider.hide_full_scrollbars": true,
        },
        {
          "parent": "mods_changelog_touch", "name": "mods_changelog_aligner",
          "inherit": "EditorAligner",
          "position.x": hide_vanilla && is_mobile ? -0.49 : -0.477,
          "align": 0,
          "aligner.area_width": 1,
          "aligner.layout": 1,
          "aligner.align_x_axis": true,
          "aligner.align_y_axis": true,
          "aligner.min_padding": 28,
          "aligner.automatic_area_height": true,
        },
      ];
    local files = NX_FindFiles ("", "mod*-changelog.xml", false);
    if (files != null && files.len() > 0) {
      local now = NX_GetTimeSecondsElapsedSinceEpoch();
      local changes = [];
      foreach (file in files) {
        local mod_title = DM_GetArrayNodeValue (file, "INFO", "title", "value");
        if (mod_title == null && file.len() > 18) {
          mod_title = file.slice(0, file.len() - 14);
        }
        local thumb = DM_GetArrayNodeValue (file, "INFO", "thumb", "value");
        local node_num = DM_GetArrayNumberOfNodes (file, "CHANGELOG");
        if (node_num != null) {
          for (local node_index = 0; node_index < node_num; node_index++) {
            local epoch = DM_GetArrayNodeValue (file, "CHANGELOG", node_index, "epoch");
            if (epoch == null) epoch = 0;
            epoch = epoch.tointeger();
            if (epoch > now) epoch = 0;
            local ago = null;
            if (epoch != 0) {
              foreach (duration in durations) {
                local amount = floor((now.tofloat() - epoch.tofloat()).tofloat() / duration.seconds.tofloat());
                if (amount >= 2) {
                  ago = { "amount": amount, "unit": duration.unit };
                  break;
                }
              }
            }
            local version = DM_GetArrayNodeValue (file, "CHANGELOG", node_index, "id");
            if (version != null) {
              version = "v" + version;
            }
            local text = DM_GetArrayNodeValue (file, "CHANGELOG", node_index, "value");
            if (text != null && text.len() > 0) {
              if (text.slice(0, 1) == "\n") {
                text = text.slice(1);
              }
              if (text.len() > 0 && text.slice(text.len() - 1) == "\n") {
                text = text.slice(0, text.len() - 1);
              }
              changes.push({
                  "epoch": epoch,
                  "ago": ago,
                  "mod": mod_title,
                  "thumb": thumb,
                  "version": version,
                  "text": text,
                });
            }
          }
        }
      }
      if (changes.len() > 0) {
        changes.sort(@(first, second) first.epoch > second.epoch ? -1 : first.epoch < second.epoch ? 1 : first.mod > second.mod ? 1 : first.mod < second.mod ? -1 : 0);
        foreach (change_index, change in changes) {
          components.push(
            {
              "parent": "mods_changelog_aligner", "name": "mods_changelog_" + change_index.tostring(),
              "inherit": "SmallTextbox",
              "scale": hide_vanilla && is_mobile ? 1 : 0.65,
              "textbox.textbox_width": hide_vanilla ? 910 : 580,
              "shader_effect": "FontBlackShadowOutline",
              "localize": false,
              "textbox.text": "|#ff3333|"
                  + (change.thumb != null ? change.thumb : "")
                  + LocalizeText(change.mod)
                  + (change.version != null ? "    " + change.version : "")
                  + (change.ago != null ? "     " + string_replace(LocalizeText(string_replace("[AMOUNT] [UNIT] ago", "[UNIT]", change.ago.unit)), "[AMOUNT]", change.ago.amount) : "")
                  + "|#ffffff|\n\n" + change.text,
            });
        }
      }
    }
    components.push(
      {
        "parent": "mods_changelog_aligner", "name": "mods_changelog_spacer",
        "inherit": "DefaultMarker",
        "align": NX_ALIGN_HCENTER,
        "marker.area_width": 1,
        "marker.area_height": 48,
      });
    foreach (component_index, component in components) {
      if (UI_GetProperty (component.name, "name") != component.name) {
        UI_CreateComponent (component.name, component.inherit);
      }
      foreach (property, value in component) {
        switch (property) {
          case "name":
          case "inherit":
            break;
          default:
            if (typeof value == "array" && value.len() == 4) {
              UI_SetProperty (component.name, property, value[0], value[1], value[2], value[3]);
            } else {
              UI_SetProperty (component.name, property, value);
            }
        }
      }
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
