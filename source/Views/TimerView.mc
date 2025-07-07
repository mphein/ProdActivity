import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Timer;
import Toybox.Lang;
import BackgroundUtils;
import Toybox.Attention;
import Toybox.System;

class TimerView extends WatchUi.View {
    var _duration;
    var _title as String = "";
    var _headline as String = "";
    var _phase;
    var _play = false;
    var _currentTime;
    var _timer;
    var _intervals;

    // UI ELEMENTS
    var _timeRemaining;
    var _clock;
    var _pauseBtn;
    var _playBtn;
    var _timeDisplay;
    var _titleTxt;
    var _headlineTxt;


    function initialize(timerDict as Dictionary, intervals) {
        WatchUi.View.initialize();
        // Initialize Timer for this phase from TimerFlow Dictionary.
        _phase = timerDict["phase"];
        _duration = Application.getApp().getDuration(_phase) * 60;
        _intervals = intervals;
        System.println(_duration);
        
        // Initialize UI elements
        initializeUi(timerDict);
    }

    function initializeUi(timerDict as Dictionary) {
        _title = timerDict["title"];
        _headline = timerDict["headline"];

        _timeRemaining = new WatchUi.Text({
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
            :locY=>174
        });

        _pauseBtn = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.pause,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER + 360
        });

        _playBtn = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.play,
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER + 360
        });

        _currentTime = System.getClockTime();

        _timeDisplay = new WatchUi.Text({
            :text => _currentTime.hour.format("%02d") + ":" + _currentTime.min.format("%02d"), 
            :locX => WatchUi.LAYOUT_HALIGN_CENTER,
            :locY => WatchUi.LAYOUT_VALIGN_TOP + 35,
            :font => Graphics.FONT_SYSTEM_TINY,
            :color => Graphics.COLOR_BLUE,
            :textAlign => Graphics.TEXT_JUSTIFY_CENTER
        });

        _titleTxt = new WatchUi.Text({
            :text => _title,
            :locX => WatchUi.LAYOUT_HALIGN_CENTER,
            :locY => 100,
            :font => Graphics.FONT_SYSTEM_MEDIUM,
            :color => Graphics.COLOR_WHITE,
            :textAlign => Graphics.TEXT_JUSTIFY_CENTER
        });

        _headlineTxt = new WatchUi.Text({
            :text => _headline,
            :locX => WatchUi.LAYOUT_HALIGN_CENTER,
            :locY => 300,
            :font => Graphics.FONT_SYSTEM_XTINY,
            :color => Graphics.COLOR_WHITE,
            :textAlign => Graphics.TEXT_JUSTIFY_CENTER
        });
    }

    function callback1() as Void {
        if (_play) {
            _duration -= 1;
        }
        WatchUi.requestUpdate();

        if (_duration <= 0) {
            // Switch to next view
            nextView(TimerFlow.findPhaseIndex(_phase) + 1);
        }
    }

    function onLayout(dc as Dc) as Void {
        var timer1 = new Timer.Timer();

        timer1.start(method(:callback1), 1000, true);
        _timer = timer1;
    }

    function onUpdate(dc as Dc) as Void {
        BackgroundUtils.drawBackground(dc);
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);

        _timeRemaining.setText(durationToClock(_duration));
        _timeRemaining.draw(dc);
        _clock.draw(dc);
        _currentTime = System.getClockTime();
        _timeDisplay.setText((_currentTime.hour % 12).format("%2d") + ":" + _currentTime.min.format("%02d")); 
        _timeDisplay.draw(dc);

        _headlineTxt.draw(dc);
        _titleTxt.draw(dc);

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

    function nextView(index) {
        if (index >= TimerFlow.timers.size()) {
            // Completed an interval cycle, loop back and decrement.
            index = 0;
            _intervals -= 1;
        }
        if (_intervals <= 0) {
            // Done with all intervals go back to setup.
            var view = new SessionLengthView(SessionFlow.steps[0]["title1"], SessionFlow.steps[0]["title2"], SessionFlow.steps[0]["phase"]);
            Attention.playTone(Attention.TONE_SUCCESS);
            WatchUi.switchToView(view, new SessionLengthDelegate(view), WatchUi.SLIDE_BLINK);
        } else {
            var phase = TimerFlow.timers[index];
            var view = new TimerView(phase, _intervals);
            Attention.playTone(Attention.TONE_INTERVAL_ALERT);
            WatchUi.switchToView(view, new TimerDelegate(view), WatchUi.SLIDE_BLINK);
        }
    }

    function onHide() {
        if (_timer != null) {
            _timer.stop();
            _timer = null;
        }   
    }

    function togglePlay(bool as Boolean) {
        _play = bool;
    }
}