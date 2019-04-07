module pshared.packets.title;

import pnet.packet;

enum TitleAction : ushort
{
  list,
  newTitle,
  selectTitle,
  createTitle
}

/// 45001
final class TitleRequest : Packet
{
  public:
  final:
  TitleAction action;
  dstring title;

  this(ubyte[] buffer)
  {
    super(buffer);

    action = (read!ushort).qcast!TitleAction;
    title = read!dstring;
  }
}

/// 45002
final class TitleListResponse : Packet
{
  public:
  final:
  TitleAction action;
  // FORMAT: {TITLE} || {COLOR}
  dstring selectedTitle;
  dstring[] titles;

  this()
  {
    super(6, 45002);
  }

  override ubyte[] finalize()
  {
    expand(sumStringSizeSeparate([selectedTitle], 4, 2));

    write!dstring(selectedTitle);

    if (titles && titles.length)
    {
      expand(sumStringSize(titles, 4, 2));

      write!ushort(titles.length);

      foreach (title; titles)
      {
        write!dstring(title);
      }
    }

    return super.finalize;
  }
}
