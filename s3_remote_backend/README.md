## Terraform configuration for creating an S3 Bucket and a DynamoDB Table, the S3 Bucket is used as a remote backend for Terraform and the DynamoDB table locks the S3 Bucket per best security practices--ensuring only one user or process can make changes to the infrastructure at a given time. 

## Terraform Commands
```
terraform init 
```

```
terraform validate
```

```
terraform plan
```

```
terraform apply
```

```
terraform destory
```