# Fundamentals in Developer Tools - Capstone Project

## Requirements:

--------------------------------------------------------------------------------------|-----------------------------
Project Requirements                                                                  | The amongus-todo app
--------------------------------------------------------------------------------------|-----------------------------
1. Deploy a node.js application                                                       | The amongus-todo app
2. to a VM/server of a cloud provider of your choice.                                 | aws.amazon.com
3. The application will have some basic tests                                         | the application has tests/server.test.js
4. The application must be dockerized/containerised                                   | docker image is built as part of Github action
5. The project must include a CI/CD pipeline using a CI/CD tool of your choice        | Github action is used
6. The CI/CD pipeline must include Automated tests                                    | tests/server.test.js is executed as part of Github action
7. The CI/CD pipeline must include Automated Deployment to the cloud provider         | docker image is built and pushed to ams ecr as part of Github action
8. The VM/server and other infrastructural resources must be created using Terraform  | full set of infrastructure is build using terraform
9. Infra creation can be done by invoking Terraform commands locally                  | terraform is invoked locally.


## 1. Deploy the amongus-todo Application

This refers to the code contained in the repository https://github.com/stanleynguyen/amongus-todo.  In order
not to run into additional confusions, I copied the code and create this separate repository instead of performing a fork. 
You may refer to the original repository for original `README.me` and other documentation.

## 2. AWS selected as the cloud provider

AWS was selected for this project due to earlier involvement and experiences.

## 3. Application has some basic tests

The application has `tests/server.test.js`.  This is used for as basic test.

## 4. Dockerized/containerised the Application

`Dockerfile` was created.  This is referenced during the CI/CD process to build a docker iamge of the app.  The docker image has
start up commands embedded to make it executable and thus containerised.

## 5. CI/CD Pipeline over Github Action

Github action is used for CI/CD.  This is achieved by having the file `.github/workflows/cicd.yml`.

   
## 6. CI/CD Pipeline inclides Automated test

`.github/workflows/cicd.yml` includes `run: npm test`, and the subsequent build step `needs: run-test`:

```yml
jobs:
  run-test:
    runs-on: ubuntu-latest
    steps:
...
      - name: Run tests
        run: npm test

  build-push:
    runs-on: ubuntu-latest
    needs: run-test
```

## 7. CI/CD pipeline include Automated Deployment

`.github/workflows/cicd.yml` includes steps to build and push docker image to AWS ECR:

```yml
  build-push:
    runs-on: ubuntu-latest
    needs: run-test
    steps:
...
    - name: Build, tag, and push image to Amazon ECR
      env:
        ECR_REGISTRY: ${{ steps.login-ecr.outputs.registry }}
        ECR_REPOSITORY: my-first-ecr-repo
        IMAGE_TAG: latest
      run: |
        docker build -t $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG .
        docker push $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG
```

## 8. VM/server infrastructural resources created using Terraform

Two versions of .tf files were created:

- `ecr.tf.txt`: This version of `.tf` creates only one component: an aws ecr repository by the name `my_first_ecr_repo`.  Once this is created, the Github workflow can be executed to build and
  push docker images of the app to this repository by the tag `latest`'.
- `main.tf.txt`: This version of `.tf` has the same aws ecr repository by the name `my_first_ecr_repo`, plus another 14 components to set up the infrastructure to host the app.

## 9. Manual Local invokation of terraform infra creation

1. `cp ecr.tf.txt infra.tf`, followed by `terraform apply`:

