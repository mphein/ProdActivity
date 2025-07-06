import Toybox.Graphics;
import Toybox.WatchUi;
import BackgroundUtils;

class BackgroundView extends WatchUi.View {
    function initialize() {
        WatchUi.View.initialize();
    }

    function onUpdate(dc as Dc) as Void {
        BackgroundUtils.drawBackground(dc);
    }
}