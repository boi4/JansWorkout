import Toybox.WatchUi;
import Toybox.System;


class MyMenu2InputDelegate extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        System.println(item.getId());
    }
}

class WorkoutChooserDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
        System.println("Initializing workoutchooserdelegate");
    }

    function pushMenu() {
        var menu = new WatchUi.Menu2({:title=>"My Menu2"});
        var delegate;

        // Add a new MenuItem to the Menu2 object
        menu.addItem(
            new WatchUi.MenuItem(

                // Set the 'Label' parameter
                "Item 1 Label",

                // Set the `subLabel` parameter
                "Item 1 subLabel",

                // Set the `identifier` parameter
                "itemOneId",
                // Set the options, in this case `null`
                {}
            )
        );

        menu.addItem(
            new WatchUi.MenuItem(
                "Item 2 Label",
                "Item 2 subLabel",
                "itemTwoId",
                {}
            )
        );

        // Create a new Menu2InputDelegate
        delegate = new MyMenu2InputDelegate(); // a WatchUi.Menu2InputDelegate

        // Push the Menu2 View set up in the initializer
        //WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        System.println("pushing new view");
        WatchUi.pushView(menu, delegate, WatchUi.SLIDE_IMMEDIATE);
    }

    function onMenu() as Boolean{
        System.println("onMenu event");
        return true;
    }

    function onPreviousPage() {
        System.println("onPreviouspage event");
        pushMenu();
        return true;
    }

    function onNextPage() {
        System.println("Next Page event");
        return true;
    }

    function onSelect() {
        System.println("onSelect event");
        return true;
    }


    function onBack() {
        System.println("onback event");
        return true;
    }
}

class MyInputDelegate extends WatchUi.InputDelegate {

    function initialize() {
        InputDelegate.initialize();
    }

    function onKey(keyEvent) {
        System.println(keyEvent.getKey());         // e.g. KEY_MENU = 7
        return true;
    }

    function onKeyPressed(keyEvent) {
        System.println(keyEvent.getKey());         // e.g. KEY_MENU = 7
        return true;
    }

    function onTap(clickEvent) {
        System.println(clickEvent.getType());      // e.g. CLICK_TYPE_TAP = 0
        return true;
    }

    function onHold(clickEvent) {
        System.println(clickEvent.getType());      // e.g. CLICK_TYPE_TAP = 0
        return true;
    }

    function onRelease(clickEvent) {
        System.println(clickEvent.getType());      // e.g. CLICK_TYPE_TAP = 0
        return true;
    }

    function onSwipe(swipeEvent) {
        System.println(swipeEvent.getDirection()); // e.g. SWIPE_DOWN = 2
        return true;
    }
}
