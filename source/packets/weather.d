module pshared.packets.weather;

import pnet.packet;

enum WeatherType : ushort
{
  rain,
  rainThunder,
  thunder,
  snow,
  blossom,
  fall,
  summerLeaves,
  sandstorm,
  dirt,
  // No intensities:
  day, // This will only be triggered once. (No filter)
  dawn, // This will only be triggered once. (Light orange/red gradient)
  night, // This will only be triggered once. (Dark but towards blue)
  sunset, // This will only be triggered once. (Dark orange/red gradient)
  dark, // This will only be triggered once. (Dark but towards black)
  flashlight, // This will only be triggered once. (Small portion visible only)
  earthquake, // This will only be triggered once. (Shakes screen)
  // Intensity = Color:
  color
}

/// 22001
final class WeatherResponse
{
  public:
  final:
  WeatherType type;
  uint intensity;

  this()
  {
    super(8, 22001);
  }

  override ubyte[] finalize()
  {
    write!ushort(cast(ushort)type);
    write!uint(intensity);

    return super.finalize;
  }
}
