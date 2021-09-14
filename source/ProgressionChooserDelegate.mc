using Toybox.WatchUi;

class ProgressionChooserDelegate extends WatchUi.Menu2InputDelegate {
    var _workoutType;
    var _workoutLog;
    var _progression;

    function initialize(workoutType, workoutLog, progression) {
        Menu2InputDelegate.initialize();
        self._workoutType = workoutType;
        self._workoutLog = workoutLog;
        self._progression = progression;
    }

    function onSelect(item) {
        var view = new WorkoutView(self._workoutType, self._workoutLog, self._progression, item.getId());
        var delegate = new WorkoutDelegate(view);
        WatchUi.pushView(view, delegate, WatchUi.SLIDE_IMMEDIATE);
    }

    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}
