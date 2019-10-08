public class TextView : Gtk.Application {

    public TextView () {
        Object (
            application_id: "com.github.opensussex.gtk-textview",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this);
        main_window.default_height = 500;
        main_window.default_width = 500;
        main_window.title = "TextView";

        var style = """
            textview text {
                background-color: #131c16;
                color: #3ce85c;
            }
        """;

        var css_provider = new Gtk.CssProvider();
        
        try {
            css_provider.load_from_data(style, -1);
        } catch (GLib.Error e) {
            warning ("Failed to parse css style : %s", e.message);
        }

        Gtk.StyleContext.add_provider_for_screen (
                Gdk.Screen.get_default (),
                css_provider,
                Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            );


        var textview = new Gtk.TextView ();
        textview.left_margin  = 5;
        textview.right_margin  = 5;
        textview.top_margin  = 5;
        textview.bottom_margin  = 5;

        textview.set_wrap_mode (Gtk.WrapMode.WORD);

        var scrolled_window = new Gtk.ScrolledWindow (null, null);
        scrolled_window.set_policy (Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
        scrolled_window.add (textview);

        main_window.add (scrolled_window);

        main_window.show_all ();
    }

    public static int main (string[] args) {
        var app = new TextView ();
        return app.run (args);
    }
}
