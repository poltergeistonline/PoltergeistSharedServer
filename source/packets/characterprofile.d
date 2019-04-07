module pshared.packets.nobility;

import pnet.packet;

/// 24001
final class CharacterProfileRequest : Packet
{
  public:
  final:
  ulong clientId;

  this(ubyte[] buffer)
  {
    super(buffer);

    clientId = read!ulong;
  }
}

/// 24002
final class CharacterProfileResponse : Packet
{
  public:
  final:
  dstring name;
  dstring title;
  dstring job;
  dstring guild;
  dstring guildRank;
  dstring clan;
  dstring spouse;
  dstring bestfriend;

  ubyte level;

  ulong avatar;

  uint model;
  uint hair;
  uint eyes;
  uint skin;

  uint headGear;
  uint necklace;
  uint armor;
  uint boots;
  uint leftHand;
  uint rightHand;
  uint back;
  uint garment;

  ushort strength;
  ushort agility;
  ushort vitality;
  ushort endurance;
  ushort spirit;
  ushort accuracy;

  ulong minAttack;
  ulong maxAttack;

  ulong magicAttack;

  ulong physicalDefense;
  ulong magicDeferense;
  ulong rangeDefense;

  ushort dodge;

  ushort earthPercentage;
  ushort woodPercentage;
  ushort metalPercentage;
  ushort waterPercentage;
  ushort firePercentage;
  ushort windPercentage;
  ushort icePercentage;

  this()
  {
    super(138, 24002);
  }

  override ubyte[] finalize()
  {
    expand(sumStringSizeSeparate([name, title, job, guild, guildRank, clan, spouse, bestfriend], 4, 2));

    write!dstring(name);
    write!dstring(title);
    write!dstring(job);
    write!dstring(guild);
    write!dstring(guildRank);
    write!dstring(clan);
    write!dstring(spouse);
    write!dstring(bestfriend);

    write!ubyte(level);

    write!ulong(avatar);

    write!uint(model);
    write!uint(hair);
    write!uint(eyes);
    write!uint(skin);

    write!uint(headGear);
    write!uint(necklace);
    write!uint(armor);
    write!uint(boots);
    write!uint(leftHand);
    write!uint(rightHand);
    write!uint(back);
    write!uint(garment);

    write!ushort(strength);
    write!ushort(agility);
    write!ushort(vitality);
    write!ushort(endurance);
    write!ushort(spirit);
    write!ushort(accuracy);

    write!ulong(minAttack);
    write!ulong(maxAttack);

    write!ulong(magicAttack);

    write!ulong(physicalDefense);
    write!ulong(magicDeferense);
    write!ulong(rangeDefense);

    write!ushort(dodge);

    write!ushort(earthPercentage);
    write!ushort(woodPercentage);
    write!ushort(metalPercentage);
    write!ushort(waterPercentage);
    write!ushort(firePercentage);
    write!ushort(windPercentage);
    write!ushort(icePercentage);

    return super.finalize;
  }
}
