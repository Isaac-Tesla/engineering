# Engineering

This repo is a catch-all for code examples. It is organised in the following way:

```Engineering    
|- full_stack 
|- infrastructure    
 \=     
  |- aws    
  |- azure      
  |- docker_compose     
  |- gcp        
  |- microk8s       
|- init
|- integrations
 \=
  |- api
  |- db
  |- etl
|- interfaces
|- machine_learning
|- statistics   
```

</br> 

## Full Stack

Consists of full stack infrastructure, e.g. a Javascript front-end with a MongoDB backend including the code to start the database.

</br>

## Infrastructure

The infrastructure folder consists of deployments using primarily Bash scripts invoking Terraform scripts across the three main cloud providers. There is also a Docker-compose folder which consists of software deployments in this framework as well as a Microk8s folder for Linux deployments on a local Kubernetes setup for testing purposes.

</br> 

## Init

The initialisation scripts are to be used for installing and setting up the main components for use. For example, if using AWS with Helm and Terraform use the commands;

```
make init_aws
make init_helm
make init_terraform
```

</br> 

## Integrations

These include APIs, ETL code and database connectivity in the modules folder.

</br> 

## Interfaces

Designs for interfaces to connect through to databases showing dashboards.

</br>

## Machine Learning

Various machine learning models demonstrating understanding and application of core concepts, such as ensembles, AUC and dimensionality reduction.

</br> 

## Statistics

These are manually worked answers to statistical problems of a specified nature. Each has been written in Markdown for ease of display.
