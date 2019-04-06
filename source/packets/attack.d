module pshared.packets.attack;

import pnet.packet;

enum AttackType : ushort
{
  physical,
  range,
  magic
}

enum AttackDirection : ushort
{
  north,
  east,
  south,
  west
}

/// 15001
final class AttackRequest : Packet
{
  public:
  final:
  AttackType type;
  ushort spellId;
  AttackDirection direction;
  ulong clientId;

  this(ubyte[] buffer)
  {
    super(buffer);

    type = (read!ushort).qcast!AttackType;
    spellId = read!ushort;
    direction = (read!ushort).qcast!AttackDirection;
    clientId = read!ulong;
  }
}

/// 15002
final class AttackResponse : Packet
{
  public:
  final:
  AttackType type;
  ushort spellId;
  AttackDirection direction;
  ulong attackerId;
  ulong clientId;

  this()
  {
    super(14, 15002);
  }

  override ubyte[] finalize()
  {
    write!ushort(cast(ushort)type);
    write!ushort(spellId);
    write!ushort(cast(ushort)direction);
    write!ushort(attackerId);
    write!ushort(clientId);

    return super.finalize;
  }
}

/// 15003
final class DeathResponse : Packet
{
  public:
  final:
  ulong clientId;

  this()
  {
    super(6, 15003);
  }

  override ubyte[] finalize()
  {
    write!ushort(clientId);

    return super.finalize;
  }
}

/// 15004
final class ReviveRequest : Packet
{
  public:
  final:

  this(ubyte[] buffer)
  {
    super(buffer);
  }
}
