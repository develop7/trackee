namespace info.develop7.Trackee {
  class Main : Object {
    protected Shooter sh;
    
    public MainLoop loop;
    
    protected Server srv;
    
    protected bool _active = true; 
    
    public bool active { 
      get { return _active; } 
      set {
        active_changed (value);
        _active = value;
      }
    }
    
    public signal void active_changed (bool state);
    
    public Main (string[] args) {
      Gtk.init(ref args);
      
      loop = new MainLoop ();
      
      sh = new Shooter (loop);
      srv = new Server ();
    }
    
    public void handle_active_changed (bool state) {
      stderr.printf (state.to_string () + "\n");
      if (state) {
        sh.run ();
      } 
      else { 
        sh.stop ();
      }
    }
    
    public void run () {
      active_changed.connect (handle_active_changed);
      register_bus_name ();
      srv.active_changed.connect (handle_active_changed);
      sh.run ();
      loop.run ();
    }
    
    protected void server_on_bus_acquired (DBusConnection conn) {
      try {
        conn.register_object (Server.OBJECT_PATH, this.srv);
      } 
      catch (IOError e) {
        stderr.printf ("Could not register service: %s \n", e.message);
      }
    }
    
    protected void register_bus_name () {
      Bus.own_name (BusType.SESSION, "info.develop7.Trackee.Shooter", BusNameOwnerFlags.NONE,
          server_on_bus_acquired,
          () => {},
          () => stderr.printf ("Could not acquire name\n"));
    }
    
    static int main(string[] args) {
      var m = new Main (args);
      
      m.run();
      
      return 0;
    }
  }
}

