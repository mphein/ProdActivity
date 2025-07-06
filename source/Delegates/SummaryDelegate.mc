import Toybox.WatchUi;

class SummaryDelegate extends WatchUi.InputDelegate {
    var _view;
    function initialize(v) {
        WatchUi.InputDelegate.initialize();
        _view = v;
    }

    
}