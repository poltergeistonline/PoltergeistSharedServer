module pshared.packets.team;

import pnet.packet;

enum TeamAction : ushort
{
  create,
  invite,
  join,
  kick,
  disband,
  leave
}

/// 23001
final class TeamRequest : Packet
{
  public:
  final:
  TeamAction action;
  dstring name;
  ulong clientId;

  this(ubyte[] buffer)
  {
    super(buffer);

    action = (read!ushort).qcast!TeamAction;
    name = read!dstring;
    clientId = read!ulong;
  }
}

/// 23002
final class TeamResponse : Packet
{
  public:
  final:
  TeamAction action;

  this()
  {
    super(6, 23002);
  }

  override ubyte[] finalize()
  {
    write!ushort(cast(ushort)action);

    return super.finalize;
  }
}

/// 23003
final class TeamMembersResponse : Packet
{
  public:
  final:
  // Format:
  // {NAME} || {LEVEL} || {IS_LEADER 1/0}
  dstring[] members;

  this()
  {
    super(6, 23003);
  }

  override ubyte[] finalize()
  {
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
