import Toybox.Graphics;
import Toybox.WatchUi;
import BackgroundUtils;
import Toybox.Timer;

class LoadingView extends WatchUi.View {
    hidden var loadingName;
    function initialize() {
        WatchUi.View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        loadingName = new WatchUi.Text({
            :text=>"ProdActivity",
            :color=>Graphics.COLOR_BLUE,
            :font=>Graphics.FONT_LARGE,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER,
        });

        // Example: switch to BackgroundView after 2 seconds
        var timer = new Timer.Timer();
        timer.start(method(:switchToMain), 2000, false);

    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        BackgroundUtils.drawBackground(dc);
        loadingName.draw(dc);
    }

    function switchToMain() as Void {
        var view = new SessionLengthView("Set your ", "session length:", DurationType.TOTAL);  // 3 is the TOTAL phase
        var delegate = new SessionLengthDelegate(view);
        WatchUi.switchToView(view, delegate, WatchUi.SLIDE_BLINK);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}