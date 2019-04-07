module pshared.packets.characterscreen;

import pnet.packet;

/// 2101
final class CharacterScreenRequest : Packet
{
  public:
  final:
  this(ubyte[] buffer)
  {
    super(buffer);
  }
}

/// 2102
final class CharacterScreenResponse : Packet
{
  public:
  class CharacterScreenItem
  {
    dstring name;
    dstring title;
    dstring job;
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

    ulong statusEffect1;
    ulong statusEffect2;
  }

  final:
  CharacterScreenItem[] characters;

  this()
  {
    super(4, 2102);
  }

  override ubyte[] finalize()
  {
    if (characters && characters.length)
    {
      write!ushort(characters.length);

      foreach (character; characters)
      {
        auto size = sumStringSizeSeparate([character.name, character.title, character.job], 4, 2);

        size += 74;

        expand(size);

        write!dstring(character.name);
        write!dstring(character.title);
        write!dstring(character.job);
        write!ubyte(character.level);

        write!ulong(character.avatar);

        write!uint(character.model);
        write!uint(character.hair);
        write!uint(character.eyes);
        write!uint(character.skin);

        write!uint(character.headGear);
        write!uint(character.necklace);
        write!uint(character.armor);
        write!uint(character.boots);
        write!uint(character.leftHand);
        write!uint(character.rightHand);
        write!uint(character.back);
        write!uint(character.garment);

        write!ulong(character.statusEffect1);
        write!ulong(character.statusEffect2);
      }
    }

    return super.finalize;
  }
}

/// 2103
final class CharacterScreenSelectRequest : Packet
{
  public:
  final:
  dstring characterName;

  this(ubyte[] buffer)
  {
    super(buffer);

    characterName = read!dstring;
  }
}

/// 2104
final class CharacterScreenCreationRequest : Packet
{
  public:
  final:
  dstring name;
  ulong avatar;
  uint model;
  uint hair;
  uint eyes;
  uint skin;
  ushort job;

  this(ubyte[] buffer)
  {
    super(buffer);

    name = read!dstring;
    avatar = read!ulong;
    model = read!uint;
    hair = read!uint;
    eyes = read!uint;
    skin = read!uint;
    job = read!uint;
  }
}

/// 2105
final class CharacterScreenCreationResponse : Packet
{
  public:
  final:
  bool success;
  dstring message;

  this()
  {
    super(4, 2105);
  }

  override ubyte[] finalize()
  {
    write!bool(success);

    if (message && message.length)
    {
      expand(sumStringSizeSeparate([message], 4, 2));

      write!dstring(message);
    }

    return super.finalize;
  }
}
