# Connect to GlazeWM IPC
$pipe = New-Object System.IO.Pipes.NamedPipeClientStream(".", "glazewm", [System.IO.Pipes.PipeDirection]::InOut)
$pipe.Connect()

$writer = New-Object System.IO.StreamWriter($pipe)
$writer.AutoFlush = $true
$reader = New-Object System.IO.StreamReader($pipe)

# Subscribe to window manage events
$writer.WriteLine('{"type":"subscribe","events":["window_managed"]}')

$horizontal = $true

while ($true) {
    $line = $reader.ReadLine()
    if (!$line) { continue }

    $msg = $line | ConvertFrom-Json

    if ($msg.messageType -eq "event_subscription" -and $msg.data.eventType -eq "window_managed") {
        if ($horizontal) {
            $writer.WriteLine('{"type":"invoke_command","command":"set-tiling-direction horizontal"}')
        } else {
            $writer.WriteLine('{"type":"invoke_command","command":"set-tiling-direction vertical"}')
        }
        $horizontal = !$horizontal
    }
}
