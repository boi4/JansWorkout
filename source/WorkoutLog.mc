using Toybox.Application.Storage;

//
// an entry in the storage consists of
// [unixtime, progressionposition, [10,8,6,4,4]]
//

function loadWorkoutLogFromStorage(workoutType) {
    var wl = new WorkoutLog();
    wl.setType(workoutType);
    var workoutArray = Storage.getValue(workoutType);
    if (workoutArray != null) {
        wl.setArray(workoutArray);
    } else {
        wl.setArray(new [0]);
    }
    return wl;
}

class WorkoutLog {
    var _workoutArray;
    var _workoutType;

    function setArray(wArray) {
        self._workoutArray = wArray;
    }

    function setType(type) {
        self._workoutType = type;
    }

    function saveToStorage() {
        Storage.setValue(self._workoutType, self._workoutArray);
    }

    function addWorkout(progressionPosition) {
        //self._workoutLog.add()
        1;
    }

    // return Progression Position of last workout
    function getLastPosition() {
        return self._workoutArray[-1][1];
    }
}