```bash
deng@LSOASUS2019:/mnt/c/Users/deng/DTCapstone/terraform/aws$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # aws_ecr_repository.my_first_ecr_repo will be created
  + resource "aws_ecr_repository" "my_first_ecr_repo" {
      + arn                  = (known after apply)
      + id                   = (known after apply)
      + image_tag_mutability = "MUTABLE"
      + name                 = "my-first-ecr-repo"
      + registry_id          = (known after apply)
      + repository_url       = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
╷
│ Warning: Version constraints inside provider configuration blocks are deprecated
│
│   on infra.tf line 2, in provider "aws":
│    2:   version = "~> 2.0"
│
│ Terraform 0.13 and earlier allowed provider version constraints inside the provider configuration block, but that is
│ now deprecated and will be removed in a future version of Terraform. To silence this warning, move the provider
│ version constraint into the required_providers block.
╵

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_ecr_repository.my_first_ecr_repo: Creating...
aws_ecr_repository.my_first_ecr_repo: Creation complete after 3s [id=my-first-ecr-repo]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
deng@LSOASUS2019:/mnt/c/Users/deng/DTCapstone/terraform/aws$
```
![ecr created in aws](./docs/img/ecr1.png)

2. Invoke Github CI/CD by making and pushing changes in the github app repository.

Workflow executed successfully:
![github workflow in action](./docs/img/cicd1.png)

App dockerized image created and pushed to ecr taggd latest:
![latest created in ecr](./docs/img/ecr2.png)

