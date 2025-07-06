import Toybox.WatchUi;
import Toybox.Graphics;
import BackgroundUtils;
import DurationType;


class SummaryView extends WatchUi.View {
    var _totalDur;
    var _activeDur;
    var _restDur;
    var _focusDur;

    var _totalStr;
    var _activeStr;
    var _restStr;
    var _focusStr;

    function initialize() {
        WatchUi.View.initialize();
        _activeDur = Application.getApp().getDuration(DurationType.ACTIVE);
        _totalDur = Application.getApp().getDuration(DurationType.TOTAL);
        _focusDur = Application.getApp().getDuration(DurationType.FOCUS);
        _restDur = Application.getApp().getDuration(DurationType.REST);
        System.println(_activeDur + " " + _totalDur + " "  + _focusDur + " " + _restDur);
        _totalStr = labels("Duration:", 80, 130);
        _focusStr = labels("Focus:", 80, 180);
        _activeStr = labels("Active:", 80, 230);
        _restStr = labels("Rest:", 80, 280);

    }

    function onUpdate(dc as Dc) as Void {
        dc.clear();
        BackgroundUtils.drawBackground(dc);
        _totalStr.draw(dc);
        _focusStr.draw(dc);
        _activeStr.draw(dc);
        _restStr.draw(dc);
    }

    function labels(str, xPos, yPos) as WatchUi.Text {
        var txt = new WatchUi.Text({
            :text=>str,
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_TINY,
            :locX=>xPos,
            :locY=>yPos,
            :textAlign=>Graphics.TEXT_JUSTIFY_LEFT
        });
        return txt;
    }

}