#Requires AutoHotkey v1.1.+
about =
(
About: Menu Spy.ahk

A faster way of copying simple values that you would get from window spy.

Holding down the hotkey F4 for .15 secs will get the info of the window UNDER THE MOUSE ( active or not)
and then displays this menu with the info dynamically in place.

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
-------------------------
Made and added a sub menu populated with AHKs Built in Variables.

Source Info:
Release Date: v.2025.01.08
Last Updated: v.2025.05.20
AHK v1
OS: Win10
forum post: https://www.autohotkey.com/boards/viewtopic.php?f=6&t=135218
creator: https://github.com/indigofairyx
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
menu, Tray, UseErrorLevel, On
#warn, all, off
return

$F4:: ;; hold F4 to Open Menu Spy
WinGetTitle, winTitle, A
WinGetClass, winClass, A
    KeyWait F4, T0.15
    if ErrorLevel
		{
		gosub menuspy ; long press\hold
		; gosub varmenu
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
menu, spy, UseErrorLevel, On

gosub varmenu
MouseGetPos, , , id, control
WinGetClass, actwin, A
WinGetTitle, title, ahk_id %id%
WinGetClass, class, ahk_id %id%
WinGet, activeProcess, ProcessName, ahk_id %id%
winget, AppPath, ProcessPath, ahk_id %id%
CoordMode, Mouse, Window
MouseGetPos,xw,yw
splitpath, AppPath, filename, dir
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
	menu, spy, icon, 1 ahk_exe %activeProcess%, %AppPath%
	
menu, spy, add, 2 ahk_class %class%, copyspy ;;p=4
if (path = "C:\Windows\System32\ApplicationFrameHost.exe")
	menu, spy, icon, 2 ahk_class %class%, C:\Windows\System32\@WLOGO_48x48.png
else
	menu, spy, icon, 2 ahk_class %class%, %AppPath%
	
menu, spy, add, 3 WinTitle=  %title%, copyspy ;;p=5
if (path = "C:\Windows\System32\ApplicationFrameHost.exe")
	menu, spy, icon, 3 WinTitle=  %title%, C:\Windows\System32\@WLOGO_48x48.png
else
	menu, spy, icon, 3 WinTitle=  %title%, %AppPath%
	
menu, spy, add, 4 Win Get Text && All Details, copyspy ;;p=6
menu, spy, icon, 4 Win Get Text && All Details, C:\Windows\System32\shell32.dll, 261 ; clipboard icon
menu, spy, add, 5 Control Under Mouse=  %control%, copyspy ;;p=7
menu, spy, icon, 5 Control Under Mouse=  %control%, C:\Windows\System32\accessibilitycpl.dll, 5 ; mouse icon
menu, spy, add, 6 MouseCoord to Active Window**=  x%xw%`, y%yw%, copyspy ;;p=8
; menu, spy, icon, 6 MousePos to Window=  x%xw%`, y%yw%, X:\xSysIcons\Fluent Colored icons\powertoys icons\Mouse Crosshairs_192x192.ico
menu, spy, icon, 6 MouseCoord to Active Window**=  x%xw%`, y%yw%, C:\Windows\System32\shell32.dll, 160
menu, spy, add, 7 .exe Path=  %AppPath%, copyspy ;;p=9
menu, spy, icon, 7 .exe Path=  %AppPath%, C:\Windows\System32\shell32.dll, 5 ; folder icon
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
menu, spy, add, AHKs Built In `%A_Var`% Menu, :var ;; p=18
menu, spy, icon, AHKs Built In `%A_Var`% Menu, %A_AHKPath%
menu, spy, add, ; line ------------------------- ;; ;; p=19
menu, spy, add, Quit\Kill\Exit Menu Spy, exit ;; p=20
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
Path:  %AppPath%`r
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
	clipboard = %AppPath%
	}
return

menuspyrunner:
p:=A_ThisMenuItemPos
If (p=11)
	{
	if fileexist("C:\Program Files\GPSoftware\Directory Opus\dopusrt.exe")
		Run, "C:\Program Files\GPSoftware\Directory Opus\dopusrt.exe" /cmd Go "%AppPath%" NEWTAB TOFRONT
	else
		Run explorer.exe /select`,"%AppPath%"
	}
Else If (p=12)
	run C:\Program Files\AutoHotkey\WindowSpy.ahk
Else if (p=14)
	send {esc}
Else if (p=15)
	reload
Else If (p=16)
	goto runasadmin
return

exit:
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

varmenu:
menu, var, UseErrorLevel, On
menu, var, add
menu, var, deleteall
menu, var, add, A_AHKs BUILT IN `%VARIABLES`% MENU, varhandle
menu, var, icon, A_AHKs BUILT IN `%VARIABLES`% MENU, %A_AHKPath%
menu, var, Default, A_AHKs BUILT IN `%VARIABLES`% MENU
menu, var, add, ; line -------------------------

menu, var1, add, A_AhkPath:   %A_AhkPath%, varhandle
menu, var1, add, A_AhkVer:   %A_AhkVersion%, varhandle
menu, var1, add, A_Args:   %A_Args%, varhandle
menu, var1, add, A_ExitReason:   %A_ExitReason%, varhandle
; menu, var1, add, IntWorkindDir:   %A_InitialWorkingDir%, varhandle ; causes error
menu, var1, add, A_IsCompied:   %A_IsCompiled%, varhandle
menu, var1, add, A_IsUnicode:   %A_IsUnicode%, varhandle
menu, var1, add, A_Line#:   %A_LineNumber%, varhandle
menu, var1, add, A_LineFile:   %A_LineFile%, varhandle
menu, var1, add, A_ScriptDir:   %A_ScriptDir%, varhandle
menu, var1, add, A_ScriptFullPath:   %A_ScriptFullPath%, varhandle
menu, var1, add, A_ScriptHwnd:   %A_ScriptHwnd%, varhandle
menu, var1, add, A_ScriptName:   %A_ScriptName%, varhandle
menu, var1, add, A_ThisFucn:   %A_ThisFunc%, varhandle
menu, var1, add, A_ThisLabel:   %A_ThisLabel%, varhandle
menu, var1, add, A_Working Dir:   %A_WorkingDir%, varhandle
menu, var, add,  SCRIPT PROPERTIES, :var1
 
 menu, var, add, ; line -------------------------
menu, var2, add, A_YYYY:   %A_YYYY%, varhandle
menu, var2, add, A_MM:   %A_MM%, varhandle
menu, var2, add, A_DD:   %A_DD%, varhandle
menu, var2, add, A_MMMM:   %A_MMMM%, varhandle
menu, var2, add, A_MMM:   %A_MMM%, varhandle
menu, var2, add, A_DDDD:   %A_DDDD%, varhandle
menu, var2, add, A_DDD:   %A_DDD%, varhandle
menu, var2, add, A_WDay:   %A_WDay%, varhandle
menu, var2, add, A_YDay:   %A_YDay%, varhandle
menu, var2, add, A_YWeek:   %A_YWeek%, varhandle
menu, var2, add, A_Hour:   %A_Hour%, varhandle
menu, var2, add, A_Min:   %A_Min%, varhandle
menu, var2, add, A_Sec:   %A_Sec%, varhandle
menu, var2, add, A_MSec:   %A_MSec%, varhandle
menu, var2, add, A_Now:   %A_Now%, varhandle
menu, var2, add, A_NowUTC:   %A_NowUTC%, varhandle
menu, var2, add, A_TickCount:   %A_TickCount%, varhandle
menu, var, add, DATE && TIME, :var2
;  Date and Time%, varhandle
 menu, var, add, ; line -------------------------
menu, var3, add, A_AutoTrim:   %A_AutoTrim%, varhandle
menu, var3, add, A_BatchLines:   %A_BatchLines%, varhandle
menu, var3, add, A_ControlDelay:   %A_ControlDelay%, varhandle
menu, var3, add, A_CoordModePixel:   %A_CoordModePixel%, varhandle
menu, var3, add, A_CordModeCaret:   %A_CoordModeCaret%, varhandle
menu, var3, add, A_CordModeMenu:   %A_CoordModeMenu%, varhandle
menu, var3, add, A_CordModeMouse:   %A_CoordModeMouse%, varhandle
menu, var3, add, A_CordModeToolTip:   %A_CoordModeToolTip%, varhandle
menu, var3, add, A_DefaultMouseSpeed:   %A_DefaultMouseSpeed%, varhandle
menu, var3, add, A_DetectHiddenText:   %A_DetectHiddenText%, varhandle
menu, var3, add, A_DetectHiddenWindows:   %A_DetectHiddenWindows%, varhandle
menu, var3, add, A_FileEncoding:   %A_FileEncoding%, varhandle
menu, var3, add, A_FormatFloat:   %A_FormatFloat%, varhandle
menu, var3, add, A_FormatInteger:   %A_FormatInteger%, varhandle
menu, var3, add, A_IconFile:   %A_IconFile%, varhandle
menu, var3, add, A_IconHidden:   %A_IconHidden%, varhandle
menu, var3, add, A_IconNumber:   %A_IconNumber%, varhandle
menu, var3, add, A_IconTip:   %A_IconTip%, varhandle
menu, var3, add, A_IsCritical:   %A_IsCritical%, varhandle
menu, var3, add, A_IsPaused:   %A_IsPaused%, varhandle
menu, var3, add, A_IsSuspended:   %A_IsSuspended%, varhandle
menu, var3, add, A_KeyDelay:   %A_KeyDelay%, varhandle
menu, var3, add, A_KeyDelayPlay:   %A_KeyDelayPlay%, varhandle
menu, var3, add, A_KeyDuration:   %A_KeyDuration%, varhandle
menu, var3, add, A_KeyDurationPlay:   %A_KeyDurationPlay%, varhandle
menu, var3, add, A_ListLines:   %A_ListLines%, varhandle
menu, var3, add, A_MouseDelay:   %A_MouseDelay%, varhandle
menu, var3, add, A_MouseDelayPlay:   %A_MouseDelayPlay%, varhandle
menu, var3, add, A_RegView:   %A_RegView%, varhandle
menu, var3, add, A_SendLevel:   %A_SendLevel%, varhandle
menu, var3, add, A_SendMode:   %A_SendMode%, varhandle
menu, var3, add, A_StoreCapsLockMode:   %A_StoreCapsLockMode%, varhandle
menu, var3, add, A_StringCaseSense:   %A_StringCaseSense%, varhandle
menu, var3, add, A_TitleMatchMode:   %A_TitleMatchMode%, varhandle
menu, var3, add, A_TitleMatchModeSpeed:   %A_TitleMatchModeSpeed%, varhandle
menu, var3, add, A_WinDelay:   %A_WinDelay%, varhandle
menu, var, add, SCRIPT SETTINGS, :var3
menu, var, add, ; line -------------------------
 
menu, var4, add, A_TimeIdle:   %A_TimeIdle%, varhandle
menu, var4, add, A_TimeIdleKeyboard:   %A_TimeIdleKeyboard%, varhandle
menu, var4, add, A_TimeIdlePhysical:   %A_TimeIdlePhysical%, varhandle
menu, var4, add, A_TimeIdleMouse:   %A_TimeIdleMouse%, varhandle
menu, var, add, User Idle Time, :var4


 menu, var, add, ; line -------------------------
menu, var5, add, A_EndChar:   %A_EndChar%, varhandle
menu, var5, add, A_PriorHotkey:   %A_PriorHotkey%, varhandle
menu, var5, add, A_PriorKey:   %A_PriorKey%, varhandle
menu, var5, add, A_ThisHotkey:   %A_ThisHotkey%, varhandle
menu, var5, add, A_ThisMenu:   %A_ThisMenu%, varhandle
menu, var5, add, A_ThisMenuItem:   %A_ThisMenuItem%, varhandle
menu, var5, add, A_ThisMenuItemPos:   %A_ThisMenuItemPos%, varhandle
menu, var5, add, A_TimeSincePriorHotkey:   %A_TimeSincePriorHotkey%, varhandle
menu, var5, add, A_TimeSinceThisHotkey:   %A_TimeSinceThisHotkey%, varhandle
menu, var, add, Hotkeys`, Hotstrings`, and Custom Menu Items, :var5
menu, var, add, ; line -------------------------
 
menu, var6, add, A_AppData:   %A_AppData%, varhandle
menu, var6, add, A_AppDataCommon:   %A_AppDataCommon%, varhandle
menu, var6, add, A_ComputerName:   %A_ComputerName%, varhandle
menu, var6, add, A_ComSpec:   %A_ComSpec%, varhandle
menu, var6, add, A_Desktop:   %A_Desktop%, varhandle
menu, var6, add, A_DesktopCommon:   %A_DesktopCommon%, varhandle
menu, var6, add, A_Is64bitOS:   %A_Is64bitOS%, varhandle
menu, var6, add, A_IsAdmin:   %A_IsAdmin%, varhandle
menu, var6, add, A_Language:   %A_Language%, varhandle
menu, var6, add, A_MyDocuments:   %A_MyDocuments%, varhandle
menu, var6, add, A_OSType:   %A_OSType%, varhandle
menu, var6, add, A_OSVersion:   %A_OSVersion%, varhandle
menu, var6, add, A_ProgramCommon:   %A_ProgramsCommon%, varhandle
menu, var6, add, A_ProgramFiles:   %A_ProgramFiles%, varhandle
menu, var6, add, A_Programs:   %A_Programs%, varhandle
menu, var6, add, A_PtrSize:   %A_PtrSize%, varhandle
menu, var6, add, A_ScreenDPI:   %A_ScreenDPI%, varhandle ; causes error
menu, var6, add, A_ScreenHeight:   %A_ScreenHeight%, varhandle
menu, var6, add, A_ScreenWidth:   %A_ScreenWidth%, varhandle
menu, var6, add, A_StartMenu:   %A_StartMenu%, varhandle
menu, var6, add, A_StartMenuCommon:   %A_StartMenuCommon%, varhandle
menu, var6, add, A_StartUp:   %A_Startup%, varhandle
menu, var6, add, A_StartupCommon:   %A_StartupCommon%, varhandle
menu, var6, add, A_Temp:   %A_Temp%, varhandle
menu, var6, add, A_UserName:   %A_UserName%, varhandle
menu, var6, add, A_WinDir:   %A_WinDir%, varhandle
menu, var, add, Operating System and User Info, :var6
menu, var, add, ; line -------------------------
menu, var7, add, A_DefaultGui:   %A_DefaultGui%, varhandle
menu, var7, add, A_DefaultListView:   %A_DefaultListView%, varhandle
menu, var7, add, A_DefaultTreeView:   %A_DefaultTreeView%, varhandle
menu, var7, add, A_EventInfo:   %A_EventInfo%, varhandle
menu, var7, add, A_GUI:   %A_Gui%, varhandle
menu, var7, add, A_GuiControl:   %A_GuiControl%, varhandle
menu, var7, add, A_GuiEvent:   %A_GuiEvent%, varhandle
menu, var7, add, A_GuiHeight:   %A_GuiHeight%, varhandle
menu, var7, add, A_GuiWidth:   %A_GuiWidth%, varhandle
menu, var7, add, A_GuiX:   %A_GuiX%, varhandle
menu, var7, add, A_GuiY:   %A_GuiY%, varhandle
Menu, var, add, GUI Windows and Menu Bars, :var7
menu, var, add, ; line -------------------------
menu, var, add, Visit Built in Vars Doc Webpage, visitbuiltindocs
menu, var, icon, Visit Built in Vars Doc Webpage, C:\Windows\system32\netshell.dll, 86

return

varhandle:
; Retrieve the value of the clicked menu item
clickedValue := SubStr(A_ThisMenuItem, InStr(A_ThisMenuItem, ":") + 1)

; Check if the value is empty
if (Trim(clickedValue) = "") {
    Tooltip, There is nothing here to copy.
    Sleep 1500
    Tooltip
    Return
}

; Otherwise, copy the value to the clipboard
Clipboard := ""
Sleep 20
Clipboard := Trim(clickedValue)
Return

visitbuiltindocs:
run https://www.autohotkey.com/docs/v1/Variables.htm#BuiltIn
return

