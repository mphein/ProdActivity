using Toybox.System;
using Toybox.WatchUi;
import DurationLimits;

class SessionLengthDelegate extends WatchUi.InputDelegate {
    var view;

    function initialize(v) {
        WatchUi.InputDelegate.initialize();
        view = v;
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
        }
        return false;
    }

    // Checks if the current value is within the limits and updates the view.
    function onUp() {
        System.println("onUp called");
        if (view.currentValue < DurationLimits.total["max"]) {
            view.currentValue += 30;
            Application.getApp().setDuration(3, view.currentValue);
            view.invalidate();
            return true;
        }
        return false;
    }

    function onDown() {
        System.println("onDown called");
        if (view.currentValue > DurationLimits.total["min"]) {
            view.currentValue -= 30;
            Application.getApp().setDuration(3, view.currentValue);
            view.invalidate();
            return true;
        }
        return false;
    }

    function onSelect() {
        // Confirm selection 
        Application.getApp().setDuration(3, view.currentValue);
        return true;
    }
}