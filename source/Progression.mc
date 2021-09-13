
function loadProgression(workoutType) {
    var pdict = workoutData[workoutType];
    var p = new Progression();
    p.setProgression(pdict["pauseTime"], pdict["progressionMatrix"]);
    return p;
}

class Progression {

    var _pauseTime;
    var _progressionMatrix;

    function setProgression(pauseTime, progressionMatrix) {
        self._pauseTime = pauseTime;
        self._progressionMatrix = progressionMatrix;
    }

    function getSetsByPosition(position) {
        return self._progressionMatrix[position];
    }

    function getPauseTime() {
        return self._pauseTime;
    }
}