3.`cp main.tf.txt infra.tf`, followed by `terraform apply`:
```bash
deng@LSOASUS2019:/mnt/c/Users/deng/DTCapstone/terraform/aws$ terraform apply
aws_ecr_repository.my_first_ecr_repo: Refreshing state... [id=my-first-ecr-repo]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply":

  # aws_ecr_repository.my_first_ecr_repo has been changed
  ~ resource "aws_ecr_repository" "my_first_ecr_repo" {
        id                   = "my-first-ecr-repo"
        name                 = "my-first-ecr-repo"
      + tags                 = {}
        # (4 unchanged attributes hidden)

        # (1 unchanged block hidden)
    }

Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes,
the following plan may include actions to undo or respond to these changes.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # aws_alb.application_load_balancer will be created
  + resource "aws_alb" "application_load_balancer" {
...
      + name                       = "test-lb-tf"
...
    }

  # aws_default_subnet.default_subnet_a will be created
  + resource "aws_default_subnet" "default_subnet_a" {
...
      + availability_zone               = "us-east-2a"
...
    }

  # aws_default_subnet.default_subnet_b will be created
  + resource "aws_default_subnet" "default_subnet_b" {
...
      + availability_zone               = "us-east-2b"
...
    }

  # aws_default_subnet.default_subnet_c will be created
  + resource "aws_default_subnet" "default_subnet_c" {
...
      + availability_zone               = "us-east-2c"
...
    }

  # aws_default_vpc.default_vpc will be created
  + resource "aws_default_vpc" "default_vpc" {
...
    }

  # aws_ecs_cluster.my_cluster will be created
  + resource "aws_ecs_cluster" "my_cluster" {
...
      + name = "my-cluster"
    }

  # aws_ecs_service.my_first_service will be created
  + resource "aws_ecs_service" "my_first_service" {
...
      + launch_type                        = "FARGATE"
      + name                               = "my-first-service"
...
      + load_balancer {
          + container_name   = "my-first-task"
          + container_port   = 3000
...
        }
...
    }

  # aws_ecs_task_definition.my_first_task will be created
  + resource "aws_ecs_task_definition" "my_first_task" {
      + arn                      = (known after apply)
      + container_definitions    = jsonencode(
            [
              + {
...
                  + image        = "608290413320.dkr.ecr.us-east-2.amazonaws.com/my-first-ecr-repo"
                  + memory       = 512
                  + name         = "my-first-task"
                  + portMappings = [
                      + {
                          + containerPort = 3000
                          + hostPort      = 3000
                        },
                    ]
                },
            ]
        )
...
      + family                   = "my-first-task"
...
      + network_mode             = "awsvpc"
      + requires_compatibilities = [
          + "FARGATE",
        ]
...
    }

  # aws_iam_role.ecsTaskExecutionRole will be created
  + resource "aws_iam_role" "ecsTaskExecutionRole" {
...
      + name                  = "ecsTaskExecutionRole"
    }

  # aws_iam_role_policy_attachment.ecsTaskExecutionRole_policy will be created
  + resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
...
      + policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
      + role       = "ecsTaskExecutionRole"
    }

  # aws_lb_listener.listener will be created
  + resource "aws_lb_listener" "listener" {
...
    }

  # aws_lb_target_group.target_group will be created
  + resource "aws_lb_target_group" "target_group" {
...
      + name                               = "target-group"
      + port                               = 3000
...
    }

  # aws_security_group.load_balancer_security_group will be created
  + resource "aws_security_group" "load_balancer_security_group" {
...
    }

  # aws_security_group.service_security_group will be created
  + resource "aws_security_group" "service_security_group" {
...
    }

Plan: 14 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_default_subnet.default_subnet_b: Creating...
aws_default_subnet.default_subnet_a: Creating...
aws_default_vpc.default_vpc: Creating...
aws_iam_role.ecsTaskExecutionRole: Creating...
aws_ecs_cluster.my_cluster: Creating...
aws_default_subnet.default_subnet_c: Creating...
aws_security_group.load_balancer_security_group: Creating...
aws_default_subnet.default_subnet_c: Creation complete after 3s [id=subnet-3a8dbb76]
aws_default_subnet.default_subnet_a: Creation complete after 3s [id=subnet-908c1cfb]
aws_default_subnet.default_subnet_b: Creation complete after 3s [id=subnet-3a27e947]
aws_iam_role.ecsTaskExecutionRole: Creation complete after 3s [id=ecsTaskExecutionRole]
aws_iam_role_policy_attachment.ecsTaskExecutionRole_policy: Creating...
aws_ecs_task_definition.my_first_task: Creating...
aws_ecs_task_definition.my_first_task: Creation complete after 3s [id=my-first-task]
aws_iam_role_policy_attachment.ecsTaskExecutionRole_policy: Creation complete after 3s [id=ecsTaskExecutionRole-20211029092114404200000002]
aws_security_group.load_balancer_security_group: Creation complete after 10s [id=sg-01467773d9e662ecc]
aws_security_group.service_security_group: Creating...
aws_alb.application_load_balancer: Creating...
aws_default_vpc.default_vpc: Still creating... [10s elapsed]
aws_ecs_cluster.my_cluster: Still creating... [10s elapsed]
aws_default_vpc.default_vpc: Creation complete after 13s [id=vpc-6f751d04]
aws_lb_target_group.target_group: Creating...
aws_ecs_cluster.my_cluster: Creation complete after 14s [id=arn:aws:ecs:us-east-2:608290413320:cluster/my-cluster]
aws_lb_target_group.target_group: Creation complete after 5s [id=arn:aws:elasticloadbalancing:us-east-2:608290413320:targetgroup/target-group/f8c1647007cfc53e]
aws_security_group.service_security_group: Creation complete after 9s [id=sg-0243afc43ef82f6f3]
aws_alb.application_load_balancer: Still creating... [10s elapsed]
aws_alb.application_load_balancer: Still creating... [20s elapsed]
aws_alb.application_load_balancer: Still creating... [30s elapsed]
aws_alb.application_load_balancer: Still creating... [40s elapsed]
aws_alb.application_load_balancer: Still creating... [50s elapsed]
aws_alb.application_load_balancer: Still creating... [1m0s elapsed]
aws_alb.application_load_balancer: Still creating... [1m10s elapsed]
aws_alb.application_load_balancer: Still creating... [1m20s elapsed]
aws_alb.application_load_balancer: Still creating... [1m30s elapsed]
aws_alb.application_load_balancer: Still creating... [1m40s elapsed]
aws_alb.application_load_balancer: Still creating... [1m50s elapsed]
aws_alb.application_load_balancer: Still creating... [2m0s elapsed]
aws_alb.application_load_balancer: Still creating... [2m10s elapsed]
aws_alb.application_load_balancer: Creation complete after 2m20s [id=arn:aws:elasticloadbalancing:us-east-2:608290413320:loadbalancer/app/test-lb-tf/2e45bd76e4d74646]
aws_lb_listener.listener: Creating...
aws_lb_listener.listener: Creation complete after 2s [id=arn:aws:elasticloadbalancing:us-east-2:608290413320:listener/app/test-lb-tf/2e45bd76e4d74646/f3ff1a140920dd5a]
aws_ecs_service.my_first_service: Creating...
aws_ecs_service.my_first_service: Creation complete after 3s [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service]

Apply complete! Resources: 14 added, 0 changed, 0 destroyed.
deng@LSOASUS2019:/mnt/c/Users/deng/DTCapstone/terraform/aws$
```

