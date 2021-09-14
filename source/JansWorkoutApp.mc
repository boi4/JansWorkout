using Toybox.Application;
using Toybox.Lang;
using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application.Properties;

(:debug) function printVersion() {
    System.println("Running in Debug Mode");
}

(:release) function printVersion() {
    System.println("Running in Release Mode");
}


class JansWorkoutApp extends Application.AppBase {

    var _workoutTypes;

    //var _progressions = {};
    //var _workoutLogs = {};


    function initialize() {
        AppBase.initialize();

        self._workoutTypes = workoutData.keys();
        //for (var i = 0; i < self._workoutTypes.size(); i++) {
        //    var workoutType = self._workoutTypes[i];
        //    System.print("Loading workout data for workout type: ");
        //    System.println(workoutType);
        //    self._workoutLogs[workoutType] = loadWorkoutLogFromStorage(workoutType);
        //    self._progressions[workoutType] = loadProgression(workoutType);
        //}
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        //if (state != null) {
        //    if (state.get(:launchedFromGlance)) {
        //    // Launched from glance
        //    }
        //    else if (state.get(:resume)) {
        //    // resumed
        //    }
        //} else {
        //    //
        //}
        System.println("Hello World!");
        System.println(System.getTimer());
        printVersion();
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        //if ((state != null) && (state.get(:suspend)) {
            // only temporary suspension, save state?
        //}
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        var menu = new WatchUi.Menu2({:title=>"Workout"});
        var delegate;

        // Add a new MenuItem to the Menu2 object
        for (var i = 0; i < self._workoutTypes.size(); i++) {
            var workoutType = self._workoutTypes[i];
            menu.addItem(
                new WatchUi.MenuItem(

                    // Set the 'Label' parameter
                    self.workoutData[workoutType]["prettyName"],

                    // Set the `subLabel` parameter
                    //self.workoutData[workoutType]["prettyName"] + " Workout",
                    "",

                    // Set the `identifier` parameter
                    workoutType,
                    // Set the options, in this case `null`
                    {}
                )
            );
        }

        // Create a new Menu2InputDelegate
        delegate = new WorkoutChooserDelegate(); // a WatchUi.Menu2InputDelegate
        return [ menu, delegate ] as Array<Views or InputDelegates>;
    }

}

function getApp() as JansWorkoutApp {
    return Application.getApp() as JansWorkoutApp;
}
