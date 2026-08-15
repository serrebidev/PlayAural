# Points the PlayAural desktop client at the Serrebi Radio Palace server.
#
# The packaged client has no server picker: client/ui/login_dialog.py always
# uses the server entry with id "official_server", and only creates it with the
# upstream default when no entry already exists. Writing that entry here is
# therefore the supported way to change servers without rebuilding the app.
#
# This lives in %APPDATA%, not in the program folder, so it survives every
# future in-app update.

$ErrorActionPreference = "Stop"

$serverName = "Serrebi Radio Palace"
$serverHost = "wss://palace.serrebiradio.com"   # $host is reserved in PowerShell
$serverPort = "443"

$configDir  = Join-Path $env:APPDATA "ddt.one\PlayAural"
$configFile = Join-Path $configDir "identities.json"

try {
    New-Item -ItemType Directory -Force -Path $configDir | Out-Null

    if (Test-Path $configFile) {
        $data = Get-Content -Raw -Path $configFile | ConvertFrom-Json
    } else {
        $data = [PSCustomObject]@{
            last_server_id = "official_server"
            servers        = [PSCustomObject]@{}
        }
    }

    if (-not $data.PSObject.Properties.Match("servers").Count) {
        $data | Add-Member -NotePropertyName servers -NotePropertyValue ([PSCustomObject]@{}) -Force
    }

    $existing = $data.servers.PSObject.Properties.Match("official_server")
    if ($existing.Count) {
        # Keep any saved accounts; only repoint the address.
        $data.servers.official_server.name = $serverName
        $data.servers.official_server.host = $serverHost
        $data.servers.official_server.port = $serverPort
    } else {
        $entry = [PSCustomObject]@{
            server_id = "official_server"
            name      = $serverName
            host      = $serverHost
            port      = $serverPort
            notes     = "Public PlayAural server at palace.serrebiradio.com"
            accounts  = [PSCustomObject]@{}
        }
        $data.servers | Add-Member -NotePropertyName official_server -NotePropertyValue $entry -Force
    }

    $data.last_server_id = "official_server"

    # Write UTF-8 WITHOUT a BOM. Windows PowerShell's -Encoding UTF8 adds one,
    # and Python's json.load then fails; the client swallows that error and
    # silently falls back to its defaults, undoing this whole script.
    $json = $data | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($configFile, $json, (New-Object System.Text.UTF8Encoding($false)))

    Write-Output "PlayAural is now set to connect to $serverName ($serverHost)."
}
catch {
    Write-Output "Could not update the PlayAural server setting: $($_.Exception.Message)"
    Write-Output "The app will still start, but it may connect to the default server."
}
