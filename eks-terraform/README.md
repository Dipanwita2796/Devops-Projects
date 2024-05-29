PREREQUISITE: 

1.Configure the AWS CLI with proper access key and secret key having access for eks cluster and nodegroup creation in the machine from where the terraform script will run.

CONFIGURATIONS:

1. Configure the region where the resources will be set up in the aws provider block in main.tf file.By default region is set to ap-south-1.

2. The script contains all the required variables in variables.tf file.

3. Providers.tf file contains the AWS version and terraform version, please upgrade or Downgrade this according to the terraform version present in users machine.

4. EKS cluster is created with version 1.26.

5. S3 bucket is created for storing the objects with required policies.

6. IAM role for the cluster and nodegroups are created with all the required policies attached to it for the EKS cluster and nodegroups.

6. Node types are mentioned as for "t3.micro" for test purpose.It can be configured accordingly for the UAT/Production readiness.

7. Security Groups are created with all inbound and outound traffic allowd in 0.0.0.0 . It can be configured accordingly as per security policy.

8. To test the script please use the below comands.

    terraform init
    terraform validate
    terraform plan
    terraform apply


