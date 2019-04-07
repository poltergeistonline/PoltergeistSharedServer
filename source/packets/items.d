module pshared.packets.items;

import pnet.packet;

enum ItemAction : ushort
{
  pickup,
  add,
  addBank,
  removeBank,
  addShop,
  drop,
  equip,
  unequip,
  mask,
  unmask,
  info
}

enum ItemPosition : ushort
{
  headGear,
  necklace,
  armor,
  boots,
  leftHand,
  rightHand,
  back,
  ring,
  talisman1,
  talisman2,
  bottle,
  garment,
  pet,
  mount
}

enum ItemGender : ushort
{
  none,
  male,
  female
}

/// 1601
final class ItemRequest : Packet
{
  public:
  final:
  ItemAction action;
  ItemPosition position;
  ulong itemId;
  uint amount;

  this(ubyte[] buffer)
  {
    super(buffer);

    action = (read!ushort).qcast!ItemAction;
    position = (read!ushort).qcast!ItemPosition;
    itemId = read!ulong;
    amount = read!uint;
  }
}

/// 1602
final class ItemInfoResponse : Packet
{
  public:
  final:
  dstring name;
  dstring category;
  dstring description;

  ushort job;

  ubyte level;

  ItemGender gender;

  ushort strength;
  ushort agility;
  ushort vitality;
  ushort endurance;
  ushort spirit;
  ushort accuracy;

  ushort extraStrength;
  ushort extraAgility;
  ushort extraVitality;
  ushort extraEndurance;
  ushort extraSpirit;
  ushort extraAccuracy;

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

  ushort plus;

  uint socket1;
  uint socket2;

  ushort boost;

  this()
  {
    super(164, 1602);
  }

  override ubyte[] finalize()
  {
    expand(sumStringSizeSeparate([name, category, description], 4, 2));

    write!dstring(name);
    write!dstring(category);
    write!dstring(description);

    write!ushort(job);

    write!ubyte(level);

    write!ushort(cast(ushort)gender);

    write!ushort(strength);
    write!ushort(agility);
    write!ushort(vitality);
    write!ushort(endurance);
    write!ushort(spirit);
    write!ushort(accuracy);

    write!ushort(extraStrength);
    write!ushort(extraAgility);
    write!ushort(extraVitality);
    write!ushort(extraEndurance);
    write!ushort(extraSpirit);
    write!ushort(extraAccuracy);


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

    write!ushort(plus);

    write!uint(socket1);
    write!uint(socket2);

    write!ushort(boost);

    return super.finalize;
  }
}

/// 1603
final class ItemAddResponse : Packet
{
  public:
  final:
  ulong clientId;
  uint itemId;
  ItemPosition position;
  uint amount;

  this()
  {
    super(18, 1603);
  }

  override ubyte[] finalize()
  {
    write!ulong(clientId);
    write!uint(itemId);
    write!ushort(cast(ushort)position);
    write!uint(amount);

    return super.finalize;
  }
}
