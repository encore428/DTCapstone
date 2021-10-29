# Fundamentals in Developer Tools - Capstone Project

## Requirements:

--------------------------------------------------------------------------------------|-----------------------------
Project Requirements                                                                  | The amongus-todo app
--------------------------------------------------------------------------------------|-----------------------------
1. Deploy a node.js application                                                       | The amongus-todo app
                                                                                      |
2. to a VM/server of a cloud provider of your choice.                                 | aws.amazon.com
                                                                                      |
3. The application will have some basic tests                                         | the application has tests/server.test.js
                                                                                      |
4. The application must be dockerized/containerised                                   | docker image is built as part of Github action
                                                                                      |
5. The project must include a CI/CD pipeline using a CI/CD tool of your choice        | Github action is used
                                                                                      |
6. The CI/CD pipeline must include Automated tests                                    | tests/server.test.js is executed as part of Github action
                                                                                      | 
7. The CI/CD pipeline must include Automated Deployment to the cloud provider         | docker image is built and pushed to ams ecr as part of Github action
                                                                                      |
8. The VM/server and other infrastructural resources must be created using Terraform  | full set of infrastructure is build using terraform
                                                                                      |
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

# Exection

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

2. Invoke Github CI/CD by making and pushing changes in the github app repository.


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

