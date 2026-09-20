$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:8080/")
$listener.Start()
Write-Host "Listening on http://localhost:8080/"

try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $response = $context.Response
        $response.ContentType = "text/html"
        
        # Read the file
        $buffer = [System.IO.File]::ReadAllBytes("index.html")
        $response.ContentLength64 = $buffer.Length
        $response.OutputStream.Write($buffer, 0, $buffer.Length)
        $response.OutputStream.Close()
    }
}
finally {
    $listener.Stop()
}
