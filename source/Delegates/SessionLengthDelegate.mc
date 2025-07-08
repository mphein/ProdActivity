using Toybox.System;
using Toybox.WatchUi;
import DurationLimits;
import SessionFlow;
import Toybox.Attention;
import Toybox.Lang;

//! Handles key inputs for adjusting session length settings.
class SessionLengthDelegate extends WatchUi.InputDelegate {
    var _view;    // Reference to current view.
    var _phaseId; // ID of current phase.
    var _incr;    // increment for current phase.
    var _lowLim;  // maximum phase duration.
    var _upLim;   // minimum phase duration.

    function initialize(v) {
        WatchUi.InputDelegate.initialize();
        _view = v;
        _phaseId = _view.getPhaseId();

        // Retrieve and assign limits and incr from current phase.
        var limit = DurationLimits.limits[_phaseId] as Dictionary;
        _lowLim = limit["min"];
        _upLim = limit["max"]; 
        _incr = limit["incr"];
    }
    
    // Processes and delegates various key events including:
    // UP, DOWN, ESC, ENTER.
    function onKey(keyEvent) {
        if (keyEvent.getKey() == WatchUi.KEY_UP) {
            System.println("DEBUG: KEY_UP");
            btnPress();
            onUp();
            return true;
        } if (keyEvent.getKey() == WatchUi.KEY_DOWN) {
            System.println("DEBUG: KEY_DOWN");
            btnPress();
            onDown();
            return true;
        } if (keyEvent.getKey() == WatchUi.KEY_ENTER) {
            System.println("DEBUG: KEY_SELECT");
            btnPress();
            onSelect();
            return true;
        } if (keyEvent.getKey() == WatchUi.KEY_ESC) {
            System.println("DEBUG: KEY_ESC");
            btnPress();
            onEsc();
            return true;
        }
        return false;
    }

    // Called when the UP key is pressed. Increases duration if not at max.
    function onUp() {
        var currentValue = Application.getApp().getDuration(_phaseId);

        if (currentValue < _upLim) {
            currentValue += _incr;
            Application.getApp().setDuration(_phaseId, currentValue);
            _view.invalidate();
            return true;
        }
        return false;
    }

    // Called when the DOWN key is pressed. Decrements duration if not at min.
    function onDown() {
        var currentValue = Application.getApp().getDuration(_phaseId);

        if (currentValue > _lowLim) {
            currentValue -= _incr;
            Application.getApp().setDuration(_phaseId, currentValue);
            _view.invalidate();
            return true;
        }
        return false;
    }

    // Called when the ESC key is pressed.
    // Switches to PREVIOUS view to readjust settings.
    function onEsc() {
        var currentIndex = SessionFlow.findPhaseIndex(_phaseId);
        if (currentIndex > 0 && currentIndex < SessionFlow.count()) {
            var prevStep = SessionFlow.steps[currentIndex - 1];
            var prevView = new SessionLengthView(prevStep);
            WatchUi.switchToView(prevView, new SessionLengthDelegate(prevView), WatchUi.SLIDE_BLINK);
            return true;
        }
        return false;

    }

    // Called when the ENTER key is pressed.
    // Switches to NEXT view to lock in settings.
    function onSelect() {
        // Confirm selection 
        var currentValue = Application.getApp().getDuration(_phaseId);
        Application.getApp().setDuration(_phaseId, currentValue);

        // Switch to the next view
        var currentIndex = SessionFlow.findPhaseIndex(_phaseId);
        if (currentIndex >= 0 && currentIndex < SessionFlow.steps.size() - 1) {
            var nextStep = SessionFlow.steps[currentIndex + 1];
            var nextView = new SessionLengthView(nextStep);
            WatchUi.switchToView(nextView, new SessionLengthDelegate(nextView), WatchUi.SLIDE_BLINK);
        } else {
            var summaryView = new SummaryView();
            var summaryDelegate = new SummaryDelegate(summaryView);
            WatchUi.switchToView(summaryView, summaryDelegate, WatchUi.SLIDE_BLINK);
        }
    }

    //! Plays a short noise when keys are pressed.
    function btnPress() { 
        Attention.playTone(Attention.TONE_KEY);
    }
}