ECS Cluster created
![ECS Cluster created](./docs/img/ecs.png)

Cluster details
![ECS Cluster details](./docs/img/cluster.png)

Service details
![ECS Service details](./docs/img/service.png)

Tasks in Service
![ECS Service Tasks](./docs/img/tasks.png)

Target group
![ECS target group](./docs/img/target_gp1.png)

Target group details
![ECS target group details](./docs/img/target_gp3.png)

Load balancer, the URL to access the app can be found under `DNS nmae`:
![Load balancer](./docs/img/loadbalancer.png)

App front page (test-lb-tf-145880904.us-east-2.elb.amazonaws.com):
![App front page](./docs/img/app1.png)

App todos page (http://test-lb-tf-145880904.us-east-2.elb.amazonaws.com/todos):
![App todos page](./docs/img/todo1.png)

4. Modif the app and push to github:

` (more text)` is added to "text" of the first record in `db.json`, and the change is pushed to github.
```
{
  "todos": [
    {
      "id": 1,
      "text": "Align Engine Output (more text)",
      "type": "long"
    },

```




- `secrets.SNYK_TOKEN` has to be set-up as one of the secrets in this repository.  The value of the secret is to be obtained
as `Auth Token` from https://app.snyk.io/account.

- Line 34 specifies that this job can be executed only after the preious job `build`.

- Lines 40 to 49 downloads the tar file created during the previous job, and loads the built image.

- Lines 51 to 56 performs the scan.

- Line 56 specifies that the docker image to be scanned is `encore428/amtodo` under the heading `image`.

- Reference was made to https://github.com/marketplace/actions/build-and-push-docker-images for this part of the exercise.

## If the security check passes...

```yml
58    rollout:
59     runs-on: ubuntu-latest
60     needs: inspect
```

Line 60 specifies that the `rollout` job should follow the completion of the previous job `inspect`.


## ...push the image into Docker hub

```yml
61     steps:
...
73       -
74         name: Login to Docker Hub
75         uses: docker/login-action@v1
76         with:
77           username: encore428
78           password: ${{ secrets.DOCKERHUB_TOKEN }}
79       -
80         name: docker push
81         run: docker push encore428/amtodo:latest
```

- In the repository, create `secret.DOCKERHUB_TOKEN`.  This stores my personal docker password.  MY docker id is `encore428`.

- Lines 62 to 72 again downloads the tar file created during the `build` job, and loads the built image.

- Lines 74 to 78 logs in to docker using personal id.

- Line 81 executes the docker command push to publish the image to personal library.

## Run a deployment to Heroku

The following segment is added to the end of `.github/workflows/docker-containers.yml`, base on instructions found
in https://github.com/marketplace/actions/deploy-to-heroku#deploy-with-docker.  It should be noted that instructions
make no reference to the docker image `encore428/amtodo`.  This job rebuild the docker image independently.
```yml
82   heroku:
83     runs-on: ubuntu-latest
84     needs: rollout
85     steps:
86       - uses: actions/checkout@v2
87       - uses: akhileshns/heroku-deploy@v3.12.12
88         with:
89           heroku_api_key: ${{secrets.HEROKU_API_KEY}}
90           heroku_app_name: encoreamtodo
91           heroku_email: encore428@gmail.com
92           usedocker: true
```

- Go to https://dashboard.heroku.com/apps and create an app.  App `encoreamtodo` was created.

- Go to https://dashboard.heroku.com/account to reveal the API Key.

- In the repository, create `secret.HEROKU_API_KEY` using the key revealed above.

Now proceed to push all these changes to Github.  Github action will take over and perform all the above jobs.
## Run Snyk check
![Run Snyk check](./snyk.png)

## Github Action
![Github Action](./action.png)

## Docker image push
![Docker image push](./docker.png)

## Heroku Deployment
![Heroku Deployment](./heroku.png)

## App on Heroku
![App on Heroku](./encoreamtodo.png)


## What about port mapping

According to https://devcenter.heroku.com/articles/container-registry-and-runtime#dockerfile-commands-and-runtime, 
Heroku ignores `EXPOSE` in `Dockerfile`.  It instead assigns a port at time of application start up, and the port is
placed into environment variable PORT which the app should read and make use of.

In this app, the program `index.js` has the following lines:
```js
const server = require('./server');

const port = process.env.PORT || 3000;
server.listen(port, () => {
  // eslint-disable-next-line no-console
  console.log('UP AND RUNNING @', port);
});
```

It reads `PORT` from `.env`, and uses `3000` as default.  In the case of Heroku deployment, the port was provided for, and
the Application log has these lines:

```
2021-10-17T09:31:04.444454+00:00 app[web.1]: UP AND RUNNING @ 37654
2021-10-17T09:31:04.774583+00:00 heroku[web.1]: State changed from starting to up
```


## Original PDF page on the homework

![Homework pdf](./CI_CD.pdf)





1. terraform main.tf to create a repository in Elastic Container Registry.
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
   
	   
	   
   
	   
	   




Deploy a node.js application (the amongus-todo app) to a VM/server of a cloud provider of your choice. 

The code is committed into a Git repository.

The application will have some basic tests

The application must be dockerized/containerised

The project must include a CI/CD pipeline using a CI/CD tool of your choice

The CI/CD pipeline must include
- Automated tests
- Deployment to the cloud provider

The VM/server and other infrastructural resources must be created using Terraform
- Infra creation can be done by invoking Terraform commands locally 





cd /mnt/c/Users/deng/DTCapstone



## References

Many blog posts were consulted and tried when working on this project.

- On using Github workflow to building and testing nodesjs: https://docs.github.com/en/actions/automating-builds-and-tests/building-and-testing-nodejs-or-python

- On building and pushing image to ecr: https://towardsaws.com/build-push-docker-image-to-aws-ecr-using-github-actions-8396888a8f9e

- On using terraform to create ecr in aws: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository

- On aws ecr push and ecs deploy: https://github.com/marketplace/actions/ecr-push-and-ecs-deploy

- A youtube clip om creating aws cluster, which will create an ec2 instance, then in the cluster create a task, task has a related container and image 
(which has been pushed to a ecr earlier on), some port mapping, security policy allow incoming traffic; go to cluster and run the task. https://www.youtube.com/watch?v=zs3tyVgiBQQ

- On using terraform to create aws cluster: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster

- On deploying an AWS ECS Cluster of EC2 Instances With Terraform: https://medium.com/swlh/creating-an-aws-ecs-cluster-of-ec2-instances-with-terraform-85a10b5cfbe3

- On creating AWS ECS cluster and deploying a nodejs application: https://dev.to/thnery/create-an-aws-ecs-cluster-using-terraform-g80

- The most relevant post that covers this project: https://medium.com/avmconsulting-blog/how-to-deploy-a-dockerised-node-js-application-on-aws-ecs-with-terraform-3e6bceb48785

