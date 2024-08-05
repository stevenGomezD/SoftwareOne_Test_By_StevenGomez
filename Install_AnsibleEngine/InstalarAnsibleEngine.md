# Instalar Ansible Engine

## Descripción
Este documento detalla los pasos para instalar Ansible Engine en un servidor **Red-Hat 8.8**

## Comandos para instalación de Ansible

 - $ sudo yum install ansible

 Habilitar Ansible Engine Repositorio para RedHat 8
  - $ sudo subscription-manager repos --enable ansible-2.9-for-rhel-8-x86_64-rpms

**Nota:** Estos pasos son los descritos en la documentación oficial de Ansible [Installing Ansible](https://docs.ansible.com/ansible/2.9/installation_guide/intro_installation.html#installing-ansible-on-rhel-centos-or-fedora). Se puede validar los pasos en caso de que se tenga un sistema operativo diferente.