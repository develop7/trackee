namespace info.develop7.Trackee {
  class Main : Object {
    protected Shooter sh;
    
    public MainLoop loop;
    
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
    }
    
    public void run () {
      active_changed.connect ((state) => {
        if (state) {
          sh.run ();
        } 
        else { 
          sh.stop ();
        }
      });
      sh.run ();
      loop.run ();
    }
    
    static int main(string[] args) {
      var m = new Main (args);
      
      m.run();
      
      return 0;
    }
  }
}

