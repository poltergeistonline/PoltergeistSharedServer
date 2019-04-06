module pshared.packets.teleport;

import pnet.packet;

/// 3101
final class TeleportResponse : Packet
{
  public:
  final:
  ulong clientId;
  uint mapId;
  uint x;
  uint y;

  this()
  {
    super(24, 3101);
  }

  override ubyte[] finalize()
  {
    write!ulong(clientId);
    write!uint(mapId);
    write!uint(x);
    write!uint(y);

    return super.finalize;
  }
}
