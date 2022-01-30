# Azure

To setup Azure infrastructure, use the Makefile. To see a list of commands as an on-screen menu, simply type `make`.

</br>

## Folder struture

```
azure 
|- functions
|- scripts
|- terraform
```

</br>

### Functions

These are common functions that are used in the scripts and may also be wrappers around default toolkit functions for ease of use and porting of values.

</br>

### Scripts

Typically will be for deploying infrastructure as code into Azure. These scripts will mostly be for the infrastructure components calling functions where required to pull through specific credential information for creating the infrastructure through Terraform scripts.

</br>

### Terraform

Terraform scripts/modules for creating Azure infrastructure. Typically the provider blocks will require an Azure blob storage container to place the tf.state file as a back-port.

</br>