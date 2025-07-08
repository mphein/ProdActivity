import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Timer;
import Toybox.Lang;
import BackgroundUtils;
import Toybox.Attention;
import Toybox.System;

//! TimerView displays timer countdown, current time, and icons during each phase
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
            
        // Initialize UI elements
        initializeUi(timerDict);
    }

    // TODO: Convert hardcoded layout positions to % of screen size
    // Clean up WatchUi.Text creation.
    // Initializes all Text objects.
    function initializeUi(timerDict as Dictionary) {
        _title = timerDict["title"];
        _headline = timerDict["headline"];
        _currentTime = System.getClockTime();

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

    // Decrements time remaining and calls nextView when timer is up.
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

    // Starts a timer that calls a function every second to decrement time remaining.
    function onLayout(dc as Dc) as Void {
        var timer1 = new Timer.Timer();
        timer1.start(method(:callback1), 1000, true);
        _timer = timer1;
    }
    
    // Called every frame to update and draw all visual elements.  
    function onUpdate(dc as Dc) as Void {
        BackgroundUtils.drawBackground(dc);
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        // Display timer elements.
        _timeRemaining.setText(durationToClock(_duration));
        _timeRemaining.draw(dc);
        _clock.draw(dc);

        // Display current time.
        _currentTime = System.getClockTime();
        var hour = (_currentTime.hour == 0) ? 12: _currentTime.hour % 12;
        _timeDisplay.setText((hour).format("%2d") + ":" + _currentTime.min.format("%02d")); 
        _timeDisplay.draw(dc);

        _headlineTxt.draw(dc);
        _titleTxt.draw(dc);

        // Display pause or play icon.
        if (_play) {
            _pauseBtn.draw(dc);
        } else {
            _playBtn.draw(dc);
        }
    }

    // Converts seconds to MM:SS format string
    function durationToClock(time) as String {
        // Convert duration to Mins:Seconds format
        var mins = time / 60;
        var secs = time % 60;
        return mins.format("%02d") + ":" +  secs.format("%02d");
    }

    // Switches to the next timer or session based on remaining intervals
    function nextView(index) {
        if (index >= TimerFlow.timers.size()) {
            // Completed an interval cycle, loop back and decrement.
            index = 0;
            _intervals -= 1;
        }
        if (_intervals <= 0) {
            // Done with all intervals go back to setup.
            var view = new SessionLengthView(SessionFlow.steps[0]);
            Attention.playTone(Attention.TONE_SUCCESS);
            WatchUi.switchToView(view, new SessionLengthDelegate(view), WatchUi.SLIDE_BLINK);
        } else {
            // Switch to next phase Timer View.
            var phase = TimerFlow.timers[index];
            var view = new TimerView(phase, _intervals);
            Attention.playTone(Attention.TONE_INTERVAL_ALERT);
            WatchUi.switchToView(view, new TimerDelegate(view), WatchUi.SLIDE_BLINK);
        }
    }

    // Clean up timers.
    function onHide() {
        if (_timer != null) {
            _timer.stop();
            _timer = null;
        }   
    }

    // Switches to pause or resume the timer.
    function togglePlay(bool as Boolean) {
        _play = bool;
    }
}