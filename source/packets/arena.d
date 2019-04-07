module pshared.packets.arena;

import pnet.packet;

enum ArenaAction : ushort
{
  info,
  join,
  cancel,
  countDown,
  beginBattle,
  endBattle,
  leaveBattle,
  updateScore
}

/// 32001
final class ArenaRequest : Packet
{
  public:
  final:
  ArenaAction action;

  this(ubyte[] buffer)
  {
    super(buffer);

    type = (read!ushort).qcast!ArenaAction;
  }
}

/// 32002
final class ArenaResponse : Packet
{
  public:
  final:
  ArenaAction action;
  ulong clientId1;
  ulong clientId2;
  dstring name1;
  dstring name2;
  ubyte level1;
  ubyte level2;
  uint score1;
  uint score2;
  bool player1Wins;

  this()
  {
    super(34, 32002);
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
    write!uint(score1);
    write!uint(score2);
    write!bool(player1Wins);

    return super.finalize;
  }
}
