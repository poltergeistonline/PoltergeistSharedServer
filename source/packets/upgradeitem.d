module pshared.packets.upgradeitem;

import pnet.packet;

enum UpgradeItemAction : ushort
{
  plus,
  boost,
  socket1,
  socket2
}

/// 4501
final class UpgradeItemRequest : Packet
{
  public:
  final:
  UpgradeItemAction action;
  ulong amount;
  ulong itemId;

  this(ubyte[] buffer)
  {
    super(buffer);

    action = (read!ushort).qcast!UpgradeItemAction;
    amount = read!ulong;
    itemId = read!ulong;
  }
}
