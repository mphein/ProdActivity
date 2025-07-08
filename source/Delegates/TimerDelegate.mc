import Toybox.WatchUi;
import Toybox.Attention;

//! TimerDelegate handles inputs for timer views.
class TimerDelegate extends WatchUi.InputDelegate {
    var _view;

    function initialize(v) {
        WatchUi.InputDelegate.initialize();
        _view = v;
    }

    // Handles inputs to start and pause the timer.
    // Pressing down is a shortcut for testing.
    function onKey(keyEvent) {
        if (keyEvent.getKey() == WatchUi.KEY_ESC) {
            pause();
            return true;
        } if (keyEvent.getKey() == WatchUi.KEY_ENTER) {
            start();
            return true;
        } if (keyEvent.getKey() == WatchUi.KEY_DOWN) {
            Attention.playTone(Attention.TONE_KEY);
            _view._duration = 5;
            return true;
        }
        return false;
    }

    // Allows user to pause timer.
    function pause() {
        Attention.playTone(Attention.TONE_STOP);
        _view.togglePlay(false);
    }

    // Allows user to resume timer.
    function start() {
        Attention.playTone(Attention.TONE_START);
        _view.togglePlay(true);
    }
}