using Gtk;
using GLib;

namespace info.develop7.Trackee {
  class Shooter {
    protected string date_prefix() {
      DateTime dt = new DateTime.now_utc();
      return dt.format("%Y%m%d%H%M%S");
    }
    
    protected bool save_screenshot() {
      Gdk.Window win = Gdk.get_default_root_window();

      int width = win.get_width(); int height = win.get_height();

      Gdk.Pixbuf shot = Gdk.pixbuf_get_from_window(win, 0, 0, width, height);

      try {
        shot.savev(date_prefix() + "_shot.jpg", "jpeg", new string[1]{"quality"}, new string[1]{"80"});
      }
      catch (GLib.Error e) {
        return false;
      }
      
      return true;
    }
    
    static int main(string[] args) {
      Gtk.init (ref args);
      
      var sh = new Shooter();

      Timeout.add_seconds(600, () => {
        stderr.puts("Making a screenshot");
        sh.save_screenshot();
        
        return true;
      });
      
      new MainLoop ().run ();
      
      return 0;
    }
  }
}

