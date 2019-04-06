module pshared.packets.trade;

import pnet.packet;

enum TradeAction : ushort
{
  request,
  accept,
  addItem,
  removeItem,
  changeMoney
}

/// 12001
final class TradeRequest : Packet
{
  public:
  final:
  TradeAction action;
  uint itemId;
  uint itemClientId;
  ulong money;
  ulong clientId;

  this(ubyte[] buffer)
  {
    super(buffer);

    action = (read!ushort).qcast!TradeAction;
    itemId = read!uint;
    itemClientId = read!uint;
    money = read!ulong;
    clientId = read!ulong;
  }
}

/// 12002
final class TradeResponse : Packet
{
  public:
  final:
  TradeAction action;
  uint itemId;
  uint itemClientId;
  ulong money;

  this()
  {
    super(4, 12002);
  }

  override ubyte[] finalize()
  {
    write!ushort(cast(ushort)action);
    write!uint(itemId);
    write!uint(itemClientId);
    write!ulong(money);

    return super.finalize;
  }
}
