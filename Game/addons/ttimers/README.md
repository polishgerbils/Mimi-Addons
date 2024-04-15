# tTimers
Displays time remaining on buffs and debuffs you've cast, as well as the recast timers for your spells and abilities.

## Commands

**/tt**<br>
Opens configuration menu.  This allows you to change themes, alter behavior, etc.

**/tt reposition**<br>
Forces all timer panels visible with max allowed timers, and allows them to be dragged around using the blue handles.

**/tt lock**<br>
Ends reposition mode.

**/tt custom [required: Label] [required: Duration]**<br>
This creates a custom timer with the label and duration specified.  Duration can be specified in full or partial minutes, seconds, or hours by using suffixes s, m, or h.  Example usage:<br>
**/tt custom "PH Repop" 5.5m**<br>
**/tt custom "NM Window" 1h**<br>
**/tt custom "Reminder" 30s**<br>
If no suffix is used, the timer will use the number as seconds.

## Other
You can shift-click any timer to make it immediately disappear.  You can ctrl-click any timer to make it immediately disappear and block that ability/buff/debuff from generating new timers in the future.  A future update will allow unblocking through GUI, but currently unblocking must be done by unloading the addon, editing the config file, and reloading the addon.  So, try not to block anything you don't want to keep blocked.

## *Additions made by Andy: 

**/tt custom "Pod Ejection" 5m r** <br>
**/tt custom "Wings Phase" 300 r** <br>
**/tt custom "Tia Window" 60m r 13** <br>
**/tt custom "HNM Window" 10m 20d r** <br> 

**03/28/24 update:** Fixed bug where attempting to create a Timecode timer when the input minutes were less than the current minutes would sometimes fail to create the full timer. <br>


- Using the letter r after the duration creates a repeatable custom timer that will continue repeating after it reaches its duration. It also displays the number of loops achieved.
    - **/tt custom "Test" 2m r** <br>
    Starts a 2 minute repeatable timer with 0 loops recorded as complete.

- Putting a number in the arguments of a repeatable custom timer starts the timer with that # of loops completed already. 

    - **/tt custom "Test" 30s r 5** <br>
    Starts a 30 second repeatable timer with 5 loops recorded as complete.

- Using a number followed by the suffix 'd' with no spaces will start the initial timer with a delay added in seconds. The following loops will not have added time from the delay 

    - **/tt custom "HNM Window" 10m r 20d 3** <br>
    Starts a 10 minute repeatable timer with a 20 second delay added to only the initial loop and it would start with 3 loops recorded as complete.

- Using Timecode syntax HH:MM:SS followed by a 't' creates a countdown timer that will countdown to the input timecode and then loop to start the input timer.
    - **/tt custom "Behe Window" 10m 1 r 07:15:35t** <br>
    Creates a timer that compares the input timecode to your system clock time and counts down to the correct time. This initial timer would countdown to 7:15:35 AM and would then loop over to the 10 minute repeating timer starting with 1 loop completed.

- Fixed the normal and repeatable custom timers to actually work with no time suffix added (defaults to seconds).

    - **/tt custom "Test" 45 r "test tooltip"** <br>
    Starts a 45 second repeatable timer with 0 loops recorded as complete and a tooltip that says "test tooltip" when the timer is hovered over.

- Optional arguments after the mandatory first two (Label and Duration) can now be input in any order.

    - **/tt custom "Test Label" 300 "tooltip test words" 15d 7 r** <br>
    Starts a 300 second repeatable timer with a 15 second delay added to only the initial loop. It would start with 7 loops recorded as complete and it would include a tooltip when hovered over that says "tooltip test words".