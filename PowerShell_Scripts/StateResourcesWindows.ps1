# Obtiene la información del sistema
$cpuUsage = Get-Counter '\Processor(_Total)\% Processor Time'
$ram = Get-WmiObject Win32_OperatingSystem
$disk = Get-WmiObject Win32_LogicalDisk -Filter "DriveType=3"
 
# Calcula los porcentajes de memoria
$totalMemoryMB = [math]::Round($ram.TotalVisibleMemorySize / 1MB, 2)
$freeMemoryMB = [math]::Round($ram.FreePhysicalMemory / 1MB, 2)
$usedMemoryMB = $totalMemoryMB - $freeMemoryMB
$usedMemoryPercent = [math]::Round(($usedMemoryMB / $totalMemoryMB) * 100, 2)
$freeMemoryPercent = 100 - $usedMemoryPercent
 
# Prepara el contenido HTML
$html = @"
<html>
<head>
    <title>Estado del Sistema</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h1>Estado del Sistema</h1>
    <table>
        <tr>
            <th>Recurso</th>
            <th>Detalle</th>
        </tr>
        <tr>
            <td>Uso de CPU</td>
            <td>$([math]::Round($cpuUsage.CounterSamples.CookedValue, 2)) %</td>
        </tr>
        <tr>
            <td>Memoria Total (MB)</td>
            <td>$totalMemoryMB MB</td>
        </tr>
        <tr>
            <td>Memoria Disponible (MB)</td>
            <td>$freeMemoryMB MB ($freeMemoryPercent %)</td>
        </tr>
        <tr>
            <td>Memoria Usada (MB)</td>
            <td>$usedMemoryMB MB ($usedMemoryPercent %)</td>
        </tr>
        <tr>
            <td>Espacio en Disco</td>
            <td>
                <table>
                    <tr>
                        <th>Unidad</th>
                        <th>Espacio Total (GB)</th>
                        <th>Espacio Libre (GB)</th>
                    </tr>
"@
 
foreach ($drive in $disk) {
    $html += "<tr><td>$($drive.DeviceID)</td><td>$([math]::Round($drive.Size / 1GB, 2))</td><td>$([math]::Round($drive.FreeSpace / 1GB, 2))</td></tr>"
}
 
$html += @"
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
"@
 
# Guarda el archivo HTML
$outputFile = ".\PowerShell_Scripts\WindowsStateResources.html"
$html | Out-File -FilePath $outputFile -Encoding utf8
 
Write-Output "El informe del estado del sistema ha sido guardado en $outputFile"