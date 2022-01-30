# AWS
Amazon Web Services infrastructure setup and use.


## How to setup credentials ready to use Terraform

1. AWS CLI login after install

```
Collect details to plug in when prompted: 
    AWS Access Key ID:   (created in IAM dashboard for user)
    AWS Secret Access Key:    (only available the first time the access key is created.)
    Default region name: ap-southeast-2
    Default output format: json
```

* ```aws configure``` 


</br>

## Folder Structure

```
aws
|- cloudformation 
|- functions
|- helm
|- integrations    
 \=     
  |- database     
|- scripts
|- terraform
```

Note: for non-AWS-specific integrations such as database connectors (e.g. MongoDB, Cassandra), application programming interfaces (e.g. Flask API classes), or Extract Transform Load code see the integrations folder in the root Engineering directory of this repository.

</br>

### Cloudformation

These are Cloudformation scripts for deploying infrastructure in AWS.

</br>

### Functions

These are common functions that are used in the scripts and may also be wrappers around default toolkit functions for ease of use and porting of values.

</br>

### Integrations

These are specific to AWS, for non-AWS integrations (general integrations) see the integrations folder in the base engineering folder.

</br>

### Scripts

Typically will be for deploying infrastructure as code into AWS. These scripts will mostly be for the infrastructure components calling functions where required to pull through specific credential information for creating the infrastructure through Terraform scripts.

</br>

### Terraform

Terraform scripts/modules for creating AWS infrastructure. Typically the provider blocks will require an S3 storage container to place the tf.state file as a back-port.

</br>