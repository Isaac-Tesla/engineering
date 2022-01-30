# Google Cloud Platform

To setup GCP infrastructure, use the Makefile. To see a list of commands as an on-screen menu, simply type `make`.

</br>

## Folder struture

```
gcp 
|- functions
|- integrations    
 \=     
  |- database     
|- scripts
|- terraform
```

Note: for non-GCP-specific integrations such as database connectors (e.g. MongoDB, Cassandra), application programming interfaces (e.g. Flask API classes), or Extract Transform Load code see the integrations folder in the root Engineering directory of this repository.

</br>

### Functions

These are common functions that are used in the scripts and may also be wrappers around default toolkit functions for ease of use and porting of values.

</br>

### Integrations

These are specific to GCP, for non-GCP integrations (general integrations) see the integrations folder in the base engineering folder.

</br>

### Scripts

Typically will be for deploying infrastructure as code into GCP. These scripts will mostly be for the infrastructure components calling functions where required to pull through specific credential information for creating the infrastructure through Terraform scripts.

</br>

### Terraform

Terraform scripts/modules for creating GCP infrastructure. Typically the provider blocks will require a storage bucket to place the tf.state file as a back-port.

</br>