module pshared.packets.nobility;

import pnet.packet;

enum NobilityAction : ushort
{
  info,
  members,
  donate,
  createRank
}

/// 40001
final class NobilityRequest : Packet
{
  public:
  final:
  NobilityAction action;
  ulong amount;
  dstring name;

  this(ubyte[] buffer)
  {
    super(buffer);

    type = (read!ushort).qcast!NobilityAction;
    amount = read!ulong;
    name = read!dstring;
  }
}

/// 40002
final class NobilityInfoResponse : Packet
{
  public:
  final:
  ulong donation;
  dstring rank;
  // FORMAT: {NAME} || {DONATION} || {RANK}
  dstring top1;
  dstring top2;
  dstring top3;

  this()
  {
    super(12, 40002);
  }

  override ubyte[] finalize()
  {
    expand(sumStringSizeSeparate([rank, top1, top2, top3], 4, 2));

    write!dstring(top1);
    write!dstring(top2);
    write!dstring(top3);

    return super.finalize;
  }
}

/// 40003
final class NobilityMembersResponse : Packet
{
  public:
  final:
  ushort pageId;
  // Format:
  // {NAME} || {DONATION} || {RANK}
  dstring[] members;

  this()
  {
    super(6, 40003);
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
