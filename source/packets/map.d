module pshared.packets.map;

import pnet.packet;

enum MapPkMode : ushort
{
  safe,
  aggressivePk,
  safePk
}

/// 1010
final class MapResponse : Packet
{
  public:
  final:
  uint mapId;
  MapPkMode pkMode;
  bool aggressiveGuards;
  bool aggressiveMonsters;
  bool allowPets;
  bool allowMount;
  bool instantRevive;

  this()
  {
    super(16, 1010);
  }

  override ubyte[] finalize()
  {
    write!uint(mapId);
    write!ushort(cast(ushort)pkMode);
    write!bool(aggressiveGuards);
    write!bool(aggressiveMonsters);
    write!bool(allowPets);
    write!bool(allowMount);
    write!bool(instantRevive);

    return super.finalize;
  }
}
