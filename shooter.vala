using Gtk;

namespace info.develop7.Trackee 
{
	class Shooter 
	{
		static int main(string[] args) 
		{
			Gtk.init (ref args);

			int width, height;

			Gdk.Window win = Gdk.get_default_root_window();

			width = win.get_width(); height = win.get_height();

			Gdk.Pixbuf shot = Gdk.pixbuf_get_from_window(win, 0, 0, width, height);

			try {
				shot.save("shot.png", "png");
			}
			catch (GLib.Error e) {
				return 1;
			}
			return 0;
		}
	}
}