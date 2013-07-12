using Gtk;
using GLib;

namespace info.develop7.Trackee {
  class Shooter {
    protected static string date_prefix() {
      DateTime dt = new DateTime.now_utc();
      return dt.format("%Y%m%d%H%M%S");
    }
    static int main(string[] args) {
      Gtk.init (ref args);

      int width, height;

      Gdk.Window win = Gdk.get_default_root_window();

      width = win.get_width(); height = win.get_height();

      Gdk.Pixbuf shot = Gdk.pixbuf_get_from_window(win, 0, 0, width, height);

      try {
        shot.savev("shot" + date_prefix() + ".jpg", "jpeg", new string[1]{"quality"}, new string[1]{"80"});
      }
      catch (GLib.Error e) {
        return 1;
      }
      
      return 0;
    }
  }
}

