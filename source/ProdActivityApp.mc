import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import DurationType;

//! Main application class for managing productivity activity sessions.
//! Handles focus, active, rest durations, and interval counts.
class ProdActivityApp extends Application.AppBase {
    var _intervals = 1; // Duration of the productivity session in minutes
    var _focusDuration = 20;
    var _activeDuration = 5;
    var _restDuration = 5;

    // Constructor initializes the app base class.
    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        System.println("ProdActivityApp started");
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Returns the initial view and input delegate for the app.
    // @return Array containing the starting view and delegate.
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [new LoadingView() , new NullDelegate()];
    }

    // Sets the duration value for a given phase.
    // @param phase One of DurationType constants (FOCUS, ACTIVE, REST, INTERVALS).
    // @param num Integer duration or count to set.
    function setDuration(phase, num as Integer) as Void {
        switch(phase) {
            case DurationType.FOCUS:
                _focusDuration = num;
                break;
            case DurationType.ACTIVE:
                _activeDuration = num;
                break;
            case DurationType.REST:
                _restDuration = num;
                break;
            case DurationType.INTERVALS:
                _intervals = num;
                break;
            default:
                System.print("Invalid duration type: " + phase );
        }
    }

    // Retrieves the duration value for a given phase.
    // @param phase One of DurationType constants.
    // @return Integer duration or count for the phase, or 0 if invalid.
    function getDuration(phase as Integer) as Integer {
        switch(phase) {
            case DurationType.FOCUS:
                return _focusDuration;
            case DurationType.ACTIVE:  
                return _activeDuration;      
            case DurationType.REST:
                return _restDuration;
            case DurationType.INTERVALS:
                return _intervals;
            default:
                System.print("Invalid duration type: " + phase);
                return 0; // Return 0 for invalid phase
        }
    }

}

// Helper function to get the global app instance typed as ProdActivityApp.
// @return Global application instance cast to ProdActivityApp.
function getApp() as ProdActivityApp {
    return Application.getApp() as ProdActivityApp;
}