import Toybox.WatchUi;
import SessionFlow;
import TimerFlow;

class SummaryDelegate extends WatchUi.InputDelegate {
    var _view;
    function initialize(v) {
        WatchUi.InputDelegate.initialize();
        _view = v;
    }

    function onKey(keyEvent) {
        if (keyEvent.getKey() == WatchUi.KEY_ESC) {
            System.println("GO back to selection");
            onEsc();
            return true;
        } if (keyEvent.getKey() == WatchUi.KEY_ENTER) {
            System.println("TIMER TIME");
            onEnter();
            return true;
        }
        return false;
    }
    
    // OnEsc returns back to the last Session length menu.
    function onEsc() { 
        var lastSession = SessionFlow.steps[SessionFlow.steps.size() - 1];
        var lastView = new SessionLengthView(lastSession["title1"], lastSession["title2"], lastSession["phase"]);
        WatchUi.switchToView(lastView, new SessionLengthDelegate(lastView), WatchUi.SLIDE_BLINK);
        Attention.playTone(Attention.TONE_KEY);
    }

    function onEnter() {
        var nextView = new TimerView(TimerFlow.timers[0], Application.getApp().getDuration(DurationType.INTERVALS));
        WatchUi.switchToView(nextView, new TimerDelegate(nextView), WatchUi.SLIDE_BLINK);  
        Attention.playTone(Attention.TONE_START);
    }
}