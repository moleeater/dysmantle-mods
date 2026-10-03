// MODS by MoleEater vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
local waterplane_puids = {};
waterplane_puids[4580001] <- {};
waterplane_puids[4580001][466] <- [                                           1650,             ];
waterplane_puids[4580001][467] <- [                               1648, 1649, 1650, 1651,       ];
waterplane_puids[4580001][468] <- [ 1643, 1644, 1645, 1646, 1647, 1648, 1649, 1650, 1651, 1652, ];
waterplane_puids[4580001][469] <- [ 1643, 1644, 1645, 1646, 1647, 1648, 1649, 1650, 1651, 1652, ];
waterplane_puids[4580001][470] <- [ 1643, 1644, 1645, 1646, 1647, 1648, 1649, 1650, 1651, 1652, ];
waterplane_puids[4580001][471] <- [ 1643, 1644, 1645, 1646, 1647, 1648, 1649, 1650, 1651, 1652, ];
waterplane_puids[4580001][472] <- [                   1646, 1647, 1648, 1649, 1650, 1651, 1652, ];
waterplane_puids[4580001][473] <- [                         1647, 1648,                         ];
waterplane_puids[4190005] <- {};
waterplane_puids[4382001] <- {};
waterplane_puids[4190005][435] <- [                   1592, 1593, 1594, 1595,             1598, 1599, ];
waterplane_puids[4190005][436] <- [             1591, 1592, 1593, 1594, 1595, 1596, 1597, 1598, 1599, ];
waterplane_puids[4190005][437] <- [       1590, 1591, 1592, 1593, 1594, 1595, 1596, 1597, 1598, 1599, ];
waterplane_puids[4190005][438] <- [ 1589, 1590, 1591, 1592, 1593, 1594, 1595, 1596, 1597, 1598, 1599, ];
waterplane_puids[4190005][439] <- [ 1589, 1590, 1591, 1592, 1593, 1594, 1595, 1596, 1597, 1598, 1599, ];
waterplane_puids[4382001][440] <- [ 1589, 1590, 1591, 1592, 1593, 1594, 1595, 1596, 1597, 1598, 1599, ];
waterplane_puids[4382001][441] <- [                   1592, 1593, 1594, 1595, 1596, 1597, 1598, 1599, ];
waterplane_puids[4382001][442] <- [                   1592, 1593, 1594, 1595, 1596, 1597, 1598, 1599, ];
waterplane_puids[4382001][443] <- [                                           1596, 1597, 1598, 1599, ];
waterplane_puids[4382001][444] <- [                                                       1598,       ];


function Mod_TabulaRasaFarms_OnGameStart_WaterPlane (waterplane, same) {
  if (Stage_GetFilename() == "stages/island/index.xml") {
    local puid = StageObject_GetPersistentUniqueId (waterplane);
    if (waterplane_puids.rawin(puid) == true) {
      foreach (cell_y, cell_xs in waterplane_puids[puid]) {
        foreach (cell_x in cell_xs) {
          Stage_SetGroundTile (cell_x, cell_y, "farmland");
        }
      }
    }
  }
}
// MODS by MoleEater ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
