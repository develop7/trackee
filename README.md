Trackee is a tool which periodically grabs screenshots and stores them, easing users' activities tracking.

It was designed for background activities' collection with occasional reviews. Here's how:

1. Run `trackee` executable & forget about it
2. Proceed with your everyday activities
3. Review data it collected (only screenshots so far).
4. Mourn of the time wasted or rejoice otherwise.
5. Go to #2.

# Requirements

OS: Linux

## Runtime

GDK v3.x

## Build

[Stack](https://haskellstack.com), GTK v3.x development headers (or whatever got `gdk/gdk.h`).

# TODO

* Collect more data:
    * active window name
    * current task name from Hamster, IDEA, Toggl, Upwork Team, you name it
* Configuration options:
    * Data collection interval
    * Screenshots: 
        * Limit video outputs screen shots are grabbed from
        * Change screenshot format and/or quality where applicable
    * Configurable data directory
* Windows & Mac support
* Think through various approaches to storing collected data
