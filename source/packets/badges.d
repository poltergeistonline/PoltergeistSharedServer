module pshared.packets.badges;

import pnet.packet;

enum BadgeAction : ushort
{
  list,
  newBadge,
  selectBadge,
  createBadge
}

/// 46001
final class BadgeRequest : Packet
{
  public:
  final:
  BadgeAction action;
  dstring title;
  ulong badgeId;

  this(ubyte[] buffer)
  {
    super(buffer);

    action = (read!ushort).qcast!TitleAction;
    title = read!dstring;
    badgeId = read!ulong;
  }
}

/// 46002
final class BadgeListResponse : Packet
{
  public:
  final:
  BadgeAction action;
  // FORMAT: {TITLE} || {BADGEID}
  dstring selectedBadge;
  dstring[] badges;

  this()
  {
    super(6, 46002);
  }

  override ubyte[] finalize()
  {
    expand(sumStringSizeSeparate([selectedBadge], 4, 2));

    write!dstring(selectedBadge);

    if (badges && badges.length)
    {
      expand(sumStringSize(badges, 4, 2));

      write!ushort(badges.length);

      foreach (badge; badges)
      {
        write!dstring(badge);
      }
    }

    return super.finalize;
  }
}
