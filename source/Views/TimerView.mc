import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Timer;
import Toybox.Lang;
import BackgroundUtils;
import Toybox.Attention;
import Toybox.System;

class TimerView extends WatchUi.View {
    private var _duration;
    var _title as String;
    var _headline as String;
    var _subtxt as String;
    var _phase;
    var _timeLine;
    var _clock;
    var _play = false;
    var _pauseBtn;
    var _playBtn;
    var _currentTime;
    var _timeDisplay;

    function initialize(timerDict as Dictionary) {
        WatchUi.View.initialize();
        // Initialize Timer for this phase from TimerFlow Dictionary.
        _title = timerDict["title"];
        _headline = timerDict["headline"];
        _phase = timerDict["phase"];
        _subtxt = timerDict["subtext"];
        _duration = Application.getApp().getDuration(_phase) * 60;
        System.println(_duration);

        _timeLine = new WatchUi.Text({
            :text=>durationToClock(_duration),
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_NUMBER_MEDIUM,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER + 150,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER,
            :textAlign=>Graphics.TEXT_JUSTIFY_CENTER
        });

        _clock = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.clock,
            :locX=>40,
            :locY=>175
        });

        _pauseBtn = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.pause,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER + 350
        });

        _playBtn = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.play,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER + 350
        });

        _currentTime = System.getClockTime();

        _timeDisplay = new WatchUi.Text({
            :text => _currentTime.hour.format("%02d") + ":" + _currentTime.min.format("%02d"), 
            :locX => WatchUi.LAYOUT_HALIGN_CENTER,
            :locY => WatchUi.LAYOUT_VALIGN_TOP + 25,
            :font => Graphics.FONT_SYSTEM_XTINY,
            :color => Graphics.COLOR_BLUE,
            :textAlign => Graphics.TEXT_JUSTIFY_CENTER
        });
    }

    function callback1() as Void {
        if (_play) {
            _duration -= 1;
        }
        WatchUi.requestUpdate();
    }

    function onLayout(dc as Dc) as Void {
        var timer1 = new Timer.Timer();

        timer1.start(method(:callback1), 1000, true);
    }

    function onUpdate(dc as Dc) as Void {
        BackgroundUtils.drawBackground(dc);
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);

        _timeLine.setText(durationToClock(_duration));
        _timeLine.draw(dc);
        _clock.draw(dc);
        _currentTime = System.getClockTime();
        _timeDisplay.setText((_currentTime.hour % 12).format("%2d") + ":" + _currentTime.min.format("%02d")); 
        _timeDisplay.draw(dc);
        if (_play) {
            _pauseBtn.draw(dc);
        } else {
            _playBtn.draw(dc);
        }
    }

    function durationToClock(time) as String {
        // Convert duration to Mins:Seconds format
        var mins = time / 60;
        var secs = time % 60;
        return mins.format("%02d") + ":" +  secs.format("%02d");
    }
}