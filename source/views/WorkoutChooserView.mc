//using Toybox.Graphics;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.System;

class WorkoutChooserView extends WatchUi.View
{
    function initialize() as Void
    {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void
    {
    }

    // Called when this View is brought to the foreground.
    // Restore the state of this View and prepare it to be shown.
    // This includes loading resources into memory.
    function onShow() as Void
    {}

    // Update the view
    function onUpdate(dc as Dc) as Void
    {
        View.onUpdate(dc);
        System.println("Updating view");
    }

    // Called when this View is removed from the screen. 
    // Save the state of this View here. This includes 
    // freeing resources from memory.
    function onHide() as Void
    {}

    //// The user has just looked at their watch. 
    //// Timers and animations may be started here.
    //function onExitSleep() as Void
    //{}

    //// Terminate any active timers and prepare for slow updates.
    //function onEnterSleep() as Void
    //{}
}
