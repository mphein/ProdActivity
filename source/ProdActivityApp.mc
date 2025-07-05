import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

module DurationType {
    const FOCUS = 0; // Focus phase duration
    const ACTIVE = 1; // Break phase duration
    const REST = 2; // Rest phase duration
    const TOTAL = 3; // Total session duration
}

class ProdActivityApp extends Application.AppBase {
    var _duration = 30; // Duration of the productivity session in minutes
    var _focusDuration = 22;
    var _activeDuration = 3;
    var _restDuration = 5;

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

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [new LoadingView(), new NullDelegate()];
    }

    function setDuration(phase as Integer, duration as Integer) as Void {
        switch(phase) {
            case DurationType.FOCUS:
                _focusDuration = duration;
                break;
            case DurationType.ACTIVE:
                _activeDuration = duration;
                break;
            case DurationType.REST:
                _restDuration = duration;
                break;
            case DurationType.TOTAL:
                _duration = duration;
                break;
            default:
                System.print("Invalid duration type: " + phase );
        }
    }

    function getDuration(phase as Integer) as Integer {
        switch(phase) {
            case DurationType.FOCUS:
                return _focusDuration;
            case DurationType.ACTIVE:  
                return _activeDuration;      
            case DurationType.REST:
                return _restDuration;
            case DurationType.TOTAL:
                return _duration;
            default:
                System.print("Invalid duration type: " + phase);
                return 0; // Return 0 for invalid phase
        }
    }

}

function getApp() as ProdActivityApp {
    return Application.getApp() as ProdActivityApp;
}