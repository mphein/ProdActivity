using Toybox.WatchUi;
import Toybox.Graphics;
import DurationLimits;
import BackgroundUtils;

class SessionLengthView extends WatchUi.View {

    var currentValue;
    var line1;
    var line2;

    function initialize() {
        line1 = new WatchUi.Text({
            :text=>"Set session",
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_TINY,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>60,
            :textAlign=>Graphics.TEXT_JUSTIFY_CENTER
        });
        line2 = new WatchUi.Text({
            :text=>"length",
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_TINY,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>100,
            :textAlign=>Graphics.TEXT_JUSTIFY_CENTER
        });
    }

    function onUpdate(dc as Dc) as Void {
        currentValue = Application.getApp().getDuration(3); // Get current total duration
        dc.clear();

        // Draw background
        BackgroundUtils.drawBackground(dc);
        
        line1.draw(dc);
        line2.draw(dc);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        var sliderX = dc.getWidth() / 8; // start of x Slider
        var sliderY = dc.getHeight() / 2; // height of Slider
        var sliderWidth = dc.getWidth() / 1.3; // width of Slider
        var sliderHeight = 4; // thickness of Slider
        var radius = 8; // radius of thumb circle

        // Draw slider line
        dc.fillRectangle(sliderX, sliderY, sliderWidth, sliderHeight);

        // Calculate thumb position based on current value
        System.println(currentValue);
        // Fixed a bug where percent was not calculated correctly (all Integers so percent was always 0)
        var percent = (currentValue - DurationLimits.total["min"]) * 1.0 / (DurationLimits.total["max"] - DurationLimits.total["min"]);
        System.println(percent + "%");
        var thumbX = sliderX + (sliderWidth * percent);
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(thumbX, sliderY + sliderHeight/2, radius);
        dc.drawText(dc.getWidth() / 2, sliderY + 20, Graphics.FONT_NUMBER_MILD, currentValue.toString() + " min", Graphics.TEXT_JUSTIFY_CENTER);
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        // Lower Limit
        dc.drawText(dc.getWidth() / 8 - 10, sliderY + 15, Graphics.FONT_XTINY, DurationLimits.total["min"].toString(), Graphics.TEXT_JUSTIFY_LEFT);
        // Upper Limit
        dc.drawText(dc.getWidth() * 0.9 + 20, sliderY + 15, Graphics.FONT_XTINY, DurationLimits.total["max"].toString(), Graphics.TEXT_JUSTIFY_RIGHT);

    }       

    function invalidate() as Void {
        WatchUi.requestUpdate();
    }
}