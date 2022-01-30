# Microk8s

To setup Microk8s on the local machine, use the Makefile. To see a list of commands as an on-screen menu, simply type `make`.

</br>

## Folder struture

```
microk8s
|- dags
|- functions
|- helm
|- integrations
|- k8s
|- scripts
```

Note: for non-Microk8s-specific integrations such as general database connectors (e.g. MongoDB, Cassandra), application programming interfaces (e.g. Flask API classes), or Extract Transform Load code see the integrations folder in the root Engineering directory of this repository.

</br>

### DAGs - Directed Acyclic Graphs

Example DAGs to run in Airflow for various demonstrations, such as using the Kubernetes Pod Executor.

</br>

### Functions

These are common functions that are used in the scripts and may also be wrappers around default toolkit functions for ease of use and porting of values.

</br>

### Helm

These are custom Helm charts to run in Microk8s.

</br>

### Integrations

These are specific to Microk8s, for non-Microk8s integrations (general integrations) see the integrations folder in the base engineering folder.

</br>

### K8s - Kubernetes

Used for setting up core Microk8s functions that simply cannot be done through the `enable` command.

</br>

### Scripts

Typically will be for deploying applications into Microk8s. These scripts will call functions where required to pull through specific credential information for provisioning the infrastructure.

</br>
