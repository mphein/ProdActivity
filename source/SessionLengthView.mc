using Toybox.WatchUi;
import Toybox.Graphics;
import DurationLimits;
import BackgroundUtils;

class SessionLengthView extends WatchUi.View {
    var currentValue;
    var line1;
    var line2;
    var phaseId;
    var _title1;
    var _title2;

    function initialize(t1, t2, phase) {
        phaseId = phase;
        _title1 = t1;
        _title2 = t2;
        WatchUi.View.initialize();
        line1 = new WatchUi.Text({
            :text=>_title1,
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_TINY,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>70,
            :textAlign=>Graphics.TEXT_JUSTIFY_CENTER
        });
        line2 = new WatchUi.Text({
            :text=>_title2,
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_TINY,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>110,
            :textAlign=>Graphics.TEXT_JUSTIFY_CENTER
        });
    }

    function onUpdate(dc as Dc) as Void {
        currentValue = Application.getApp().getDuration(phaseId); // Get current total duration
        dc.clear();

        // Draw background
        BackgroundUtils.drawBackground(dc);
        
        line1.draw(dc);
        line2.draw(dc);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        var sliderX = dc.getWidth() / 8; // start of x Slider
        var sliderY = dc.getHeight() / 2; // height of Slider
        var sliderWidth = dc.getWidth() / 1.33; // width of Slider
        var sliderHeight = 4; // thickness of Slider
        var radius = 8; // radius of thumb circle

        // Draw slider line
        dc.fillRectangle(sliderX, sliderY, sliderWidth, sliderHeight);

        // Calculate thumb position based on current value
        System.println(currentValue);
        // Fixed a bug where percent was not calculated correctly (all Integers so percent was always 0)
        var percent = (currentValue - DurationLimits.limits[phaseId]["min"]) * 1.0 / (DurationLimits.limits[phaseId]["max"] - DurationLimits.limits[phaseId]["min"]);
        System.println(percent + "%");
        var thumbX = sliderX + (sliderWidth * percent);
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(thumbX, sliderY + sliderHeight/2, radius);
        dc.drawText(dc.getWidth() / 2, sliderY + 20, Graphics.FONT_NUMBER_MILD, currentValue.toString() + " min", Graphics.TEXT_JUSTIFY_CENTER);
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        // Lower Limit
        dc.drawText(dc.getWidth() / 8 - 10, sliderY + 15, Graphics.FONT_XTINY, DurationLimits.limits[phaseId]["min"].toString(), Graphics.TEXT_JUSTIFY_LEFT);
        // Upper Limit
        dc.drawText(dc.getWidth() * 0.9 + 10, sliderY + 15, Graphics.FONT_XTINY, DurationLimits.limits[phaseId]["max"].toString(), Graphics.TEXT_JUSTIFY_RIGHT);

    }       

    function invalidate() as Void {
        WatchUi.requestUpdate();
    }
}