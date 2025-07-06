import Toybox.Graphics;
import Toybox.WatchUi;
import BackgroundUtils;
import Toybox.Timer;
import SessionFlow;

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
        var nextView = new SessionLengthView(SessionFlow.steps[0]["title1"], SessionFlow.steps[0]["title2"], SessionFlow.steps[0]["phase"]);
        WatchUi.switchToView(nextView, new SessionLengthDelegate(nextView), WatchUi.SLIDE_BLINK);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}