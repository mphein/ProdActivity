import Toybox.WatchUi;
import Toybox.Attention;

class TimerDelegate extends WatchUi.InputDelegate {
    var _view;
    function initialize(v) {
        WatchUi.InputDelegate.initialize();
        _view = v;
    }

     function onKey(keyEvent) {
        if (keyEvent.getKey() == WatchUi.KEY_ESC) {
            System.println("GO back to selection");
            pause();
            return true;
        } if (keyEvent.getKey() == WatchUi.KEY_ENTER) {
            System.println("TIMER TIME");
            start();
            return true;
        }
        return false;
    }

    function pause() {
        Attention.playTone(Attention.TONE_STOP);
        _view._play = false;
    }

    function start() {
        Attention.playTone(Attention.TONE_START);
        _view._play = true;
    }
}