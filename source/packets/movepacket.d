module pshared.packets.movepacket;

import pnet.packet;

enum MoveDirection : ushort
{
  north = 0,
  east = 1,
  south = 2,
  west = 3
}

/// 3001
final class MoveRequest : Packet
{
  public:
  final:
  MoveDirection direction;

  this(ubyte[] buffer)
  {
    super(buffer);

    direction = (read!ushort).qcast!MoveDirection;
  }
}

/// 3002
final class MoveResponse : Packet
{
  public:
  final:
  ulong clientId;
  MoveDirection direction;

  this()
  {
    super(14, 3002);
  }

  override ubyte[] finalize()
  {
    write!ulong(clientId);
    write!ushort(cast(ushort)direction);

    return super.finalize;
  }
}
