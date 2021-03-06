module pshared.packets.interaction;

import pnet.packet;

enum InteractionType
{
  kiss,
  hug,
  marry,
  bestfriend,
  friend,
  enemy,
  bounty,
  blacklist
}

/// 9001
final class InteractionRequest : Packet
{
  public:
  final:
  InteractionType type;
  uint clientId;
  uint targetId;

  this(ubyte[] buffer)
  {
    super(buffer);

    type = (read!ushort).qcast!NpcType;
    clientId = read!uint;
    targetId = read!uint;
  }
}

/// 9002
final class InteractionResponse : Packet
{
  public:
  final:
  InteractionType type;
  uint clientId;
  uint targetId;

  this()
  {
    super(14, 9002);
  }

  override ubyte[] finalize()
  {
    write!ushort(cast(ushort)type);
    write!uint(clientId);
    write!uint(targetId);

    return super.finalize;
  }
}
