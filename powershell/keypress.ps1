do
{
    # wait for a key to be available:
    if ([Console]::KeyAvailable)
    {
        # read the key, and consume it so it won't
        # be echoed to the console:
        $keyInfo = [Console]::ReadKey($true)

        write-host
        $keyInfo
        write-host
    }

    # write a dot and wait a second
    Write-Host '.' -NoNewline
    Start-Sleep -Seconds 1

} while ($true)
