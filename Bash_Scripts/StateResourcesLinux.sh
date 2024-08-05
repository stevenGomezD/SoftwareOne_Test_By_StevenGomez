#!/bin/bash
 
# Archivo de salida
output_file="LinuxStateResources.html"
 
# Obtener uso de CPU
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
 
# Obtener memoria RAM
mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
mem_free=$(grep MemFree /proc/meminfo | awk '{print $2}')
mem_available=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
mem_used=$((mem_total - mem_free))
mem_total_mb=$((mem_total / 1024))
mem_used_mb=$((mem_used / 1024))
mem_free_mb=$((mem_free / 1024))
mem_available_mb=$((mem_available / 1024))
mem_used_pct=$(( (mem_used * 100) / mem_total ))
mem_free_pct=$(( (mem_free * 100) / mem_total ))
mem_available_pct=$(( (mem_available * 100) / mem_total ))
 
# Obtener espacio de disco
disk_total=$(df -h / | grep / | awk '{print $2}')
disk_used=$(df -h / | grep / | awk '{print $3}')
disk_free=$(df -h / | grep / | awk '{print $4}')
 
# Crear archivo HTML
cat <<EOF > $output_file
<!DOCTYPE html>
<html>
<head>
    <title>Estado de Recursos</title>
</head>
<body>
    <h1>Estado de Recursos del Sistema</h1>
    <h2>Uso de CPU</h2>
    <p>Uso de CPU: ${cpu_usage}%</p>
    
    <h2>Memoria RAM</h2>
    <p>Total: ${mem_total_mb} MB</p>
    <p>Usada: ${mem_used_mb} MB (${mem_used_pct}%)</p>
    <p>Disponible: ${mem_free_mb} MB (${mem_free_pct}%)</p>
    <p>Memoria disponible: ${mem_available_mb} MB (${mem_available_pct}%)</p>
    
    <h2>Espacio en Disco</h2>
    <p>Total: ${disk_total}</p>
    <p>Usado: ${disk_used}</p>
    <p>Libre: ${disk_free}</p>
</body>
</html>
EOF
 
echo "Estado de recursos guardado en $output_file"