module pshared.packets.spawnpacket;

import pnet.packet;

enum SpawnType : ushort
{
  player,
  guard,
  npc,
  bank,
  shop,
  monster,
  boss,
  pet,
  mount,
  item,
  money
}

/// 4001
final class SpawnResponse : Packet
{
  public:
  final:
  ulong clientId;
  uint x;
  uint y;
  SpawnType type;

  dstring name;
  dstring title;
  ushort level;

  uint nameColor;
  uint titleColor;

  uint itemId;
  ulong amount;

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

  ulong statusEffect1;
  ulong statusEffect2;

  ulong attributeEffect1;
  ulong attributeEffect2;

  ulong hp;
  ulong maxHp;

  this()
  {
    super(136, 4001);
  }

  override ubyte[] finalize()
  {
    expand(sumStringSizeSeparate([character.name, character.title], 4, 2));

    write!ulong(clientId);
    write!uint(x);
    write!uint(y);
    write!ushort(cast(ushort)type);

    write!dstring(name);
    write!dstring(title);
    write!ushort(level);

    write!uint(nameColor);
    write!uint(titleColor);

    final switch (type)
    {
      case SpawnType.item:
      {
        write!uint(itemId);
        break;
      }

      case SpawnType.money:
      {
        write!ulong(amount);
        break;
      }

      default:
      {
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

        write!ulong(statusEffect1);
        write!ulong(statusEffect2);

        write!ulong!(attributeEffect1);
        write!ulong(attributeEffect2);

        write!ulong(hp);
        write!ulong(maxHp);
      }
    }

    return super.finalize;
  }
}
