import Toybox.WatchUi;
import Toybox.Graphics;
import BackgroundUtils;
import DurationType;


class SummaryView extends WatchUi.View {
    var _intervals;
    var _activeDur;
    var _restDur;
    var _focusDur;

    var _intervalStr;
    var _intervalStr2;
    var _activeStr;
    var _activeStr2;
    var _restStr;
    var _restStr2;
    var _focusStr;
    var _focusStr2;

    function initialize() {
        WatchUi.View.initialize();
        _activeDur = Application.getApp().getDuration(DurationType.ACTIVE);
        _intervals = Application.getApp().getDuration(DurationType.INTERVALS);
        _focusDur = Application.getApp().getDuration(DurationType.FOCUS);
        _restDur = Application.getApp().getDuration(DurationType.REST);
        System.println(_activeDur + " " + _intervals + " "  + _focusDur + " " + _restDur);
        _focusStr = labels("Focus:", 80, 130);
        _activeStr = labels("Active:", 80, 180);
        _restStr = labels("Rest:", 80, 230);
        _intervalStr = labels("Intervals:", 80, 280);

        _focusStr2 = values(_focusDur.toString() + " mins", 250, 130);
        _activeStr2 = values(_activeDur.toString() + " mins", 250, 180);
        _restStr2 = values(_restDur.toString() + " mins", 250, 230);
        _intervalStr2 = values(_intervals.toString(), 265, 280);
    }

    function onUpdate(dc as Dc) as Void {
        dc.clear();
        BackgroundUtils.drawBackground(dc);
        _focusStr.draw(dc);
        _activeStr.draw(dc);
        _restStr.draw(dc);
        _intervalStr.draw(dc);
        _focusStr2.draw(dc);
        _activeStr2.draw(dc);
        _restStr2.draw(dc);
        _intervalStr2.draw(dc);

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

    function values(str, xPos, yPos) as WatchUi.Text {
        var txt = new WatchUi.Text({
            :text=>str,
            :color=>Graphics.COLOR_BLUE,
            :font=>Graphics.FONT_TINY,
            :locX=>xPos,
            :locY=>yPos,
            :textAlign=>Graphics.TEXT_JUSTIFY_LEFT
        });
        return txt;
    }
}