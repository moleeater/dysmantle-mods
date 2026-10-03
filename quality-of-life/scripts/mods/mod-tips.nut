// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
if (NX_FileExists ("actors/collectibles/tarot.xml") || NX_FileExists ("scripts/interactions/tarot.nut") || NX_FileExists ("ui/tarot_templates.xml")
|| NX_FileExists ("ui/collectibles/tarotcard.nut") || NX_FileExists ("ui/collectibles/tarotcard.xml")
|| NX_FileExists ("actors/interactives/farming-mushroom_brown.xml") || NX_FileExists ("docs://Mega Quality Of Life Balance Mod/mod-info.xml")
|| NX_FileExists ("ugc://3711913031/mod-info.xml") || NX_FileExists ("ugc://3703339560/mod-info.xml")) return null;


function Mod_Tips_OnEnter_LoadingStage() {
  local files = NX_FindFiles ("", "mod*-tips.xml", false);
  if (files != null && files.len() > 0) {
    local lang = DM_GetArrayNodeValue ("save://index.xml", "!SETTINGS", "USER_SELECTED_LANGUAGE", "value");
    if (lang == null || lang == "") {
      lang = "en";
    }
    local current_platform = NX_CallExtension ("PlatformInfo", "PlatformId");
    local tips = {};
    local seen = {};
    foreach (file in files) {
      local node_num = DM_GetArrayNumberOfNodes (file, "TIPS");
      if (node_num != null) {
        local required_file = DM_GetArrayValue (file, "TIPS", "required_file");
        if (required_file == null || NX_FileExists (required_file) == true) {
          for (local node_index = 0; node_index < node_num; node_index++) {
            local tip_platform = DM_GetArrayNodeValue (file, "TIPS", node_index, "platform");
            if (tip_platform == null || tip_platform == current_platform) {
              local tip_lang = DM_GetArrayNodeValue (file, "TIPS", node_index, "lang");
              if (tip_lang != null) {
                if (tips.rawin(tip_lang) != true) {
                  tips[tip_lang] <- [];
                }
                if (seen.rawin(tip_lang) != true) {
                  seen[tip_lang] <- [];
                }
                local id = DM_GetArrayNodeValue (file, "TIPS", node_index, "id");
                if (id == null || seen[tip_lang].find(id) == null) {
                  local text = DM_GetArrayNodeValue (file, "TIPS", node_index, "value");
                  if (text != null && text != "") {
                    if (text.slice(0, 1) == "\n") {
                      text = text.slice(1);
                    }
                    if (text.len() > 0 && text.slice(text.len() - 1) == "\n") {
                      text = text.slice(0, text.len() - 1);
                    }
                    tips[tip_lang].push(text);
                    if (id != null) {
                      seen[tip_lang].push(id);
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    if (lang.len() > 2 && tips[lang].len() == 0) {
      lang = lang.slice(0, 2);
    }
    if (tips[lang].len() == 0) {
      lang = "en";
    }
    if (tips[lang].len() > 0) {
      local random = m_randf();
      local tip_winner = (random * tips[lang].len().tofloat()).tointeger();
      if (tip_winner == tips[lang].len()) tip_winner = 0;
      local tip = tips[lang][tip_winner];
      UI_SetProperty ("mod_tips", "textbox.text", tip);
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
