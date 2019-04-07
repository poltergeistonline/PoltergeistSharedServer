module pshared.packets.shop;

import pnet.packet;

enum ShopAction : ushort
{
  display,
  buy,
  sell
}

/// 3401
final class ShopRequest : Packet
{
  public:
  final:
  ShopAction action;
  ulong shopItemId;
  ulong amount;

  this(ubyte[] buffer)
  {
    super(buffer);

    action = (read!ushort).qcast!ShopAction;
    shopItemId = read!ulong;
    amount = read!ulong;
  }
}
