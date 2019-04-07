module pshared.packets.mapcreator;

import pnet.packet;

import pshared.packets.learndata;

/// 2501
final class MapCreatorRequest : Packet
{
  // This will also create a map file or update the current map file in the client.
  // The map will only work for clients with the map file.
  // Make sure to patch the client with the map file when finished.
  // Maps, tiles etc. are loaded by the client and aren't stored on the server.
  // The map information is only used for security reasons to verify movements etc.
  public:
  final:
  ulong tileset;
  ushort tileRow;
  ushort tileColumn;

  ushort layer; // 1,2,3 (below) 4 (entity) 5,6 (above)

  uint portalMapId;
  uint portalX;
  uint portalY;

  uint npcId;

  DataSkillName skillTrigger;

  uint mapId;
  uint x;
  uint y;

  ubyte brushSize;

  bool allowNorthMovement;
  bool allowEastMovement;
  bool allowSouthMovement;
  bool allowWestMovement;

  this(ubyte[] buffer)
  {
    super(buffer);

    tileset = read!ulong;
    tileRow = read!ushort;
    tileColumn = read!ushort;

    layer = read!ushort;

    portalMapId = read!uint;
    portalX = read!uint;
    portalY = read!uint;

    npcId = read!uint;

    skillTrigger = (read!dstring).qcast!DataSkillName;

    mapId = read!uint;
    x = read!uint;
    y = read!uint;

    brushSize = read!ubyte;

    allowNorthMovement = read!bool;
    allowEastMovement = read!bool;
    allowSouthMovement = read!bool;
    allowWestMovement = read!bool;
  }
}
