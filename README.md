# Fundamentals in Developer Tools - Capstone Project

Submitted by: Lee Sik On

## Requirements:

Project requirements are found [here](https://docs.google.com/document/d/1E2c-eUrI4hmEM7X0IqdIMRrd132XpIDH/edit), summarised in the following table, 
and elaborated below.

Project Requirements                                                                | Fulfillment
------------------------------------------------------------------------------------|--------------------------------------------------------------------------
1.Deploy a node.js application                                                      | The amongus-todo app
2.to a VM/server of a cloud provider of your choice.                                | aws.amazon.com
3.The application will have some basic tests                                        | the application has `tests/server.test.js`
4.The application must be dockerized/containerised                                  | docker image is built as part of Github action
5.The project must include a CI/CD pipeline using a CI/CD tool of your choice       | Github action is used
6.The CI/CD pipeline must include Automated tests                                   | tests/server.test.js is executed as part of Github action
7.The CI/CD pipeline must include Automated Deployment to the cloud provider        | docker image is built and pushed to ams ecr as part of Github action
8.The VM/server and other infrastructural resources must be created using Terraform | full set of infrastructure is build using terraform
9.Infra creation can be done by invoking Terraform commands locally                 | terraform is invoked locally.


## 1. Deploy the amongus-todo Application

This refers to the code contained in the repository https://github.com/stanleynguyen/amongus-todo.  In order
not to run into additional confusions, the repository is replicated here instead of performing a fork. 
You may refer to the original repository for original `README.me` and other documentation.

## 2. AWS selected as the cloud provider

AWS was selected for this project due to earlier practices.

## 3. Application has some basic tests

The application has [`tests/server.test.js`](./tests/server.test.js).  This is used for basic test.

## 4. Dockerized/containerised the Application

[`Dockerfile`](./Dockerfile) was created.  This is referenced during the CI/CD process to build a docker image of the app.  The docker image has
start up commands embedded to make it executable and thus containerised.

## 5. CI/CD Pipeline over Github Action

Github action is used for CI/CD.  This is achieved by having the file `.github/workflows/cicd.yml`.
   
## 6. CI/CD Pipeline inclides Automated test

[`.github/workflows/cicd.yml`](./.github/workflows/cicd.yml) includes `run: npm test`, and the subsequent build step `needs: run-test`:

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

[`.github/workflows/cicd.yml`](./.github/workflows/cicd.yml) includes steps to build and push docker image to AWS ECR:

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

- [`ecr.tf.txt`](./terraform/aws/ecr.tf.txt): This version of `.tf` creates only one component: an aws ecr repository by the name `my_first_ecr_repo`.  Once 
  this is created, the Github workflow can be executed to build and push docker images of the app to this repository by the tag `latest`'.
  
- [`main.tf.txt`](./terraform/aws/main.tf.txt): This version of `.tf` has the same aws ecr repository by the name `my_first_ecr_repo`, plus another 14 
  components to set up the infrastructure to host the app.

## 9. Manual Local invokation of terraform infra creation

The process of using this CI/CD facility is summarised as:
1. Invoke [Terraform `main.tf`](./docs/demo1.md) to create full infrastructure in AWS.
2. [Push the application to Github](./docs/github1.md), which performs app test and docker image build, and push the built image to AWS in ecr.  AWS in turn brings up the application.
3. [Verify application is running](./docs/appver.md).
4. Make application change, [push the application change to Github](./docs/github2.md), which performs app test and docker image build, and push the new image to AWS in ecr.
5. AWS however does not automtically deploy the new image onto the running instances.
6. To deploy the new application image, invoke [Terraform `ecr.tf`](./docs/demo2.md) to tear down the infrastructure leaving only ecr, then invoke [Terraform `main.tf`](./docs/demo3.md) again to re-create the full infrastructure.
7. [Verify that updated application is running](./docs/appver2.md).
8. Finally [tear down](./docs/teardown.md) the entire infratructure in AWS.


## References

Many blog posts were consulted and tried when working on this project.

On using Github workflow to building and testing nodesjs: https://docs.github.com/en/actions/automating-builds-and-tests/building-and-testing-nodejs-or-python

On building and pushing image to ecr: https://towardsaws.com/build-push-docker-image-to-aws-ecr-using-github-actions-8396888a8f9e

On using terraform to create ecr in aws: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository

On aws ecr push and ecs deploy: https://github.com/marketplace/actions/ecr-push-and-ecs-deploy

A youtube clip om creating aws cluster, which will create an ec2 instance, then in the cluster create a task, task has a related container and image 
(which has been pushed to a ecr earlier on), some port mapping, security policy allow incoming traffic; go to cluster and run the task. https://www.youtube.com/watch?v=zs3tyVgiBQQ

On using terraform to create aws cluster: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster

On deploying an AWS ECS Cluster of EC2 Instances With Terraform: https://medium.com/swlh/creating-an-aws-ecs-cluster-of-ec2-instances-with-terraform-85a10b5cfbe3

On creating AWS ECS cluster and deploying a nodejs application: https://dev.to/thnery/create-an-aws-ecs-cluster-using-terraform-g80

The most relevant post that covers this project: https://medium.com/avmconsulting-blog/how-to-deploy-a-dockerised-node-js-application-on-aws-ecs-with-terraform-3e6bceb48785

## Manual Infrastruture

During the early stage of working on this project, I started by creating the infrastructure manually, with the intention that such manual procedures be translated into HashiCorp Configuration Language.
However, it was later realized that there is no straight forward translation.  The [manual process](./docs/manualinfra.md) is recorded here for reference nevertheless.