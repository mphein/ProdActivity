using Toybox.System;
using Toybox.WatchUi;
import DurationLimits;
import SessionFlow;

class SessionLengthDelegate extends WatchUi.InputDelegate {
    var _view;

    function initialize(v) {
        WatchUi.InputDelegate.initialize();
        _view = v;
    }

    function onKey(keyEvent) {
        if (keyEvent.getKey() == WatchUi.KEY_UP) {
            System.println("onKey: KEY_UP");
            onUp();
            return true;
        } if (keyEvent.getKey() == WatchUi.KEY_DOWN) {
            System.println("onKey: KEY_DOWN");
            onDown();
            return true;
        } if (keyEvent.getKey() == WatchUi.KEY_ENTER) {
            System.println("onKey: KEY_SELECT");
            onSelect();
            return true;
        } // Handle Back key functionality here
        return false;
    }

    // Checks if the current value is within the limits and updates the view.
    function onUp() {
        System.println("onUp called");
        if (_view.currentValue < DurationLimits.limits[_view.phaseId]["max"]) {
            _view.currentValue += DurationLimits.limits[_view.phaseId]["incr"];
            Application.getApp().setDuration(_view.phaseId, _view.currentValue);
            _view.invalidate();
            return true;
        }
        return false;
    }

    function onDown() {
        System.println("onDown called");
        if (_view.currentValue > DurationLimits.limits[_view.phaseId]["min"]) {
            _view.currentValue -= DurationLimits.limits[_view.phaseId]["incr"];
            Application.getApp().setDuration(_view.phaseId, _view.currentValue);
            _view.invalidate();
            return true;
        }
        return false;
    }

    function onSelect() {
        // Confirm selection 
        Application.getApp().setDuration(_view.phaseId, _view.currentValue);

        // Switch to the next view
        var currentIndex = SessionFlow.findPhaseIndex(_view.phaseId);
        if (currentIndex >= 0 && currentIndex < SessionFlow.steps.size() - 1) {
            var nextStep = SessionFlow.steps[currentIndex + 1];
            var nextView = new SessionLengthView(nextStep["title1"], nextStep["title2"], nextStep["phase"]);
            WatchUi.switchToView(nextView, new SessionLengthDelegate(nextView), WatchUi.SLIDE_BLINK);
        } else {
            System.println("Total Session " + Application.getApp().getDuration(DurationType.TOTAL));
            System.println("Active Session " + Application.getApp().getDuration(DurationType.ACTIVE));
            System.println("Rest Session " + Application.getApp().getDuration(DurationType.REST));
        }
        System.println("onSelect called, switching to active session length view");
    }
}