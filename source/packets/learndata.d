module pshared.packets.learndata;

import pnet.packet;

enum DataSkillName : dstring
{
  mining = "Mining",
  smithing = "Smithing",
  woodcutting = "Woodcutting",
  firemaking = "Firemaking",
  prayer = "Prayer",
  fishing = "Fishing",
  cooking = "Cooking",
  fletching = "Fletching",
  crafting = "Crafting",
  herblore = "Herblore",
  farming = "Farming",
  construction = "Construction",
  hunting = "Hunting"
}

enum DataType
{
  skill,
  spell,
  proficiency,
  other
}

/// 14001
final class LearnDataResponse : Packet
{
  public:
  final:
  dstring dataName;
  DataType dataType;
  ulong level;
  ulong maxLevel;
  ulong experience;
  ulong requiredExperience;

  this()
  {
    super(38, 14001);
  }

  override ubyte[] finalize()
  {
    expand(sumStringSizeSeparate([dataName], 4, 2));

    write!dstring(dataName);
    write!ushort(cast(ushort)dataType);
    write!ulong(level);
    write!ulong(maxLevel);
    write!ulong(experience);
    write!ulong(requiredExperience);

    return super.finalize;
  }
}

/// 14002
final class LearnDataTriggerRequest : Packet
{
  public:
  final:
  DataSkillName skillName;

  this(ubyte[] buffer)
  {
    super(buffer);

    skillName = (read!dstring).qcast!DataSkillName;
  }
}
