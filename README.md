## This repository is a solution of the [Terraform Cloud Resume Challenge](https://github.com/cloudresumechallenge/projects/blob/main/projects/aws/terraform.md).

## Terraform configuration for creating an AWS EC2 Instance runnning a basic web application in Docker, supported by a Elastic Load Balancer and Auto Scaling Group.

### Go to the Remote Backend directory
```
cd s3_remote_backend
```

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

### Go to Root Directory 
```
cd .. 
```

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


### Load Balancer Endpoint
- node-alb-1253122593.eu-north-1.elb.amazonaws.com


### Initiate a Scaling Event by increasing the CPU Load of the EC2 Instance using AWS Session Manager
- Go to the AWS Systems Manager via the AWS Console

![./terraform-web-app/images/Systems_Manager.png](./images/Systems_Manager.png)



- Navigate to the Fleet Manager, the Fleet Manager indicates the SSM Agent is online for the EC2 Instance which indicates the SSM Agent is ready.

![./terraform-web-app/images/Fleet_Manager.png](./images/Fleet_Manager.png)



- Navigate to Session Manager

![./terraform-web-app/images/Session_Manager.png](./images/Session_Manager.png)



- Start a session with the EC2 Instance



- Install the `stress` test tool
```
sudo yum install stress -y
```



- Initiate a scale up event in the by launching the `stress` test in the background with a cpu--8cores in 800secs
```
sudo stress --cpu 8 --timeout 800 &
```



![./terraform-web-app/images/Session_Manager_EC2.png](./images/Session_Manager_EC2.png)



- Autoscale EC2 Instances for scale up event

![./terraform-web-app/images/ASG_EC2_Instances](./images/ASG_EC2_Instances.png)



- Initiate a scale down event by stopping the`stress` test
```
sudo killall stress
```



- Terminated EC2 Instances for scale down event

![./terraform-web-app/images/Terminated_EC2_Instances](./images/Terminated_EC2_Instances.png)



### Extras
- [Terraform Documentation on Managing AWS Auto Scaling Groups](https://developer.hashicorp.com/terraform/tutorials/aws/aws-asg).
- [Terraform Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure).