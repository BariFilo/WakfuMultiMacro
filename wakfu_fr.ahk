#Requires AutoHotkey v2.0+
#SingleInstance force

; INSTRUCTIONS
; Prérequis: Installer AHK v2: https://www.autohotkey.com/v2/
; Le symbole ";" commente (désactive) la ligne du script, si vous voulez modifier/désactiver certains raccourcis,
; Je vous recommande alors d'ajouter un point-virgule devant, pour garder une trace des modifications
; Pour personnaliser les raccourcis, consultez: https://www.autohotkey.com/docs/v1/KeyList.htm
; Ou pour les modifers tel que alt(!), control(^) ou majuscule(+): https://www.autohotkey.com/docs/v1/Hotkeys.htm

wakfuSearchString := "WAKFU ahk_class SunAwtFrame ahk_exe java.exe"
#HotIf WinActive(wakfuSearchString)	; Cette macro fonctionne uniquement lorsqu'une fenetre Wakfu est activé, ajouter un ";" au début de cette ligne pour rendre les raccourcis accessible depuis n'importe où
$XButton1::Toggle()		; Equivalent à un alt+tab, limité aux 2 fenetres Wakfu
$F4::Toggle()			; Equivalent à un alt+tab, limité aux 2 fenetres Wakfu
$XButton2::Autofollow()	; Votre compte secondaire suit votre compte principal via une commande chat (utiliser le raccourcis "Chat" en jeu avec la commande "/follow PSEUDO")
$F6::Invite()			; Votre compte principal invite votre compte secondaire via une commande chat (utiliser le raccourcis "Chat" en jeu avec la commande "/invite PSEUDO")
$F7::ReverseInstances()	; Dans le cas ou votre compte secondaire est considéré comme principal

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