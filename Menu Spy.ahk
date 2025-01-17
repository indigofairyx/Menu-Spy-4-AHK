#Requires AutoHotkey v1.1.+
about =
(
About: Menu Spy.ahk

A faster way of copying simple values that you would get from window spy.

Holding down the hotkey F4 for .15 secs will get the info of the window UNDER THE MOUSE ( active or not)
and then display this menu with the info dynamically in place.

Click or tap menu # to place the displayed values on your clipboard, e.g. 	

1 ahk_exe notepad++.exe
2 ahk_class Notepad++w
3 *C:\Users\%UserProfile%\Documents\AutoHotkey\menu spy.ahk - Notepad++

4 This item uses WinGetText to copy all available text, (if any), with all other details from this menu in the heading. Use with caution, in some editors, such as np++, it will copy an entire document if that control is under the mouse.

5 Scintilla3

6 x1753, y1100  ;; CoordMode, Mouse, Window  **!! IMPORTANT !!** If your using this item for accurate X,Y Positions..., the window your using it on SHOULD BE ACTIVE! Background windows will produce broken coordinates as they are in relation to the active window.

7 C:\Program Files\Notepad++\notepad++.exe
-------------------------
8 will open the .exe's dir path in Directory Opus or windows file explorer
9 will run AHKs proper window spy
-------------------------
also Close menu, Reload, Run as Admin and Exit script options

Source Info:
Release Date: v.2025.01.08
Last Updated: v.2025.01.16
AHK v1
OS: Win10
forum post: https://www.autohotkey.com/boards/viewtopic.php?f=6&t=135218
creator: https://github.com/indigofairyx/Menu-Spy-4-AHK
)

;; dark mode menu options
contextcolor() ;0=Default ;1=AllowDark ;2=ForceDark ;3=ForceLight ;4=Max
contextcolor(color:=2) ; change the number here from the list above if you want light mode
	{
    static uxtheme := DllCall("GetModuleHandle", "str", "uxtheme", "ptr")
    static SetPreferredAppMode := DllCall("GetProcAddress", "ptr", uxtheme, "ptr", 135, "ptr")
    static FlushMenuThemes := DllCall("GetProcAddress", "ptr", uxtheme, "ptr", 136, "ptr")
    DllCall(SetPreferredAppMode, "int", color)
    DllCall(FlushMenuThemes)
	}

SetWorkingDir %A_ScriptDir%
#SingleInstance, Force
#Persistent
#NoEnv
#InstallKeybdHook
#InstallMouseHook
menu, tray, add, ; line -------------------------
menu, tray, add, About, aboutbox
return

$F4:: ;; hold F4 to Open Menu Spy
WinGetTitle, winTitle, A
WinGetClass, winClass, A
    KeyWait F4, T0.15
    if ErrorLevel
		{
		gosub menuspy ; long press\hold
		menu, spy, show
		}
    else
    {
        KeyWait F4, D T0.15
        if ErrorLevel
            {
			sendinput, {F4} ; One Press
			}
        else
            { ; Double Press
			gosub donothing
			}
    }
    KeyWait F4
return

;; if you want a different hotkey you can comment out or delete the one above and put your own above this label

showmenuspy:
gosub menuspy
menu, spy, show
return

;--------------------------------------------------

menuspy:
MouseGetPos, , , id, control
WinGetClass, actwin, A
WinGetTitle, title, ahk_id %id%
WinGetClass, class, ahk_id %id%
WinGet, activeProcess, ProcessName, ahk_id %id%
winget, path, ProcessPath, ahk_id %id%
CoordMode, Mouse, Window
MouseGetPos,xw,yw
splitpath, path, filename, dir
menu, spy, add
menu, spy, deleteall
Menu, spy, add, < --- Menu Spy --- >     Click to Copy, showmenuspy ;;p=1
if FileExist("C:\Program Files\AutoHotkey\UX\inc\spy.ico")
	Menu, spy, icon, < --- Menu Spy --- >     Click to Copy, C:\Program Files\AutoHotkey\UX\inc\spy.ico,,24
else if Fileexist("C:\Program Files\AutoHotkey\AutoHotkey.exe")
	Menu, spy, icon, < --- Menu Spy --- >     Click to Copy, autohotkey.exe,,24
menu, spy, default, < --- Menu Spy --- >     Click to Copy,
menu, spy, add, ; line ------------------------- ;;p=2

menu, spy, add, 1 ahk_exe %activeProcess%, copyspy ;;p=3
if (path = "C:\Windows\System32\ApplicationFrameHost.exe")
	menu, spy, icon, 1 ahk_exe %activeProcess%, C:\Windows\System32\@WLOGO_48x48.png
else
	menu, spy, icon, 1 ahk_exe %activeProcess%, %path%
	
menu, spy, add, 2 ahk_class %class%, copyspy ;;p=4
if (path = "C:\Windows\System32\ApplicationFrameHost.exe")
	menu, spy, icon, 2 ahk_class %class%, C:\Windows\System32\@WLOGO_48x48.png
else
	menu, spy, icon, 2 ahk_class %class%, %path%
	
menu, spy, add, 3 WinTitle=  %title%, copyspy ;;p=5
if (path = "C:\Windows\System32\ApplicationFrameHost.exe")
	menu, spy, icon, 3 WinTitle=  %title%, C:\Windows\System32\@WLOGO_48x48.png
else
	menu, spy, icon, 3 WinTitle=  %title%, %path%
	
menu, spy, add, 4 Win Get Text && All Details, copyspy ;;p=6
menu, spy, icon, 4 Win Get Text && All Details, C:\Windows\System32\shell32.dll, 261 ; clipboard icon
menu, spy, add, 5 Control Under Mouse=  %control%, copyspy ;;p=7
menu, spy, icon, 5 Control Under Mouse=  %control%, C:\Windows\System32\accessibilitycpl.dll, 5 ; mouse icon
menu, spy, add, 6 MouseCoord to Active Window**=  x%xw%`, y%yw%, copyspy ;;p=8
; menu, spy, icon, 6 MousePos to Window=  x%xw%`, y%yw%, C:\xsysicons\Fluent Colored icons\powertoys icons\Mouse Crosshairs_192x192.ico
menu, spy, icon, 6 MouseCoord to Active Window**=  x%xw%`, y%yw%, C:\Windows\System32\shell32.dll, 160
menu, spy, add, 7 .exe Path=  %path%, copyspy ;;p=9
menu, spy, icon, 7 .exe Path=  %path%, C:\Windows\System32\shell32.dll, 5 ; folder icon
menu, spy, add, ; line ----------------------- ;;p=10
menu, spy, add, 8 Open...   %filename%   ...Path, menuspyrunner ;;p=11
if FileExist("C:\Program Files\GPSoftware\Directory Opus\dopus.exe")
menu, spy, icon, 8 Open...   %filename%   ...Path, C:\Program Files\GPSoftware\Directory Opus\dopus.exe,,24
else
menu, spy, icon, 8 Open...   %filename%   ...Path, explorer.exe,,24
menu, spy, add, 9 Run Window Spy, menuspyrunner ;;p=12
if FileExist("C:\Program Files\AutoHotkey\UX\inc\spy.ico")
	menu, spy, icon, 9 Run Window Spy, C:\Program Files\AutoHotkey\UX\inc\spy.ico
else if Fileexist("C:\Program Files\AutoHotkey\AutoHotkey.exe")
	menu, spy, icon, 9 Run Window Spy, autohotkey.exe,,24
menu, spy, add, ; line------------------------- ;;p=13
menu, spy, add, Close Menu, menuspyrunner ;;p=14
menu, spy, icon, Close Menu, C:\Windows\System32\imageres.dll, 162
menu, spy, add, Reload Script, menuspyrunner ;;p=15
menu, spy, icon, Reload Script, C:\Windows\System32\imageres.dll, 229
if !(a_isadmin)
	{
	menu, spy, add, Run as Admin, menuspyrunner ;;p=16
	menu, spy, icon, Run as Admin, C:\Windows\system32\imageres.dll, 2
	}
else
	{
	Menu, spy, add, Script is Running as ADMIN, menuspyrunner ;;p=16
	menu, spy, icon, Script is Running as ADMIN, C:\Windows\system32\imageres.dll, 102
	}

menu, spy, add, ; line ------------------------- ;; ;; p=17
menu, spy, add, Quit\Kill\Exit Menu Spy, menuspyrunner ;;p=18
menu, spy, icon, Quit\Kill\Exit Menu Spy, C:\Windows\System32\imageres.dll, 230
return

copyspy:
p:=A_ThisMenuItemPos
clipboard =
sleep 30
If (p=3)
	{
	clipboard = ahk_exe %activeProcess%
	}
Else If (p=4)
	{
	clipboard = ahk_class %class%
	}
Else If (p=5)
	{
	clipboard = %title%
	}
Else If (p=6)
{
DetectHiddenText, On
DetectHiddenWindows, On
Wingettext, text, ahk_id %id%
sleep 400
if (text = "")
	{
		text = Sorry no text was found in WinTitle... %title%
	}
clipboard = 
(
Unique ID: ahk_id %id%`r
WinTitle:  %title%`r
ahk_class %class%`r
ahk_exe %activeProcess%`r
Path:  %path%`r
Control Under Mouse:  %control%`r
Mosuse Position to Active Window:  x%xw%, y%yw%
Win Get Text:`r
--------------------------------------------------`r

%text%`r
)
tooltip, The text & details found in...`nWinTitle:  %title%`nahk_class %class%`n...was copied to your clipboard.
sleep 2500
tooltip
}
Else if (p=7)
	{
	clipboard = %control%
	}
Else if (p=8)
	{
	clipboard = x%xw%, y%yw%
	}
;; renumber
Else if (p=9)
	{
	clipboard = %path%
	}
return

menuspyrunner:
p:=A_ThisMenuItemPos
If (p=11)
	{
	if fileexist("C:\Program Files\GPSoftware\Directory Opus\dopusrt.exe")
		Run, "C:\Program Files\GPSoftware\Directory Opus\dopusrt.exe" /cmd Go "%path%" NEWTAB TOFRONT
	else
		Run explorer.exe /select`,"%path%"
	}
Else If (p=12)
	run C:\Program Files\AutoHotkey\WindowSpy.ahk
Else if (p=14)
	send {esc}
Else if (p=15)
	reload
Else If (p=16)
	goto runasadmin
Else if (p=18)
	exitapp
return

donothing:
return

aboutbox:
MsgBox %about%
return

runasadmin:
If !A_IsAdmin {
    Run *RunAs "%A_ScriptFullPath%" ; Relaunch script as admin
} else {
	MsgBox, 4420, Running As Admin, If you don't want this script running as Admin any longer you must Exit it completely and Re-Run it.`n`nWould you like to QUIT\EXIT now?`n`nYou have to Restart it Manually afterward.`n`nYES = KILL`nNO = Continue as Admin, 30
    IfMsgBox Yes
		exitapp
	IfMsgBox No
		return
	IfMsgBox timeout
		return
}
Return


