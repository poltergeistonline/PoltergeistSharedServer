module pshared.packets.duel;

import pnet.packet;

enum DuelAction : ushort
{
  request,
  accept,
  beginBattle,
  endBattle,
  leaveBattle
}

/// 33001
final class DuelRequest : Packet
{
  public:
  final:
  DuelAction action;
  ulong clientId;

  this(ubyte[] buffer)
  {
    super(buffer);

    type = (read!ushort).qcast!DuelAction;
    clientId = read!ulong;
  }
}

/// 33002
final class DuelResponse : Packet
{
  public:
  final:
  DuelAction action;
  ulong clientId1;
  ulong clientId2;
  dstring name1;
  dstring name2;
  ubyte level1;
  ubyte level2;
  bool player1Wins;

  this()
  {
    super(26, 33002);
  }

  override ubyte[] finalize()
  {
    expand(sumStringSizeSeparate([name1, name2], 4, 2));

    write!ushort(cast(ushort)action);
    write!ulong(clientId1);
    write!ulong(clientId2);
    write!dstring(name1);
    write!dstring(name2);
    write!ubyte(level1);
    write!ubyte(level2);
    write!bool(player1Wins);

    return super.finalize;
  }
}
