#!/bin/sh
#
osascript << END
tell application "Terminal"
  activate
	if (count of windows) is 0 then
		do script "$CMD"
	else
		set window_id to id of first window whose frontmost is true
    tell application "System Events"
      keystroke "t" using {command down}
    end
    do script "$CMD" in window id window_id of application "Terminal"
	end if
	set t to selected tab of front window
  set custom title of t to "$SHELL_NAME"
end tell
END
