// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
function Mod_StageInfo_OnEnter_PauseMenu() {
  local stage = Stage_GetName();
  if (stage != null) {
    stage = LocalizeText(stage);
  } else {
    switch (Stage_GetFilename()) {
      case "stages/island/index.xml": stage = LocalizeText("The Island"); break;
      case "stages/shelters/shelter-arcturus.xml": stage = LocalizeText("Arcturus") + " " + LocalizeText("Shelter"); break;
      case "stages/shelters/shelter-borealis.xml": stage = LocalizeText("Borealis") + " " + LocalizeText("Shelter"); break;
      case "stages/shelters/shelter-everglade.xml": stage = LocalizeText("Everglade") + " " + LocalizeText("Shelter"); break;
      case "stages/shelters/shelter-frore.xml": stage = LocalizeText("Frore") + " " + LocalizeText("Shelter"); break;
      case "stages/shelters/shelter-hedgefield.xml": stage = LocalizeText("Hedgefield") + " " + LocalizeText("Shelter"); break;
      case "stages/shelters/shelter-polaris.xml": stage = LocalizeText("Polaris") + " " + LocalizeText("Shelter"); break;
      case "stages/shelters/shelter-sunburn-desert.xml": stage = LocalizeText("Sunburn Desert") + " " + LocalizeText("Shelter"); break;
      case "stages/shelters/shelter-vulcan.xml": stage = LocalizeText("Vulcan") + " " + LocalizeText("Shelter"); break;
      case "stages/undercrown/index.xml": stage = LocalizeText("Undercrown"); break;
      case "stages/special/launchpad-tunnel.xml": stage = LocalizeText("Launchpad Tunnel"); break;
      case "stages/shelters/surreal-shelter.stage": stage = LocalizeText("The Shelter"); break;
      case "stages/dlc1/index.xml": stage = LocalizeText("Underworld"); break;
      case "stages/dlc2/index.xml": stage = LocalizeText("Hidden Archipelago"); break;
      case "stages/dlc3/index.xml": stage = LocalizeText("Pet Island"); break;
    }
  }
  UI_SetProperty ("mod_stage_info_title", "textbox.text", stage == null ? "" : stage);
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
