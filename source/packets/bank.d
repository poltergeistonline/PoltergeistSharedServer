module pshared.packets.bank;

import pnet.packet;

/// 1901
final class BankRequest : Packet
{
  public:
  final:
  ulong bankId;

  this(ubyte[] buffer)
  {
    super(buffer);

    bankId = read!ulong;
  }
}

/// 1902
final class BankResponse : Packet
{
  public:
  final:
  ulong money;

  this()
  {
    super(12, 1902);
  }

  override ubyte[] finalize()
  {
    write!ulong(money);

    return super.finalize;
  }
}
