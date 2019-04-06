module pshared.packets.serverinfo;

import pnet.packet;

/// 2011
final class ServerInfoResponse : Packet
{
  public:
  final:
  dstring serverName;
  dstring serverTitle;
  dstring messageOfTheDaySender;
  dstring messageOfTheDay;
  uint year;
  uint month;
  uint day;
  uint hour;
  uint minute;

  this()
  {
    super(20, 2011);
  }

  override ubyte[] finalize()
  {
    expand(sumStringSizeSeparate([serverName, serverTitle, messageOfTheDaySender, messageOfTheDay], 4, 2));

    write!dstring(serverName);
    write!dstring(serverTitle);

    write!dstring(messageOfTheDaySender);
    write!dstring(messageOfTheDay);

    write!uint(year);
    write!uint(month);
    write!uint(day);
    write!uint(hour);
    write!uint(minute);

    return super.finalize;
  }
}
