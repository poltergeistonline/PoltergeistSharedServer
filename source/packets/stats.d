module pshared.packets.stats;

import pnet.packet;


/// 8001
final class StatsRequest : Packet
{
  public:
  final:
  ushort strength;
  ushort agility;
  ushort vitality;
  ushort endurance;
  ushort spirit;
  ushort accuracy;

  this(ubyte[] buffer)
  {
    super(buffer);

    strength = read!ushort;
    agility = read!ushort;
    vitality = read!ushort;
    endurance = read!ushort;
    spirit = read!ushort;
    accuracy = read!ushort;
  }
}
