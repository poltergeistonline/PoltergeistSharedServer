module pshared.packets.entitycreate;

import pnet.packet;

enum EntityType : ushort
{
  pet,
  mount,
  monster,
  boss,
  guard
}

enum AttackType : ushort
{
  physical,
  range,
  magic
}

/// 7003
final class EntityCreateRequest : Packet
{
  public:
  final:
  EntityType type;
  uint entityId;
  dstring name;
  uint nameColor;

  uint model;
  uint skin;

  ulong maxHp;

  ushort level;

  ulong attack;
  ulong staticAttack;

  ulong physicalDefense;
  ulong magicDeferense;
  ulong rangeDefense;

  AttackType attackType;

  this(ubyte[] buffer)
  {
    super(buffer);

    type = (read!ushort).qcast!NpcType;
    entityId = read!uint;
    name = read!dstring;
    nameColor = read!uint;

    model = read!ushort;
    skin = read!uint;

    maxHp = read!ulong;

    level = read!ushort;

    attack = read!ulong;
    staticAttack = read!ulong;

    physicalDefense = read!ulong;
    magicDeferense = read!ulong;
    rangeDefense = read!ulong;

    attackType = (read!ushort).qcast!AttackType;
  }
}
