namespace info.develop7.Trackee.Util {
  [DBus (name = "org.gnome.ScreenSaver")]
  interface GnomeScreensaver : Object {
    public abstract bool get_active () throws IOError;
    //public abstract void set_active (bool how) throws IOError;
    //public abstract void lock () throws IOError;
    //public abstract uint32 get_active_time () throws IOError;
    public signal void active_changed(bool is_active);
  }
  
  [DBus (name = "org.freedesktop.ScreenSaver")]
  interface FreedesktopScreensaver : Object {
    public abstract bool get_active () throws IOError;
    //public abstract void set_active (bool how) throws IOError;
    //public abstract void lock () throws IOError;
    //public abstract uint32 get_active_time () throws IOError;
    public signal void active_changed(bool is_active);
  }
  
  class ScreensaverInfo : Object {
    
    const string FDO_NAME = "org.freedesktop.ScreenSaver";
    const string FDO_PATH = "/org/freedesktop/ScreenSaver";
    const string GNOME_NAME = "org.gnome.ScreenSaver";
    const string GNOME_PATH = "/";
    
    protected GnomeScreensaver gss;
    protected FreedesktopScreensaver fss;
    
    construct {
      fss = Bus.get_proxy_sync (BusType.SESSION, FDO_NAME, FDO_PATH);
      gss = Bus.get_proxy_sync (BusType.SESSION, GNOME_NAME, GNOME_PATH);
      
      fss.active_changed.connect (handle_active_changed);
      gss.active_changed.connect (handle_active_changed);
    }
    
    public bool is_running () throws DBusError, IOError {
      bool result = false;
      try {
        result = fss.get_active();
      } catch (DBusError e) {
        if (!(e is DBusError.NOT_SUPPORTED)) {
          throw e;
        }
      }
      
      try {
        result = gss.get_active();
      } catch (DBusError e) {
        if (!(e is DBusError.NOT_SUPPORTED)) {
          throw e;
        }
      }
      
      return result;
    }
    
    public signal void active_changed (bool is_active);
    
    protected void handle_active_changed (bool is_active) {
      active_changed (is_active);
    }
  }
}
