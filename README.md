## Descripción
Este documento explica los archivos contenidos en este repositorio, como ejecutar cada componente y realizar cada tarea.

## 1. Instalación de Ansible Engine
Para esta instalación dirijase al archivo markdown *Install_AnsibleEngine/InstalarAnsibleEngine.md* y siga los pasos descritos.

## 2. Despliegue de IaC en AWS
Para el despliegue de los servidores en la nube siga los siguientes pasos

### 1. Instalar Terraform
### 2. Inicializar Terraform:
 $ terraform init
### 3. Validar configuración
 $ terraform validate
### 4. Verificar despliegue antes de hacer cambios
 $ terraform plan
### 5. Aplicar despliegue
 $ terraform apply

## 3. Script en Python para consultar una API y mostrar resultados en HTML
**Ruta Script:** Python_Scripts/QueryAPI.py

**Descripción script:** El script recibe como parámetro un Id, el cual es un número de tipo entero, y retorna una petición GET a una API pública de Dragon Ball, la respuesta de la información la almacena en un archivo JSON y después se toma la información de este archivo para convertir la respuesta en HTML.

**Como ejecutar el script:** Desde la terminal ejecute:
 - python .\Python_Scripts\QueryAPI.py <<Id>Id>


## 4. Script en PowerShell para validar el estado de recursos en la máquina Windows

**Ruta Script:** PowerShell_Scripts/StateResourcesWindows.ps1

**Descripción script:** El script devuelve el Uso de CPU, Memoria RAM Total, Memoria Disponible, Memoria Usada y Espacio en Disco de un servidor Windows al momento de ejecución del script. Toda la información es guardada en un archivo HTML

**Como ejecutar el script:** Desde la terminal ejecute:
 - powershell .\PowerShell_Scripts\StateResourcesWindows.ps1

## 5. Script en Bash para validar el estado de recursos en las máquinas Linux

**Ruta Script:** Bash_Scripts/StateResourcesWindows.ps1

**Descripción script:** El script devuelve el Uso de CPU, Memoria RAM Total, Memoria Disponible, Memoria Usada y Espacio en Disco de un servidor Linux al momento de ejecución del script. Toda la información es guardada en un archivo HTML

**Como ejecutar el script:** Desde la terminal ejecute:
 - chmod +x Bash_Scripts/StateResourcesLinux.sh
 - ./Bash_Scripts/StateResourcesLinux.sh

## 6. Playbook de Ansible para instalar SQL y crear una base de datos en Windows

**Ruta Playbook:** Ansible_Playbooks/InstallApache.yml
**Ruta Vault:** Ansible_Playbooks/vault_vars_sql.yml

**Descripción Playbook:** Realiza las siguientes tareas:
 - **Instalar Chocolatey:** Instala el gestor de paquetes de Windows
 - **Mostrar estado de la instalación de Chocolatey:** Realiza un debug de la anterior tarea
 - **Instalar SQL Server usando Chocolatey:** usa el modulo *win_chocolatey* para instalar sql-server version 2022 
 - **Mostrar estado de la instalación de SQL Server:** Debug de la anterior tarea
 - **Crear una instancia de base de datos SQL:** Usa el modulo *win_shell* para crear una instancia de base de datos SQL
 - **Mostrar estado de la creación de la base de datos:** Debug de la anterior tarea

**Configuración Hosts:** En el servidor que tenga Ansible Engine instalado vaya al archivo /etc/ansible/hosts y verifique que exista un grupo de hosts llamado *windows_server* y tenga agregado sus respectiva IP

**Configurar archivo contraseña Vault Vars:** En el servidor que tenga Ansible Engine instalado cree un archivo llamado ~/.vault_pass.txt para almacenar la contraseña. Modifique permisos con el comando '$ chmod 600 ~/.vault_pass.txt' para que solo el propietario pueda leer y escribir en el archivo.

**Como ejecutar el playbook:** Desde la terminal del servidor que tiene Ansible Engine instalado, el archivo host correctamente configurado y el playbook. Ejecute los siguiente comandos
 - ansible-vault create Ansible_Playbooks/vault_vars_sql.yml 
 - ansible-playbook Ansible_Playbooks/InstallSQL.yml --vault-password-file ~/.vault_pass.txt

## 7. Playbook de Ansible para instalar y configurar un servidor web Apache en las máquinas Linux

**Ruta Playbook:** Ansible_Playbooks/InstallApache.yml

**Descripción Playbook:** Realiza las siguientes tareas:
 - **Instalar Apache:** usa el modulo *yum* para instalar Apache
 - **Asegurarse de que el servicio Apache esté en funcionamiento:** inicia el servicio httpd
 - **Crear una página web simple:** modifica con html simple el archivo /var/www/html/index.html
 - **Reiniciar Apache para aplicar cambios:** reinicia el servicio httpd
 - **Comprobar que el servicio Apache esté corriendo:** hace una comprobación a través de shell que el servicio httpd este activo y guarda un registro de la tarea
 - **Mostrar el estado del servicio Apache:** hace un debug de la anterior tarea para ver su estado

**Configuración Hosts:** En el servidor que tenga Ansible Engine instalado vaya al archivo /etc/ansible/hosts y verifique que exista un grupo de hosts llamado *redhat_server* y tenga agregado sus respectivas IPs

**Como ejecutar el playbook:** Desde la terminal del servidor que tiene Ansible Engine instalado, el archivo host correctamente configurado y el playbook. Ejecute el siguiente comando
 - ansible-playbook Ansible_Playbooks/InstallApache.yml