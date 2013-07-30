using Gtk;

namespace info.develop7.Trackee {
  class Shooter : Object {
    const string SHARE_DIR = "trackee";
    const string DATA_DIR = "data";
    
    Util.ScreensaverInfo ssi;
    
    construct {
      ssi = new Util.ScreensaverInfo ();
      ssi.active_changed.connect (handle_active_changed);
      is_enabled = !ssi.is_running ();
    }
    
    public bool is_enabled { get; set; }
    
    protected string date_prefix() {
      DateTime dt = new DateTime.now_utc();
      return dt.format("%Y%m%d%H%M%S");
    }
    
    protected void handle_active_changed (bool is_active) {
      is_enabled = !is_active;
    }
    
    protected bool screensaver_active() {
      try {
        return ssi.is_running ();
      } catch (IOError e) {
        return false;
      }
      catch (DBusError e) {
        return false;
      }
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
    
    public bool shoot () {
      if (is_enabled) {
        return save_screenshot();
      }
      
      return true;
    }
  }
}

