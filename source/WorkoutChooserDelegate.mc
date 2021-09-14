using Toybox.WatchUi;
using Toybox.System;

class WorkoutChooserDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        var workoutType = item.getId();

        System.print("Loading workout data for workout type: ");
        System.println(workoutType);

        var workoutLog = loadWorkoutLogFromStorage(workoutType);
        System.println(workoutType);
        var progression = loadProgression(workoutType);

        var workoutInfo = workoutData[workoutType];
        var menu = new WatchUi.Menu2({:title=>workoutInfo["prettyName"]});
        var delegate;

        var lastPos = workoutLog.getLastPosition();
        System.print("Last position: ");
        System.println(lastPos);

        // Add a new MenuItem to the Menu2 object
        for (var i = 0; i < progression.size(); i++) {
            var workoutArray = progression.getSetsByPosition(i);
            var s = "";
            if (lastPos == null) {
                if (i == 0) {
                    s += "> ";
                }
            } else if (i == lastPos + 1) {
                s += "> ";
            }
            for (var j = 0; j < workoutArray.size(); j++) {
                s += workoutArray[j];
                if (j < workoutArray.size() - 1) {
                    s += "-";
                }
            }
            menu.addItem(
                new WatchUi.MenuItem(

                    // Set the 'Label' parameter
                    s,

                    // Set the `subLabel` parameter
                    //self.workoutData[workoutType]["prettyName"] + " Workout",
                    "",

                    // Set the `identifier` parameter
                    i,
                    // Set the options, in this case `null`
                    {}
                )
            );
        }

        if (lastPos != null && lastPos != progression.size()) {
            menu.setFocus(lastPos + 1);
        }

        // Create a new Menu2InputDelegate
        delegate = new ProgressionChooserDelegate(workoutType, workoutLog, progression); // a WatchUi.Menu2InputDelegate

        WatchUi.pushView(menu, delegate, WatchUi.SLIDE_IMMEDIATE);
    }

    function onBack() {
        System.exit();
    }
}
