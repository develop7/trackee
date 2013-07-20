namespace info.develop7.Trackee {
  int main(string[] args) {
    Gtk.init(ref args);
    
    Shooter sh = new Shooter();
    
    MainLoop l = new MainLoop ();
    TimeoutSource ts = new TimeoutSource.seconds(600);
    
    ts.set_callback(() => {
      if (sh.shoot ()) {
        print(" Boom!");
      }
      print("\n");
      return true;
    });
    
    ts.attach(l.get_context());
    
    l.run ();
    
    return 0;
  }
}
