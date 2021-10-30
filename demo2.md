## Terraform ecr.tf

Invoke Terraform using `ecr.tf.txt` to tear down the entire infrastructure leaving only ecr.

```
deng@LSOASUS2019:/mnt/c/Users/deng/DTCapstone/terraform/aws$ cp ecr.tf.txt infra.tf
deng@LSOASUS2019:/mnt/c/Users/deng/DTCapstone/terraform/aws$ cat infra.tf
provider "aws" {
  region  = "us-east-2" # Use your own region here
}

resource "aws_ecr_repository" "my_first_ecr_repo" {
  name = "my-first-ecr-repo" # Naming my repository
}

deng@LSOASUS2019:/mnt/c/Users/deng/DTCapstone/terraform/aws$ terraform apply
aws_iam_role_policy_attachment.ecsTaskExecutionRole_policy: Refreshing state... [id=ecsTaskExecutionRole-20211030014859435100000002]
aws_default_vpc.default_vpc: Refreshing state... [id=vpc-6f751d04]
aws_ecs_task_definition.my_first_task: Refreshing state... [id=my-first-task]
aws_default_subnet.default_subnet_b: Refreshing state... [id=subnet-3a27e947]
aws_default_subnet.default_subnet_a: Refreshing state... [id=subnet-908c1cfb]
aws_iam_role.ecsTaskExecutionRole: Refreshing state... [id=ecsTaskExecutionRole]
aws_default_subnet.default_subnet_c: Refreshing state... [id=subnet-3a8dbb76]
aws_alb.application_load_balancer: Refreshing state... [id=arn:aws:elasticloadbalancing:us-east-2:608290413320:loadbalancer/app/test-lb-tf/3897da4049cf2383]
aws_security_group.service_security_group: Refreshing state... [id=sg-0d665558dc72b5e62]
aws_lb_listener.listener: Refreshing state... [id=arn:aws:elasticloadbalancing:us-east-2:608290413320:listener/app/test-lb-tf/3897da4049cf2383/04d7b746b5216b11]
aws_ecs_cluster.my_cluster: Refreshing state... [id=arn:aws:ecs:us-east-2:608290413320:cluster/my-cluster]
aws_ecs_service.my_first_service: Refreshing state... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service]
aws_lb_target_group.target_group: Refreshing state... [id=arn:aws:elasticloadbalancing:us-east-2:608290413320:targetgroup/target-group/33a4c59f293a95e0]
aws_security_group.load_balancer_security_group: Refreshing state... [id=sg-0768777d477ed794a]
aws_ecr_repository.my_first_ecr_repo: Refreshing state... [id=my-first-ecr-repo]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply":

  # aws_default_subnet.default_subnet_c has been changed
  ~ resource "aws_default_subnet" "default_subnet_c" {
        id                              = "subnet-3a8dbb76"
      + tags                            = {}
        # (8 unchanged attributes hidden)
    }
  # aws_security_group.service_security_group has been changed
  ~ resource "aws_security_group" "service_security_group" {
        id                     = "sg-0d665558dc72b5e62"
        name                   = "terraform-20211030014905058600000003"
      + tags                   = {}
        # (7 unchanged attributes hidden)
    }
  # aws_ecs_cluster.my_cluster has been changed
  ~ resource "aws_ecs_cluster" "my_cluster" {
      + capacity_providers = []
        id                 = "arn:aws:ecs:us-east-2:608290413320:cluster/my-cluster"
        name               = "my-cluster"
      + tags               = {}
        # (1 unchanged attribute hidden)
    }
  # aws_default_vpc.default_vpc has been changed
  ~ resource "aws_default_vpc" "default_vpc" {
        id                               = "vpc-6f751d04"
      + tags                             = {}
        # (12 unchanged attributes hidden)
    }
  # aws_ecr_repository.my_first_ecr_repo has been changed
  ~ resource "aws_ecr_repository" "my_first_ecr_repo" {
        id                   = "my-first-ecr-repo"
        name                 = "my-first-ecr-repo"
      + tags                 = {}
        # (4 unchanged attributes hidden)

        # (1 unchanged block hidden)
    }
  # aws_alb.application_load_balancer has been changed
  ~ resource "aws_alb" "application_load_balancer" {
        id                         = "arn:aws:elasticloadbalancing:us-east-2:608290413320:loadbalancer/app/test-lb-tf/3897da4049cf2383"
        name                       = "test-lb-tf"
      + tags                       = {}
        # (14 unchanged attributes hidden)


        # (4 unchanged blocks hidden)
    }
  # aws_security_group.load_balancer_security_group has been changed
  ~ resource "aws_security_group" "load_balancer_security_group" {
        id                     = "sg-0768777d477ed794a"
        name                   = "terraform-20211030014855595000000001"
      + tags                   = {}
        # (7 unchanged attributes hidden)
    }
  # aws_lb_target_group.target_group has been changed
  ~ resource "aws_lb_target_group" "target_group" {
        id                                 = "arn:aws:elasticloadbalancing:us-east-2:608290413320:targetgroup/target-group/33a4c59f293a95e0"
        name                               = "target-group"
      + tags                               = {}
        # (11 unchanged attributes hidden)


        # (2 unchanged blocks hidden)
    }
  # aws_default_subnet.default_subnet_b has been changed
  ~ resource "aws_default_subnet" "default_subnet_b" {
        id                              = "subnet-3a27e947"
      + tags                            = {}
        # (8 unchanged attributes hidden)
    }
  # aws_ecs_service.my_first_service has been changed
  ~ resource "aws_ecs_service" "my_first_service" {
        id                                 = "arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service"
        name                               = "my-first-service"
      + tags                               = {}
        # (12 unchanged attributes hidden)



        # (3 unchanged blocks hidden)
    }
  # aws_default_subnet.default_subnet_a has been changed
  ~ resource "aws_default_subnet" "default_subnet_a" {
        id                              = "subnet-908c1cfb"
      + tags                            = {}
        # (8 unchanged attributes hidden)
    }
  # aws_ecs_task_definition.my_first_task has been changed
  ~ resource "aws_ecs_task_definition" "my_first_task" {
        id                       = "my-first-task"
      + tags                     = {}
        # (9 unchanged attributes hidden)
    }
  # aws_iam_role.ecsTaskExecutionRole has been changed
  ~ resource "aws_iam_role" "ecsTaskExecutionRole" {
        id                    = "ecsTaskExecutionRole"
        name                  = "ecsTaskExecutionRole"
      + tags                  = {}
        # (7 unchanged attributes hidden)
    }

Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes,
the following plan may include actions to undo or respond to these changes.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_alb.application_load_balancer will be destroyed
  - resource "aws_alb" "application_load_balancer" {
      - arn                        = "arn:aws:elasticloadbalancing:us-east-2:608290413320:loadbalancer/app/test-lb-tf/3897da4049cf2383" -> null
      - arn_suffix                 = "app/test-lb-tf/3897da4049cf2383" -> null
      - dns_name                   = "test-lb-tf-544640188.us-east-2.elb.amazonaws.com" -> null
      - drop_invalid_header_fields = false -> null
      - enable_deletion_protection = false -> null
      - enable_http2               = true -> null
      - id                         = "arn:aws:elasticloadbalancing:us-east-2:608290413320:loadbalancer/app/test-lb-tf/3897da4049cf2383" -> null
      - idle_timeout               = 60 -> null
      - internal                   = false -> null
      - ip_address_type            = "ipv4" -> null
      - load_balancer_type         = "application" -> null
      - name                       = "test-lb-tf" -> null
      - security_groups            = [
          - "sg-0768777d477ed794a",
        ] -> null
      - subnets                    = [
          - "subnet-3a27e947",
          - "subnet-3a8dbb76",
          - "subnet-908c1cfb",
        ] -> null
      - tags                       = {} -> null
      - vpc_id                     = "vpc-6f751d04" -> null
      - zone_id                    = "Z3AADJGX6KTTL2" -> null

      - access_logs {
          - enabled = false -> null
        }

      - subnet_mapping {
          - subnet_id = "subnet-3a27e947" -> null
        }
      - subnet_mapping {
          - subnet_id = "subnet-3a8dbb76" -> null
        }
      - subnet_mapping {
          - subnet_id = "subnet-908c1cfb" -> null
        }
    }

  # aws_default_subnet.default_subnet_a will be destroyed
  - resource "aws_default_subnet" "default_subnet_a" {
      - arn                             = "arn:aws:ec2:us-east-2:608290413320:subnet/subnet-908c1cfb" -> null
      - assign_ipv6_address_on_creation = false -> null
      - availability_zone               = "us-east-2a" -> null
      - availability_zone_id            = "use2-az1" -> null
      - cidr_block                      = "172.31.0.0/20" -> null
      - id                              = "subnet-908c1cfb" -> null
      - map_public_ip_on_launch         = true -> null
      - owner_id                        = "608290413320" -> null
      - tags                            = {} -> null
      - vpc_id                          = "vpc-6f751d04" -> null
    }

  # aws_default_subnet.default_subnet_b will be destroyed
  - resource "aws_default_subnet" "default_subnet_b" {
      - arn                             = "arn:aws:ec2:us-east-2:608290413320:subnet/subnet-3a27e947" -> null
      - assign_ipv6_address_on_creation = false -> null
      - availability_zone               = "us-east-2b" -> null
      - availability_zone_id            = "use2-az2" -> null
      - cidr_block                      = "172.31.16.0/20" -> null
      - id                              = "subnet-3a27e947" -> null
      - map_public_ip_on_launch         = true -> null
      - owner_id                        = "608290413320" -> null
      - tags                            = {} -> null
      - vpc_id                          = "vpc-6f751d04" -> null
    }

  # aws_default_subnet.default_subnet_c will be destroyed
  - resource "aws_default_subnet" "default_subnet_c" {
      - arn                             = "arn:aws:ec2:us-east-2:608290413320:subnet/subnet-3a8dbb76" -> null
      - assign_ipv6_address_on_creation = false -> null
      - availability_zone               = "us-east-2c" -> null
      - availability_zone_id            = "use2-az3" -> null
      - cidr_block                      = "172.31.32.0/20" -> null
      - id                              = "subnet-3a8dbb76" -> null
      - map_public_ip_on_launch         = true -> null
      - owner_id                        = "608290413320" -> null
      - tags                            = {} -> null
      - vpc_id                          = "vpc-6f751d04" -> null
    }

  # aws_default_vpc.default_vpc will be destroyed
  - resource "aws_default_vpc" "default_vpc" {
      - arn                              = "arn:aws:ec2:us-east-2:608290413320:vpc/vpc-6f751d04" -> null
      - assign_generated_ipv6_cidr_block = false -> null
      - cidr_block                       = "172.31.0.0/16" -> null
      - default_network_acl_id           = "acl-ea84d381" -> null
      - default_route_table_id           = "rtb-97ebdafc" -> null
      - default_security_group_id        = "sg-981c42d2" -> null
      - dhcp_options_id                  = "dopt-fecd8f95" -> null
      - enable_dns_hostnames             = true -> null
      - enable_dns_support               = true -> null
      - id                               = "vpc-6f751d04" -> null
      - instance_tenancy                 = "default" -> null
      - main_route_table_id              = "rtb-97ebdafc" -> null
      - owner_id                         = "608290413320" -> null
      - tags                             = {} -> null
    }

  # aws_ecs_cluster.my_cluster will be destroyed
  - resource "aws_ecs_cluster" "my_cluster" {
      - arn                = "arn:aws:ecs:us-east-2:608290413320:cluster/my-cluster" -> null
      - capacity_providers = [] -> null
      - id                 = "arn:aws:ecs:us-east-2:608290413320:cluster/my-cluster" -> null
      - name               = "my-cluster" -> null
      - tags               = {} -> null
    }

  # aws_ecs_service.my_first_service will be destroyed
  - resource "aws_ecs_service" "my_first_service" {
      - cluster                            = "arn:aws:ecs:us-east-2:608290413320:cluster/my-cluster" -> null
      - deployment_maximum_percent         = 200 -> null
      - deployment_minimum_healthy_percent = 100 -> null
      - desired_count                      = 3 -> null
      - enable_ecs_managed_tags            = false -> null
      - health_check_grace_period_seconds  = 0 -> null
      - iam_role                           = "aws-service-role" -> null
      - id                                 = "arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service" -> null
      - launch_type                        = "FARGATE" -> null
      - name                               = "my-first-service" -> null
      - platform_version                   = "LATEST" -> null
      - propagate_tags                     = "NONE" -> null
      - scheduling_strategy                = "REPLICA" -> null
      - tags                               = {} -> null
      - task_definition                    = "arn:aws:ecs:us-east-2:608290413320:task-definition/my-first-task:10" -> null

      - deployment_controller {
          - type = "ECS" -> null
        }

      - load_balancer {
          - container_name   = "my-first-task" -> null
          - container_port   = 3000 -> null
          - target_group_arn = "arn:aws:elasticloadbalancing:us-east-2:608290413320:targetgroup/target-group/33a4c59f293a95e0" -> null
        }

      - network_configuration {
          - assign_public_ip = true -> null
          - security_groups  = [
              - "sg-0d665558dc72b5e62",
            ] -> null
          - subnets          = [
              - "subnet-3a27e947",
              - "subnet-3a8dbb76",
              - "subnet-908c1cfb",
            ] -> null
        }
    }

  # aws_ecs_task_definition.my_first_task will be destroyed
  - resource "aws_ecs_task_definition" "my_first_task" {
      - arn                      = "arn:aws:ecs:us-east-2:608290413320:task-definition/my-first-task:10" -> null
      - container_definitions    = jsonencode(
            [
              - {
                  - cpu          = 256
                  - environment  = []
                  - essential    = true
                  - image        = "608290413320.dkr.ecr.us-east-2.amazonaws.com/my-first-ecr-repo"
                  - memory       = 512
                  - mountPoints  = []
                  - name         = "my-first-task"
                  - portMappings = [
                      - {
                          - containerPort = 3000
                          - hostPort      = 3000
                          - protocol      = "tcp"
                        },
                    ]
                  - volumesFrom  = []
                },
            ]
        ) -> null
      - cpu                      = "256" -> null
      - execution_role_arn       = "arn:aws:iam::608290413320:role/ecsTaskExecutionRole" -> null
      - family                   = "my-first-task" -> null
      - id                       = "my-first-task" -> null
      - memory                   = "512" -> null
      - network_mode             = "awsvpc" -> null
      - requires_compatibilities = [
          - "FARGATE",
        ] -> null
      - revision                 = 10 -> null
      - tags                     = {} -> null
    }

  # aws_iam_role.ecsTaskExecutionRole will be destroyed
  - resource "aws_iam_role" "ecsTaskExecutionRole" {
      - arn                   = "arn:aws:iam::608290413320:role/ecsTaskExecutionRole" -> null
      - assume_role_policy    = jsonencode(
            {
              - Statement = [
                  - {
                      - Action    = "sts:AssumeRole"
                      - Effect    = "Allow"
                      - Principal = {
                          - Service = "ecs-tasks.amazonaws.com"
                        }
                      - Sid       = ""
                    },
                ]
              - Version   = "2012-10-17"
            }
        ) -> null
      - create_date           = "2021-10-30T01:48:58Z" -> null
      - force_detach_policies = false -> null
      - id                    = "ecsTaskExecutionRole" -> null
      - max_session_duration  = 3600 -> null
      - name                  = "ecsTaskExecutionRole" -> null
      - path                  = "/" -> null
      - tags                  = {} -> null
      - unique_id             = "AROAY3IHPDMEMSWGT4KLF" -> null
    }

  # aws_iam_role_policy_attachment.ecsTaskExecutionRole_policy will be destroyed
  - resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
      - id         = "ecsTaskExecutionRole-20211030014859435100000002" -> null
      - policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy" -> null
      - role       = "ecsTaskExecutionRole" -> null
    }

  # aws_lb_listener.listener will be destroyed
  - resource "aws_lb_listener" "listener" {
      - arn               = "arn:aws:elasticloadbalancing:us-east-2:608290413320:listener/app/test-lb-tf/3897da4049cf2383/04d7b746b5216b11" -> null
      - id                = "arn:aws:elasticloadbalancing:us-east-2:608290413320:listener/app/test-lb-tf/3897da4049cf2383/04d7b746b5216b11" -> null
      - load_balancer_arn = "arn:aws:elasticloadbalancing:us-east-2:608290413320:loadbalancer/app/test-lb-tf/3897da4049cf2383" -> null
      - port              = 80 -> null
      - protocol          = "HTTP" -> null

      - default_action {
          - order            = 1 -> null
          - target_group_arn = "arn:aws:elasticloadbalancing:us-east-2:608290413320:targetgroup/target-group/33a4c59f293a95e0" -> null
          - type             = "forward" -> null
        }
    }

  # aws_lb_target_group.target_group will be destroyed
  - resource "aws_lb_target_group" "target_group" {
      - arn                                = "arn:aws:elasticloadbalancing:us-east-2:608290413320:targetgroup/target-group/33a4c59f293a95e0" -> null
      - arn_suffix                         = "targetgroup/target-group/33a4c59f293a95e0" -> null
      - deregistration_delay               = 300 -> null
      - id                                 = "arn:aws:elasticloadbalancing:us-east-2:608290413320:targetgroup/target-group/33a4c59f293a95e0" -> null
      - lambda_multi_value_headers_enabled = false -> null
      - load_balancing_algorithm_type      = "round_robin" -> null
      - name                               = "target-group" -> null
      - port                               = 3000 -> null
      - protocol                           = "HTTP" -> null
      - proxy_protocol_v2                  = false -> null
      - slow_start                         = 0 -> null
      - tags                               = {} -> null
      - target_type                        = "ip" -> null
      - vpc_id                             = "vpc-6f751d04" -> null

      - health_check {
          - enabled             = true -> null
          - healthy_threshold   = 5 -> null
          - interval            = 30 -> null
          - matcher             = "200" -> null
          - path                = "/" -> null
          - port                = "traffic-port" -> null
          - protocol            = "HTTP" -> null
          - timeout             = 5 -> null
          - unhealthy_threshold = 2 -> null
        }

      - stickiness {
          - cookie_duration = 86400 -> null
          - enabled         = false -> null
          - type            = "lb_cookie" -> null
        }
    }

  # aws_security_group.load_balancer_security_group will be destroyed
  - resource "aws_security_group" "load_balancer_security_group" {
      - arn                    = "arn:aws:ec2:us-east-2:608290413320:security-group/sg-0768777d477ed794a" -> null
      - description            = "Managed by Terraform" -> null
      - egress                 = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 0
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "-1"
              - security_groups  = []
              - self             = false
              - to_port          = 0
            },
        ] -> null
      - id                     = "sg-0768777d477ed794a" -> null
      - ingress                = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 80
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 80
            },
        ] -> null
      - name                   = "terraform-20211030014855595000000001" -> null
      - owner_id               = "608290413320" -> null
      - revoke_rules_on_delete = false -> null
      - tags                   = {} -> null
      - vpc_id                 = "vpc-6f751d04" -> null
    }

  # aws_security_group.service_security_group will be destroyed
  - resource "aws_security_group" "service_security_group" {
      - arn                    = "arn:aws:ec2:us-east-2:608290413320:security-group/sg-0d665558dc72b5e62" -> null
      - description            = "Managed by Terraform" -> null
      - egress                 = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 0
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "-1"
              - security_groups  = []
              - self             = false
              - to_port          = 0
            },
        ] -> null
      - id                     = "sg-0d665558dc72b5e62" -> null
      - ingress                = [
          - {
              - cidr_blocks      = []
              - description      = ""
              - from_port        = 0
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "-1"
              - security_groups  = [
                  - "sg-0768777d477ed794a",
                ]
              - self             = false
              - to_port          = 0
            },
        ] -> null
      - name                   = "terraform-20211030014905058600000003" -> null
      - owner_id               = "608290413320" -> null
      - revoke_rules_on_delete = false -> null
      - tags                   = {} -> null
      - vpc_id                 = "vpc-6f751d04" -> null
    }

Plan: 0 to add, 0 to change, 14 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_iam_role_policy_attachment.ecsTaskExecutionRole_policy: Destroying... [id=ecsTaskExecutionRole-20211030014859435100000002]
aws_ecs_service.my_first_service: Destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service]
aws_iam_role_policy_attachment.ecsTaskExecutionRole_policy: Destruction complete after 2s
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 10s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 20s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 30s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 40s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 50s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 1m0s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 1m10s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 1m20s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 1m30s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 1m40s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 1m50s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 2m0s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 2m10s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 2m20s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 2m30s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 2m40s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 2m50s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 3m0s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 3m10s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 3m20s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 3m30s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 3m40s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 3m50s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 4m0s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 4m10s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 4m20s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 4m30s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 4m40s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 4m50s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 5m0s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 5m10s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 5m20s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 5m30s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 5m40s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 5m50s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 6m0s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 6m10s elapsed]
aws_ecs_service.my_first_service: Still destroying... [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service, 6m20s elapsed]
aws_ecs_service.my_first_service: Destruction complete after 6m22s
aws_ecs_cluster.my_cluster: Destroying... [id=arn:aws:ecs:us-east-2:608290413320:cluster/my-cluster]
aws_ecs_task_definition.my_first_task: Destroying... [id=my-first-task]
aws_security_group.service_security_group: Destroying... [id=sg-0d665558dc72b5e62]
aws_lb_listener.listener: Destroying... [id=arn:aws:elasticloadbalancing:us-east-2:608290413320:listener/app/test-lb-tf/3897da4049cf2383/04d7b746b5216b11]
aws_ecs_task_definition.my_first_task: Destruction complete after 1s
aws_iam_role.ecsTaskExecutionRole: Destroying... [id=ecsTaskExecutionRole]
aws_lb_listener.listener: Destruction complete after 1s
aws_lb_target_group.target_group: Destroying... [id=arn:aws:elasticloadbalancing:us-east-2:608290413320:targetgroup/target-group/33a4c59f293a95e0]
aws_alb.application_load_balancer: Destroying... [id=arn:aws:elasticloadbalancing:us-east-2:608290413320:loadbalancer/app/test-lb-tf/3897da4049cf2383]
aws_ecs_cluster.my_cluster: Destruction complete after 2s
aws_security_group.service_security_group: Destruction complete after 2s
aws_lb_target_group.target_group: Destruction complete after 1s
aws_default_vpc.default_vpc: Destroying... [id=vpc-6f751d04]
aws_default_vpc.default_vpc: Destruction complete after 0s
aws_iam_role.ecsTaskExecutionRole: Destruction complete after 2s
aws_alb.application_load_balancer: Destruction complete after 5s
aws_default_subnet.default_subnet_b: Destroying... [id=subnet-3a27e947]
aws_default_subnet.default_subnet_a: Destroying... [id=subnet-908c1cfb]
aws_default_subnet.default_subnet_c: Destroying... [id=subnet-3a8dbb76]
aws_security_group.load_balancer_security_group: Destroying... [id=sg-0768777d477ed794a]
aws_default_subnet.default_subnet_b: Destruction complete after 0s
aws_default_subnet.default_subnet_a: Destruction complete after 0s
aws_default_subnet.default_subnet_c: Destruction complete after 0s
aws_security_group.load_balancer_security_group: Still destroying... [id=sg-0768777d477ed794a, 10s elapsed]
aws_security_group.load_balancer_security_group: Still destroying... [id=sg-0768777d477ed794a, 20s elapsed]
aws_security_group.load_balancer_security_group: Still destroying... [id=sg-0768777d477ed794a, 30s elapsed]
aws_security_group.load_balancer_security_group: Destruction complete after 36s

Apply complete! Resources: 0 added, 0 changed, 14 destroyed.
deng@LSOASUS2019:/mnt/c/Users/deng/DTCapstone/terraform/aws$
```