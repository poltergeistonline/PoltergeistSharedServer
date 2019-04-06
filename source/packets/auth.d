module pshared.packets.auth;

import pnet.packet;

/// 1005
final class AuthRequest : Packet
{
  public:
  final:
  dstring account;
  dstring password;
  dstring server;

  this(ubyte[] buffer)
  {
    super(buffer);

    account = read!dstring;
    password = read!dstring;
    server = read!dstring;
  }
}

/// 1006
final class AuthResponse : Packet
{
  public:
  final:
  bool success;
  ubyte[] ip;
  ushort port;
  ulong key;
  ulong clientId;
  dstring title;
  dstring message;

  this()
  {
    super(26, 1006);
  }

  override ubyte[] finalize()
  {
    success = success && ip && ip.length == 4;

    write!bool(success);

    if (success)
    {
      write!ubyte(ip[0]);
      write!ubyte(ip[1]);
      write!ubyte(ip[2]);
      write!ubyte(ip[3]);

      write!ushort(port);

      write!ulong(key);
      write!ulong(clientId);
    }

    if (title && title.length && message && message.length)
    {
      expand(sumStringSizeSeparate([title, message], 4, 2));

      write!dstring(title);
      write!dstring(message);
    }

    return super.finalize;
  }
}
