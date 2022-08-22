-- open a new iTerm2 window at a directory given by the argument
-- eg: osascript this-script.scpt /tmp/foo/bar

on run argv
	tell application "iTerm2"
	    set newWindow to (create window with default profile)
	    tell current session of newWindow
	        write text "cd " & item 1 of argv
	    end tell
	end tell
end run
