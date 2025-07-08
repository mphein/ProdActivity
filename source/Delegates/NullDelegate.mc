import Toybox.WatchUi;

//! An empty delegate for views with no input handling.
class NullDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }
}