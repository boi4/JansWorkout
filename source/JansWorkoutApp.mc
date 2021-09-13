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
    var _progressions = {};
    var _workoutLogs = {};


    function initialize() {
        AppBase.initialize();

//        self._workoutTypes = workoutData.keys();
//        for (var i = 0; i < self._workoutTypes.size(); i++) {
//            var workoutType = self._workoutTypes[i];
//            System.print("Loading workout data for workout type: ");
//            System.println(workoutType);
//            self._workoutLogs[workoutType] = loadWorkoutLogFromStorage(workoutType);
//            self._progressions[workoutType] = loadProgression(workoutType);
//        }
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
        System.println("Hello AMK");
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
        //return [ new WorkoutChooserView(), new WorkoutChooserDelegate() ] as Array<Views or InputDelegates>;
        var mainView = new WorkoutChooserView();
        //var mainDelegate = new MyInputDelegate();
        var mainDelegate = new MyInputDelegate();
        return [ mainView, mainDelegate ] as Array<Views or InputDelegates>;
    }

}

//function getApp() as JansWorkoutApp {
//    return Application.getApp() as JansWorkoutApp;
//}
