args = "-c" & " -l " & """DISPLAY=localhost:0.0 LIBGL_ALWAYS_INDIRECT=1 terminator"""
WScript.CreateObject("Shell.Application").ShellExecute "bash", args, "", "open", 0