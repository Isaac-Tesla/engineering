#!/bin/bash


function uninstall_microk8s () {

   # Stop it
   microk8s stop

   # Uninstall it
   sudo snap uninstall microk8s

}
