#SingleInstance Force
#Requires AutoHotkey v2.0


myGui := Gui("+AlwaysOnTop -Caption +Border", "FirefoxSearch")
myGui.BackColor := "282828"        ; gruvbox dark bg
myGui.SetFont("s12 cebdbb2", "JetBrainsMono NF")

search := myGui.AddEdit("x4 y4 w380 h20 -E0x200 Background282828 cebdbb2", "")
search.SetFont("s12 cebdbb2", "JetBrainsMono NF")

SendMessage(0x1501, 1, StrPtr("web search..."), search)
search.Focus()

myGui.Show("xCenter y40 w400 h30")

search.OnEvent("Change", (*) => "")

myGui.OnEvent("Escape", (*) => myGui.Destroy())

RunSearch(query) {
	window_state := A_Args[1]
	if (RegExMatch(query, "^https?://") || RegExMatch(query, "^[\w-]+\.[\w-]+")) {
		; looks like a URL
		;Run('firefox.exe -new-window "' . query . '"')
		Run('firefox.exe ' . window_state . ' "' . query . '"')
	} else {
		; treat as search
		;Run('firefox.exe -new-window "https://www.google.com/search?q=' . UriEncode(query) . '"')
		Run('firefox.exe ' . window_state . ' "https://www.google.com/search?q=' . UriEncode(query) . '"')
	}
	if (query != "") {
		FileAppend(FormatTime(, "yyyy-MM-dd HH:mm") . " - " . query . "`n", "history.txt")
	}
}

OnMessage(0x0100, KeyHandler)

KeyHandler(wParam, lParam, msg, hwnd) {
    if (wParam = 13) { ; Enter key
        query := search.Value
		  RunSearch(query)
        myGui.Destroy()
    }
}

UriEncode(str) {
    chars := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.~"
    result := ""
    Loop Parse, str
    {
        if InStr(chars, A_LoopField)
            result .= A_LoopField
        else
            result .= "%" . Format("{:02X}", Ord(A_LoopField))
    }
    return result
}
