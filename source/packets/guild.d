module pshared.packets.guild;

import pnet.packet;

enum GuildAction : ushort
{
  info,
  create,
  invite,
  join,
  kick,
  ban,
  promote,
  disband,
  leave,
  donate,
  ranks,
  addAlly,
  removeAlly,
  allies,
  addEnemy,
  removeEnemy,
  enemies,
  blacklist,
  logs,
  members
}

/// 21001
final class GuildRequest : Packet
{
  public:
  final:
  GuildAction action;
  dstring name;
  ulong clientId;
  ulong amount;
  ushort pageId;

  this(ubyte[] buffer)
  {
    super(buffer);

    action = (read!ushort).qcast!GuildAction;
    name = read!dstring;
    clientId = read!ulong;
    amount = read!ulong;
    pageId = read!ushort;
  }
}

/// 21002
final class GuildResponse : Packet
{
  public:
  final:
  GuildAction action;

  this()
  {
    super(6, 21002);
  }

  override ubyte[] finalize()
  {
    write!ushort(cast(ushort)action);

    return super.finalize;
  }
}

/// 21003
final class GuildInfoResponse : Packet
{
  public:
  final:
  dstring guildName;
  dstring guildMessage;
  dstring guildLeader;

  this()
  {
    super(4, 21003);
  }

  override ubyte[] finalize()
  {
    expand(sumStringSizeSeparate([guildName, guildMessage, guildLeader], 4, 2));

    write!dstring(guildName);
    write!dstring(guildMessage);
    write!dstring(guildLeader);

    return super.finalize;
  }
}

/// 21004
final class GuildMembersResponse : Packet
{
  public:
  final:
  ushort pageId;
  // Format:
  // {NAME} || {LEVEL} || {RANK} || {DONATION}
  dstring[] members;

  this()
  {
    super(6, 21004);
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

/// 21005
final class GuildRanksResponse : Packet
{
  public:
  final:
  dstring[] ranks;

  this()
  {
    super(4, 21005);
  }

  override ubyte[] finalize()
  {
    if (ranks && ranks.length)
    {
      expand(sumStringSize(ranks, 4, 2));

      write!ushort(ranks.length);

      foreach (rank; ranks)
      {
        write!dstring(rank);
      }
    }

    return super.finalize;
  }
}

/// 21006
final class GuildAlliesResponse : Packet
{
  public:
  final:
  dstring[] allies;

  this()
  {
    super(4, 21006);
  }

  override ubyte[] finalize()
  {
    if (allies && allies.length)
    {
      expand(sumStringSize(allies, 4, 2));

      write!ushort(allies.length);

      foreach (ally; allies)
      {
        write!dstring(ally);
      }
    }

    return super.finalize;
  }
}

/// 21007
final class GuildEnemiesResponse : Packet
{
  public:
  final:
  dstring[] enemies;

  this()
  {
    super(4, 21007);
  }

  override ubyte[] finalize()
  {
    if (enemies && enemies.length)
    {
      expand(sumStringSize(enemies, 4, 2));

      write!ushort(enemies.length);

      foreach (enemy; enemies)
      {
        write!dstring(enemy);
      }
    }

    return super.finalize;
  }
}
