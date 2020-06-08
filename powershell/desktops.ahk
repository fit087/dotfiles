;https://superuser.com/questions/950452/how-to-quickly-move-current-window-to-another-task-view-desktop-in-windows-10
;Use Ctrl+Win+Shift+Left|Right arrow
#^+Left::
WinGetTitle, Title, A
WinSet, ExStyle, ^0x80, %Title%
Send {LWin down}{Ctrl down}{Left}{Ctrl up}{LWin up}
sleep, 50
WinSet, ExStyle, ^0x80, %Title%
WinActivate, %Title%
Return

#^+Right::
WinGetTitle, Title, A
WinSet, ExStyle, ^0x80, %Title%
Send {LWin down}{Ctrl down}{Right}{Ctrl up}{LWin up}
sleep, 50
WinSet, ExStyle, ^0x80, %Title%
WinActivate, %Title%
Return
