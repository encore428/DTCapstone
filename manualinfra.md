## Manually Create AWS Infrastructure

During the early stage of the project, I was only able to create the ecr.  Infrastructure beyond ecr was created manually, with the intention that such can later be
translated into HashiCorp Configuration Language (HCL).  The effort was later found to be frutile as there is no easy translation.

The manual creation of infrastrcture practiced then is recorded below for future reference.

```
1. `terraform ecr.tf` to create a repository in Elastic Container Registry.

2. github action to test app, build docker image, push to ecr.

3. manually create aws cluster
   3.1 https://us-east-2.console.aws.amazon.com/ecs/home?region=us-east-2#/clusters
   3.2 Click [Create Cluster]
   3.3 Pick "EC2 Linux + Networking], click [Next step]
   3.4 Cluster name* = DTCluster
       Provisioning Model = On-Demand Instance (default)
       EC2 instance type* = t2.micro
	   Number of instances* = 1 (default)
	   EC2 AMI ID* = (default)
	   Root EBS Volume Size (GiB) = 30  (default)
	   Key pair = None - unable to SSH  (default)
	   VPC = ECS Default 
	   Subnets = ECS Default
	   Auto assign public IP = enabled
	   Security group = Create a new security group
	   Security group inbound rules: CIDR block = 0.0.0.0/0
	                                 Port range = 3000
	   Container instance IAM role = ecsInstanceRole
	   Click [Create]
4. Manually create Task Definiton
   4.1 https://us-east-2.console.aws.amazon.com/ecs/home?region=us-east-2#/taskDefinitions
   4.2 Click [Create new Task Definition]
   4.3 Pick "EC2", click [Next step]
	   Task definition name = DTTask
	   Task role = none
	   Network mode = <default>
	   Task execution role = ecsTaskExecutionRole
	   Task memory = 128
	   Task CPU = 128
   4.4 Click [Add container]
	   Container name = DTContainer
	   Image = 608290413320.dkr.ecr.us-east-2.amazonaws.com/dt-ecr-1:DTCapstone (image URI, copy from ecr)
	   Port mappings = 3000 3000
   4.5 Click [Create] to create the Task 

5. Manually deploy the task
   5.1 To to Amason ECS | Clusters https://us-east-2.console.aws.amazon.com/ecs/home?region=us-east-2#/clusters
   5.2 Click the cluster DTCluster
   5.3 Click Tasks tab, click [Run new Task]
       Lauch type = EC2
	   Task Definition = DTTask
	   Click [Run Task]

6. Check ec2 instance public ip address
   6.1 go to https://us-east-2.console.aws.amazon.com/ec2/v2/home?region=us-east-2#Home:
   6.2 click "instances (runnung)"
   6.3 click Instance ID of "ECS Instance  -EC2ContainerService-DTCluster"
   6.4 click copy Public IPv4 address : ec2-18-217-121-205.us-east-2.compute.amazonaws.com
   6.4 browser the url with above address and :3000 appended.
   
7. Verify CICD.
   Edit db.json, add " - test CICD" to text of todos 1
     "todos": [
    {
      "id": 1,
      "text": "Align Engine Output - test CICD",
      "type": "long"
    },
   commit the change and push to github.
   git hub pushes new image to ecr, new image replaces old image, old image becomes <untagged>.
   stop the task DTTask
   Run the task DTTask by repeating part of step 5 above.
```
