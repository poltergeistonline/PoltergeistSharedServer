module pshared.packets.handshake;

import pnet.packet;

/// 2001
final class HandshakeRequest : Packet
{
  public:
  final:
  ulong key;
  ulong clientId;

  this(ubyte[] buffer)
  {
    super(buffer);

    key = read!ulong;
    clientId = read!ulong;
  }
}
