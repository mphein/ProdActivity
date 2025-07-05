import Toybox.Graphics;
import Toybox.WatchUi;

class ProdActivityView extends WatchUi.View {
    hidden var loadingName;

    function initialize() {
        WatchUi.View.initialize();
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        loadingName = new WatchUi.Text({
            :text=>"ProdActivity",
            :color=>Graphics.COLOR_DK_BLUE,
            :font=>Graphics.FONT_AUX1,
            :font=>Graphics.FONT_LARGE,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER,
        });
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
