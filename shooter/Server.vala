namespace info.develop7.Trackee {
  
  [DBus (name = "info.develop7.Trackee.Service")]
  public class Server : Object {
  
    public const string OBJECT_PATH = "/info/develop7/trackee";
    
    protected bool _is_working = true;
    
    protected static Server _instance;
    
    public signal void active_changed (bool is_active);
    
    public bool get_active () {
      return _is_working;
    }
    
    public void set_active (bool is_active) {
      _is_working = is_active;
      active_changed (is_active);
    }
  }
}

