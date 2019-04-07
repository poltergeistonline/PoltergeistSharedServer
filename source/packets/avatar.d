module pshared.packets.avatar;

import pnet.packet;

/// 3501
final class AvatarRequest : Packet
{
  public:
  final:
  ulong avatar;

  this(ubyte[] buffer)
  {
    super(buffer);

    avatar = read!ulong;
  }
}
