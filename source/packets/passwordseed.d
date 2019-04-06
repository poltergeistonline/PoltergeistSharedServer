module pshared.packets.passwordseed;

import pnet.packet;

/// 1007
final class PasswordSeedRequest : Packet
{
  public:
  final:
  dstring seed;

  this(ubyte[] buffer)
  {
    super(buffer);

    seed = read!dstring;
  }
}
