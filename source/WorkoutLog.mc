using Toybox.Application.Storage;

//
// an entry in the storage consists of
// [unixtime, [10,8,6,4,4], progressionposition]
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

// TODO: use initialize instead of setters
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
        var arr = [Time.now().value(), workoutData[self._workoutType]["workoutMatrix"][progressionPosition], progressionPosition];
        self._workoutArray.add(arr);
    }

    // return Progression Position of last workout
    function getLastPosition() {
        if (self._workoutArray.size() == 0) {
            return null;
        } else {
            System.println(self._workoutArray[self._workoutArray.size() - 1][2]);
            return self._workoutArray[self._workoutArray.size() - 1][2];
        }
    }
}
