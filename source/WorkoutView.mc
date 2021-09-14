using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Attention;
using Toybox.Lang;
using Toybox.Timer;

class WorkoutView extends WatchUi.View {
    
    var _workoutType;
    var _workoutLog;
    var _progression;
    var _position;
    var _nextSetNr;
    var _inPause;
    var _pauseEnd;
    var _sets;
    var _timer;

    function initialize(workoutType, workoutLog, progression, position) {
        View.initialize();
        self._workoutType = workoutType;
        self._workoutLog = workoutLog;
        self._progression = progression;
        self._position = position;

        self._sets = self._progression.getSetsByPosition(position);
        System.println(self._sets);

        self._nextSetNr = 0;
        self._inPause = false;
    }

    
    // Resources are loaded here
    function onLayout(dc) {
    }

    // onShow() is called when this View is brought to the foreground
    function onShow() {
    }

    function vibrate() {
        var vp = [new Attention.VibeProfile(100, 1000)];
        Attention.vibrate(vp);
    }

    function finished() {
        System.println("finished");
        self._workoutLog.addWorkout(self._position);
        self._workoutLog.saveToStorage();
    }

    function timerCallback() {
        WatchUi.requestUpdate();
        if (Time.now().greaterThan(self._pauseEnd)) {
            next();
        }
    }

    function next() {
        if (self._nextSetNr == self._sets.size()) {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        } else if (!self._inPause && (self._nextSetNr + 1 == self._sets.size())) {
            finished(); // save it!
            self._inPause = true; // so onUpdate knows
            self._nextSetNr += 1; // so next call to next knows
            WatchUi.requestUpdate();
            vibrate();
        } else {
            if (self._inPause) {
                self._inPause = false;
                self._timer.stop();
            } else {
                self._inPause = true;
                self._pauseEnd = Time.now().add(new Time.Duration(self._progression.getPauseTime()));
                self._nextSetNr += 1;
            }
            vibrate();
            if (self._inPause) {
                self._timer = new Timer.Timer();
                self._timer.start(method(:timerCallback), 1000, true);
            }
            WatchUi.requestUpdate();
        }
    }

    // onUpdate() is called periodically to update the View
    function onUpdate(dc) {
        System.println("OnUpdate");
        View.onUpdate(dc);

        var width = 220;

        var s = "";
        for (var i = 0; i < self._sets.size(); i++) {
                s += self._sets[i];
            if (i + 1 != self._sets.size()) {
                s += "-";
            }
        }
        var textWidth = dc.getTextWidthInPixels(s, Graphics.FONT_MEDIUM);
        var start = (width - textWidth)/2;
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        //dc.drawText((width - textWidth)/2, 25, Graphics.FONT_MEDIUM, s, Graphics.TEXT_JUSTIFY_LEFT);
        s = "";
        for (var i = 0; i < self._sets.size(); i++) {
            if (i < self._nextSetNr) {
                dc.setColor(Graphics.COLOR_DK_GREEN, Graphics.COLOR_TRANSPARENT);
            }
            var writtenWidth = dc.getTextWidthInPixels(s, Graphics.FONT_MEDIUM);
            dc.drawText(start + writtenWidth + 1, 10, Graphics.FONT_MEDIUM, "" + self._sets[i], Graphics.TEXT_JUSTIFY_LEFT);
            s += self._sets[i];

            if (i + 1 != self._sets.size()) {
                dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
                writtenWidth = dc.getTextWidthInPixels(s, Graphics.FONT_MEDIUM);
                dc.drawText(start + writtenWidth + 1, 10, Graphics.FONT_MEDIUM, "-", Graphics.TEXT_JUSTIFY_LEFT);
                s += "-";
            }
        }
       	dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_DK_GRAY);
		dc.drawLine(5, 35, width-5, 35);
       	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

        if (self._inPause && self._nextSetNr == self._sets.size()) {
            dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
            dc.drawText(110,90, Graphics.FONT_LARGE, "DONE", Graphics.TEXT_JUSTIFY_CENTER);
        } else {
            var mainString = "";
            if (self._inPause) {
                var toWaitSecs = (self._pauseEnd.subtract(Time.now())).value();
                System.println(toWaitSecs);
                var mins = toWaitSecs / 60;
                var secs = toWaitSecs % 60;
                mainString = mins.format("%d") + ":" + secs.format("%02d");
            } else {
                mainString = "" + self._sets[self._nextSetNr];
            }
            dc.drawText(110,90, Graphics.FONT_NUMBER_THAI_HOT, mainString, Graphics.TEXT_JUSTIFY_CENTER);
        }

       	dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        var bottomString = "";
        if (self._inPause) {
            bottomString = "Pause";
        } else {
            bottomString = workoutData[self._workoutType]["prettyName"];
        }
        dc.drawText(110, 180, Graphics.FONT_LARGE, bottomString, Graphics.TEXT_JUSTIFY_CENTER);
    }

    // onHide() is called when this View is removed from the screen
    function onHide() {
    }
}
