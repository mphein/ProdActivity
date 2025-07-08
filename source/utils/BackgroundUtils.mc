import Toybox.Graphics;

//! BackgroundUtils provides a utility function to draw
//! a persistent circular background with a white border.
module BackgroundUtils {

    // Draws a centered circular background with a white border.
    function drawBackground(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        var centerY = height / 2;
        var outerRadius = (centerX < centerY) ? centerX : centerY;
        var borderThickness = 10;
        var innerRadius = outerRadius - borderThickness;

        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
        dc.fillCircle(centerX, centerY, outerRadius);
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.fillCircle(centerX, centerY, innerRadius);
    }
}