module pshared.packets.servergrouplist;

import pnet.packet;

/// 1001
final class ServerGroupListRequest : Packet
{
  public:
  final:
  this(ubyte[] buffer)
  {
    super(buffer);
  }
}

/// 1002
final class ServerGroupListResponse : Packet
{
  public:
  final:
  dstring[] groups;

  this()
  {
    super(4, 1002);
  }

  override ubyte[] finalize()
  {
    if (groups && groups.length)
    {
      expand(sumStringSize(groups, 4, 2));

      write!ushort(groups.length);

      foreach (group; groups)
      {
        write!dstring(group);
      }
    }

    return super.finalize;
  }
}
