namespace info.develop7.Trackee {
  class Shooter : Object {
    const string SHARE_DIR = "trackee";
    const string DATA_DIR = "data";
    const int SHOOT_TIMEOUT = 600; //TODO: should be configurable
    
    Util.ScreensaverInfo ssi;
    
    MainLoop loop;
    
    TimeoutSource tsrc;
    
    public Shooter (MainLoop l) {
      ssi = new Util.ScreensaverInfo ();
      ssi.active_changed.connect (handle_active_changed);
      
      loop = l;
    }
    
    protected void set_periodic_shooting (bool enabled) {
      if (enabled) {
        tsrc = new TimeoutSource.seconds(SHOOT_TIMEOUT);
        
        tsrc.set_callback(() => {
          shoot ();
          return true;
        });
        tsrc.attach(loop.get_context());
      }
      else {
        tsrc.destroy ();
      }
    }
    
    bool _is_enabled = true;
    
    protected string date_prefix() {
      DateTime dt = new DateTime.now_utc();
      return dt.format("%Y%m%d%H%M%S");
    }
    
    protected void handle_active_changed (bool is_active) {
      set_periodic_shooting (_is_enabled);
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
      try {
        if (!ssi.is_running ()) {
          return save_screenshot();
        }
        
        return true;
      }
      catch (IOError e) {
        return false;
      }
      catch (DBusError e) {
        return false;
      }
    }
    
    public void run () {
      shoot ();
      
      set_periodic_shooting (_is_enabled);
    }
    
    public void stop () {
      shoot ();
      
      _is_enabled = false;
      set_periodic_shooting (_is_enabled);
    }
  }
}

