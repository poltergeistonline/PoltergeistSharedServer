module pshared.packets.clan;

import pnet.packet;

enum ClanAction : ushort
{
  info,
  create,
  invite,
  join,
  kick,
  disband,
  leave,
  members
}

/// 22001
final class ClanRequest : Packet
{
  public:
  final:
  ClanAction action;
  dstring name;
  ulong clientId;
  ushort pageId;

  this(ubyte[] buffer)
  {
    super(buffer);

    action = (read!ushort).qcast!ClanAction;
    name = read!dstring;
    clientId = read!ulong;
    pageId = read!ushort;
  }
}

/// 22002
final class ClanResponse : Packet
{
  public:
  final:
  ClanAction action;

  this()
  {
    super(6, 22002);
  }

  override ubyte[] finalize()
  {
    write!ushort(cast(ushort)action);

    return super.finalize;
  }
}

/// 22003
final class ClanInfoResponse : Packet
{
  public:
  final:
  dstring clanName;
  dstring clanCreator;

  this()
  {
    super(4, 22003);
  }

  override ubyte[] finalize()
  {
    expand(sumStringSizeSeparate([clanName, clanCreator], 4, 2));

    write!dstring(clanName);
    write!dstring(clanCreator);

    return super.finalize;
  }
}

/// 22004
final class ClanMembersResponse : Packet
{
  public:
  final:
  ushort pageId;
  // Format:
  // {NAME} || {LEVEL}
  dstring[] members;

  this()
  {
    super(6, 22004);
  }

  override ubyte[] finalize()
  {
    write!ushort(pageId);

    if (members && members.length)
    {
      expand(sumStringSize(members, 4, 2));

      write!ushort(members.length);

      foreach (member; members)
      {
        write!dstring(member);
      }
    }

    return super.finalize;
  }
}
