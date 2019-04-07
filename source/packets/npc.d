module pshared.packets.npc;

import pnet.packet;

/// 7001
final class NpcRequest : Packet
{
  public:
  final:
  uint npcId;
  uint option;
  dstring input;

  this(ubyte[] buffer)
  {
    super(buffer);

    npcId = read!uint;
    option = read!uint;
    input = read!dstring;
  }
}

enum NpcResponseType
{
  show,
  title,
  message,
  option,
  input
}

/// 7002
final class NpcResponse : Packet
{
  public:
  final:
  uint npcId;
  ulong avatar;
  NpcResponseType type;
  dstring value;

  this()
  {
    super(34, 6002);
  }

  override ubyte[] finalize()
  {
    write!uint(npcId);
    write!ulong(avatar);
    write!ushort(cast(ushort)type);

    if (value && value.length)
    {
      expand(sumStringSizeSeparate([value], 4, 2));

      write!dstring(value);
    }

    return super.finalize;
  }
}

enum NpcType : ushort
{
  npc,
  bank,
  shop
}

/// 7003
final class NpcCreateRequest : Packet
{
  public:
  final:
  uint npcId;
  dstring name;
  NpcType type;

  ulong avatar;

  uint model;
  uint hair;
  uint eyes;
  uint skin;

  uint headGear;
  uint necklace;
  uint armor;
  uint boots;
  uint leftHand;
  uint rightHand;
  uint back;

  uint mapId;
  uint x;
  uint y;

  this(ubyte[] buffer)
  {
    super(buffer);

    npcId = read!uint;
    name = read!dstring;
    type = (read!ushort).qcast!NpcType;

    avatar = read!ulong;

    model = read!uint;
    hair = read!uint;
    eyes = read!uint;
    skin = read!uint;

    headGear = read!uint;
    necklace = read!uint;
    armor = read!uint;
    boots = read!uint;
    leftHand = read!uint;
    rightHand = read!uint;
    back = read!uint;
  }
}
