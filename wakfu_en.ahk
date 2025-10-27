#Requires AutoHotkey v2.0+
#SingleInstance force

; INSTRUCTIONS
; Prerequisite: Install AHK v2: https://www.autohotkey.com/v2/
; The ";" symbol comments (disables) a line in the script. If you want to modify/disable any shortcuts, 
; I recommend adding a semicolon at the beginning of the line, to keep track of modifications
; To customize shortcuts, check out: https://www.autohotkey.com/docs/v1/KeyList.htm
; Or to change modifiers like alt(!), control(^) or shift(+): https://www.autohotkey.com/docs/v1/Hotkeys.htm

wakfuSearchString := "WAKFU ahk_class SunAwtFrame ahk_exe java.exe"
#HotIf WinActive(wakfuSearchString)	; This macro only works when a Wakfu window is active. Add a ";" at the beginning of this line to make shortcuts available everywhere.
$XButton1::Toggle()		; Works like an alt+tab, but limited to the two Wakfu windows
$F4::Toggle()			; Works like an alt+tab, but limited to the two Wakfu windows
$XButton2::Autofollow()	; Your secondary account follows your main account via a chat command (use the in-game “Chat” shortcut with the command "/follow USERNAME")
$F6::Invite()			; Your main account invites your secondary account via a chat command (use the in-game “Chat” shortcut with the command "/invite USERNAME")
$F7::ReverseInstances()	; In case your secondary account is mistakenly treated as the main one

ids := WinGetList(wakfuSearchString)

UpdateInstances()
{
	global ids, wakfuSearchString
	if (ids.Length == 2 and WinExist("ahk_id" ids[1]) and WinExist("ahk_id" ids[2]))
	{
		return 1
	}
	ids := WinGetList(wakfuSearchString)
	if (ids.Length == 2 and WinExist("ahk_id" ids[1]) and WinExist("ahk_id" ids[2]))
	{
		return 1
	}
	return 0
}

Invite()
{
	global ids
	if (!UpdateInstances())
	{
		return
	}
	WinActivate ids[2]
	Send "{Numpad1}"
	WinActivate ids[1]
	return
}

Autofollow()
{
	global ids
	if (!UpdateInstances())
	{
		return
	}
	WinActivate ids[1]
	Send "{Numpad2}"
	WinActivate ids[2]
	return
}

ReverseInstances()
{
	global ids
	if (!UpdateInstances())
	{
		return
	}
	tmpInstance := ids[2]
	ids[2] := ids[1]
	ids[1] := tmpInstance
	return
}

Toggle()
{
	global ids
	if (!UpdateInstances())
	{
		return
	}
	if WinActive("ahk_id" ids[1])
	{
		WinActivate ids[2]
	}
	else
	{
		WinActivate ids[1]
	}
}