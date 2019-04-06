module pshared.packets.updateclient;

import pnet.packet;

enum UpdateType : ushort
{
  level,
  hp,
  maxHp,
  mp,
  maxMp,
  stamina,
  maxStamina,
  sp,
  maxSp,
  experience,
  requiredExperience,
  job,
  money,
  strength,
  agility,
  vitality,
  endurance,
  spirit,
  accuracy,
  model,
  hair,
  eyes,
  skin,
  pkPoints,
  duelPoints,
  arenaPoints
}

/// 5001
final class UpdateResponse : Packet
{
  public:
  final:
  ulong clientId;
  UpdateType type;
  ulong value;

  this()
  {
    super(22, 5001);
  }

  override ubyte[] finalize()
  {
    write!ulong(clientId);
    write!ushort(type);
    write!ulong(value);

    return super.finalize;
  }
}
