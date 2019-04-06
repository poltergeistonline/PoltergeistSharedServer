module pshared.packets.message;

import pnet.packet;

enum MessageType : ushort
{
  talk,
  whisper,
  team,
  guild,
  clan,
  system,
  broadcast,
  center,
  topLeft,
  topRight,
  score,
  pinned
}

/// 6001
final class MessageRequest : Packet
{
  public:
  final:
  MessageType type;
  dstring receiver;
  dstring message;

  this(ubyte[] buffer)
  {
    super(buffer);

    type = (read!ushort).qcast!MessageType;
    receiver = read!dstring;
    message = read!dstring;
  }
}

/// 6002
final class MessageResponse : Packet
{
  public:
  final:
  MessageType type;
  dstring receiver;
  dstring sender;
  dstring message;
  uint senderColor;
  uint receiverColor;
  uint messageColor;
  ulong senderAvatar;
  ulong receiverAvatar;

  this()
  {
    super(34, 6002);
  }

  override ubyte[] finalize()
  {
    expand(sumStringSizeSeparate([receiver, sender, message], 4, 2));

    write!ushort(cast(ushort)type);
    write!dstring(receiver);
    write!dstring(sender);
    write!dstring(message);
    write!uint(senderColor);
    write!uint(receiverColor);
    write!uint(messageColor);
    write!ulong(senderAvatar);
    write!ulong(receiverAvatar);

    return super.finalize;
  }
}
