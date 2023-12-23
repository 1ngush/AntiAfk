ScriptActive := false
GameTitle := "SCPSL.exe"
Interval := 1 ; Значение по умолчанию в секундах

Gui, +Caption
Gui, Add, Text, vStatusText, Скрипт выключен
Gui, Add, Text,, Введите интервал (секунды):
Gui, Add, Edit, vInterval, %Interval%
Gui, Add, Button, Default, Применить
Gui, Show, w300 h130, SCPSL AntiAfk ; Центрируем окно

!1::
    ScriptActive := !ScriptActive
    if (ScriptActive) {
        SetTimer, PressRandomKey, % Interval * 1000 ; Умножаем на 1000 для перевода секунд в миллисекунды
        GuiControl,, StatusText, Скрипт включен
    }
    else {
        SetTimer, PressRandomKey, Off
        GuiControl,, StatusText, Скрипт выключен
    }
return

ButtonПрименить:
    GuiControlGet, Interval, , Interval
    SetTimer, PressRandomKey, Off
    if (ScriptActive)
        SetTimer, PressRandomKey, % Interval * 1000
return

RandomKey() {
    Random, rand, 1, 4
    if (rand = 1)
        return "a"
    else if (rand = 2)
        return "w"
    else if (rand = 3)
        return "s"
    else
        return "d"
}

PressRandomKey() {
    WinGet, active_id, ID, A
    WinGetClass, active_class, ahk_id %active_id%
    if (active_class = "UnityWndClass" and active_id != "") {
        key := RandomKey()
        Send, {%key%}
    }
    else {
        SetTimer, PressRandomKey, Off
    }
return
}
