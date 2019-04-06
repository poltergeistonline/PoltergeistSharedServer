module pshared.packets.serverlist;

import pnet.packet;

/// 1003
final class ServerListRequest : Packet
{
  public:
  final:
  dstring group;

  this(ubyte[] buffer)
  {
    super(buffer);

    group = read!dstring;
  }
}

/// 1004
final class ServerListResponse : Packet
{
  public:
  final:
  dstring[] servers;

  this()
  {
    super(4, 1004);
  }

  override ubyte[] finalize()
  {
    if (servers && servers.length)
    {
      expand(sumStringSize(servers, 4, 2));

      write!ushort(servers.length);

      foreach (server; servers)
      {
        write!dstring(server);
      }
    }

    return super.finalize;
  }
}
