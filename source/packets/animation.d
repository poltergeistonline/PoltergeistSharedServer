module pshared.packets.animation;

import pnet.packet;

/// 8899
final class AnimationResponse : Packet
{
  public:
  final:
  ulong animationId;
  ushort layer;
  uint x;
  uint y;
  bool centerScreen;

  this()
  {
    super(24, 8899);
  }

  override ubyte[] finalize()
  {
    write!ulong(animationId);
    write!ushort(layer);
    write!uint(x);
    write!uint(y);
    write!bool(centerScreen);

    return super.finalize;
  }
}
