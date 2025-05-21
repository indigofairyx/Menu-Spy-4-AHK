# Menu Spy 4 AHK


### A faster way of copying simple values that you would get from window spy.

Holding down the Hotkey `F4` for .15 secs will get the info of the window **UNDER THE MOUSE** (active or not)
and then displays this menu with the info dynamically in place.

![screenshot](https://i.imgur.com/rcpOQnU.png)

Click or tap menu # to place the displayed values on your clipboard, e.g....

> 1 ahk_exe notepad++.exe
>
> 2 ahk_class Notepad++w
>
> 3 *C:\Users\\<UserProfile>\Documents\AutoHotkey\menu spy.ahk - Notepad++
>
> 4 Win Get Text & All Details *This item uses WinGetText to copy all available text, (if any), with all other details from this menu in the heading. Use with caution, in some editors, such as np++, it will copy an entire document if that control is under the mouse.*
>
> 5 Scintilla3
>
> 6 x1753, y1100  ;; CoordMode, Mouse, Window  **!! IMPORTANT !!** *If your using this item for accurate X,Y Positions..., the window your using it on SHOULD BE ACTIVE! Background windows will produce broken coordinates as they are in relation to the active window.*
>
> 7 C:\Program Files\Notepad++\notepad++.exe
> 
> 8 *will open the .exe's dir path in [Directory Opus](https://www.gpsoft.com.au) or windows file explorer*
>
> 9 *will run AHKs proper Window Spy*
>
> also Close menu, Reload, Run as Admin and Exit script options

# Source Info:

Release Date: v.2025.01.08

Last Updated: v.2025.05.20

Written with AHK v1, Tested OS: Win10

forum post: https://www.autohotkey.com/boards/viewtopic.php?f=6&t=135218


# To Use Download this repo and run the `Menu Spy.ahk` with [AutoHotkey v1](https://www.autohotkey.com)


***

### v.2025.01.30 Update

For the fun of it I've added a sub-menu thats populated with the list of A_AHK built in Variable that I quickly copied from the AHK Docs page.

![ahk var menu](https://i.imgur.com/PkoLgvz.png)

### v.2025.05.20 Update

Turn off all warnings and Turn on Menu, UseErrorLevel, for those pesky UWP that have that run through icon-less systems hosts which cause menu errors as this menu tries to populate icons from the exe that making a window.


