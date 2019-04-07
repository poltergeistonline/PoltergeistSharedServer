module pshared.packets.money;

import pnet.packet;

enum MoneyAction : ushort
{
  drop,
  pickup,
  withdraw,
  deposit
}

/// 1701
final class MoneyRequest : Packet
{
  public:
  final:
  MoneyAction action;
  ulong amount;

  this(ubyte[] buffer)
  {
    super(buffer);

    action = (read!ushort).qcast!MoneyAction;
    amount = read!ulong;
  }
}
