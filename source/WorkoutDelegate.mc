using Toybox.WatchUi;

class WorkoutDelegate extends WatchUi.InputDelegate {
    var _parentView;

    function initialize(view) {
        InputDelegate.initialize();
        self._parentView = view;
    }

    function onKey(keyEvent) {
        if (keyEvent.getKey() == WatchUi.KEY_ENTER) {
            
            System.println("next");
            self._parentView.next();
        }
        if (keyEvent.getKey() == WatchUi.KEY_ESC) {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
    }
}
