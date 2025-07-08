import Toybox.Graphics;
import Toybox.WatchUi;
import BackgroundUtils;
import Toybox.Timer;
import SessionFlow;

//! LoadingView displays app name and loads first
//! Session selection view.
class LoadingView extends WatchUi.View {
    hidden var loadingName;
    function initialize() {
        WatchUi.View.initialize();

        loadingName = new WatchUi.Text({
            :text=>"ProdActivity",
            :color=>Graphics.COLOR_BLUE,
            :font=>Graphics.FONT_LARGE,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER,
        });
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        // Calls func to switch views after 2 seconds.
        var timer = new Timer.Timer();
        timer.start(method(:switchToMain), 2000, false);
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        BackgroundUtils.drawBackground(dc);
        loadingName.draw(dc);
    }

    // Switches to opening session length selection view.
    function switchToMain() as Void {
        var firstSession = SessionFlow.steps[0];
        var nextView = new SessionLengthView(firstSession);
        WatchUi.switchToView(nextView, new SessionLengthDelegate(nextView), WatchUi.SLIDE_BLINK);
    }
}