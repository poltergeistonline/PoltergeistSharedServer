module pshared.packets.popup;

import pnet.packet;

enum PopupType : ushort
{
  ok,
  ok_cancel,
  yes_no,
  yes_no_cancel,
  event,
  tournament,
  window
}

/// 3333
final class UpgradeItemResponse : Packet
{
  public:
  final:
  dstring title;
  dstring message;
  uint messageColor;
  PopupType type;
  uint npcId;
  uint option1;
  uint option2;

  this()
  {
    super(22, 3333);
  }

  override ubyte[] finalize()
  {
    expand(sumStringSizeSeparate([title, message], 4, 2));

    write!dstring(title);
    write!dstring(message);
    write!uint(messageColor);
    write!ushort(cast(ushort)type);
    write!uint(npcId);
    write!uint(option1);
    write!uint(option2);

    return super.finalize;
  }
}
