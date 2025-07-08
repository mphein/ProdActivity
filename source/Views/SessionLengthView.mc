using Toybox.WatchUi;
import Toybox.Graphics;
import DurationLimits;
import BackgroundUtils;
import Toybox.Lang;

//! SessionLengthView manages the UI for setting durations for different workout phases.
//! It displays titles, renders a slider with current value, and allows interaction
//! through button input to adjust session settings.
class SessionLengthView extends WatchUi.View {
    var _titleLine1;
    var _titleLine2;
    var _phaseId;
    var _title1;
    var _title2;

    function initialize(session as Dictionary) {
        _phaseId = session["phase"]; 
        _title1 = session["title1"];
        _title2 = session["title2"];
        WatchUi.View.initialize();

        // Get text objects for on screen text.
        _titleLine1 = initText(_title1, 70);
        _titleLine2 = initText(_title2, 110);
    }

    // Draws background, slider, and labels.
    function onUpdate(dc as Dc) as Void {
        var currentValue = Application.getApp().getDuration(_phaseId); // Get current total duration
        dc.clear();
        BackgroundUtils.drawBackground(dc);
        
        drawTextHeaders(dc);
        drawSlider(dc, currentValue);
        drawSliderLimits(dc);
    }       

    function drawTextHeaders(dc as Dc) {
        _titleLine1.draw(dc);
        _titleLine2.draw(dc);
    }

    // Draws the slider bar
    function drawSlider(dc as Dc, currentValue as Number) {
        var sliderX = dc.getWidth() / 8; // start of x Slider
        var sliderY = dc.getHeight() / 2; // height y of Slider
        var sliderWidth = dc.getWidth() / 1.33; // width of Slider
        var sliderHeight = 4; // thickness of Slider
        var radius = 8; // radius of thumb circle
        
        // Calculate where the selection circle should be on Slider.
        var limits = DurationLimits.limits[_phaseId] as Dictionary;
        var range = limits["max"] - limits["min"];
        var percent = (currentValue - limits["min"]) * 1.0 / range;

        var thumbX = sliderX + (sliderWidth * percent);
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.fillRectangle(sliderX, sliderY, sliderWidth, sliderHeight);
        
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(thumbX, sliderY + sliderHeight/2, radius);
        dc.drawText(dc.getWidth() / 2, sliderY + 20, Graphics.FONT_NUMBER_MILD, currentValue.toString() + limits["str"] , Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Renders the slider labels.
    function drawSliderLimits(dc as Dc) {
        var sliderY = dc.getHeight() / 2;
        var limits = DurationLimits.limits[_phaseId] as Dictionary;
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() / 8 - 10, sliderY + 15, Graphics.FONT_XTINY, limits["min"].toString(), Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(dc.getWidth() * 0.9 + 10, sliderY + 15, Graphics.FONT_XTINY, limits["max"].toString(), Graphics.TEXT_JUSTIFY_RIGHT);
    }

    //! Requests a screen redraw for this view.
    //! Typically called by the delegate after a user interaction.
    function invalidate() as Void {
        WatchUi.requestUpdate();
    }

    //! Returns the current DurationType (phase) for this view.
    //! @return The phase ID (e.g., FOCUS, ACTIVE, etc.)
    function getPhaseId() {
        return _phaseId;
    }

    // Initializes a WatchUi.Text element with common styles.
    // @param str  The string to display.
    // @param yPos Vertical position of the text.
    // @return A configured WatchUi.Text object.
    function initText(str, yPos) as WatchUi.Text {
       var text = new WatchUi.Text({
            :text=>str,
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_TINY,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>yPos,
            :textAlign=>Graphics.TEXT_JUSTIFY_CENTER
        });
        return text;
    }
}