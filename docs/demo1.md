## Terraform main.tf

Invoke Terraform using `main.tf.txt` to build entire infrastructure from scratch.

```
deng@LSOASUS2019:~$ cd /mnt/c/Users/deng/DTCapstone/terraform/aws
deng@LSOASUS2019:/mnt/c/Users/deng/DTCapstone/terraform/aws$ ls
ecr.tf.txt  infra.tf  main.tf.txt  terraform.tfstate  terraform.tfstate.backup
deng@LSOASUS2019:/mnt/c/Users/deng/DTCapstone/terraform/aws$ cp main.tf.txt infra.tf
deng@LSOASUS2019:/mnt/c/Users/deng/DTCapstone/terraform/aws$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # aws_alb.application_load_balancer will be created
  + resource "aws_alb" "application_load_balancer" {
      + arn                        = (known after apply)
      + arn_suffix                 = (known after apply)
      + dns_name                   = (known after apply)
      + drop_invalid_header_fields = false
      + enable_deletion_protection = false
      + enable_http2               = true
      + id                         = (known after apply)
      + idle_timeout               = 60
      + internal                   = (known after apply)
      + ip_address_type            = (known after apply)
      + load_balancer_type         = "application"
      + name                       = "test-lb-tf"
      + security_groups            = (known after apply)
      + subnets                    = (known after apply)
      + vpc_id                     = (known after apply)
      + zone_id                    = (known after apply)

      + subnet_mapping {
          + allocation_id = (known after apply)
          + subnet_id     = (known after apply)
        }
    }

  # aws_default_subnet.default_subnet_a will be created
  + resource "aws_default_subnet" "default_subnet_a" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = (known after apply)
      + availability_zone               = "us-east-2a"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = (known after apply)
      + id                              = (known after apply)
      + ipv6_cidr_block                 = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = (known after apply)
      + owner_id                        = (known after apply)
      + vpc_id                          = (known after apply)
    }

  # aws_default_subnet.default_subnet_b will be created
  + resource "aws_default_subnet" "default_subnet_b" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = (known after apply)
      + availability_zone               = "us-east-2b"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = (known after apply)
      + id                              = (known after apply)
      + ipv6_cidr_block                 = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = (known after apply)
      + owner_id                        = (known after apply)
      + vpc_id                          = (known after apply)
    }

  # aws_default_subnet.default_subnet_c will be created
  + resource "aws_default_subnet" "default_subnet_c" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = (known after apply)
      + availability_zone               = "us-east-2c"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = (known after apply)
      + id                              = (known after apply)
      + ipv6_cidr_block                 = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = (known after apply)
      + owner_id                        = (known after apply)
      + vpc_id                          = (known after apply)
    }

  # aws_default_vpc.default_vpc will be created
  + resource "aws_default_vpc" "default_vpc" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = (known after apply)
      + cidr_block                       = (known after apply)
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = (known after apply)
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = (known after apply)
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
    }

  # aws_ecr_repository.my_first_ecr_repo will be created
  + resource "aws_ecr_repository" "my_first_ecr_repo" {
      + arn                  = (known after apply)
      + id                   = (known after apply)
      + image_tag_mutability = "MUTABLE"
      + name                 = "my-first-ecr-repo"
      + registry_id          = (known after apply)
      + repository_url       = (known after apply)
    }

  # aws_ecs_cluster.my_cluster will be created
  + resource "aws_ecs_cluster" "my_cluster" {
      + arn  = (known after apply)
      + id   = (known after apply)
      + name = "my-cluster"

      + setting {
          + name  = (known after apply)
          + value = (known after apply)
        }
    }

  # aws_ecs_service.my_first_service will be created
  + resource "aws_ecs_service" "my_first_service" {
      + cluster                            = (known after apply)
      + deployment_maximum_percent         = 200
      + deployment_minimum_healthy_percent = 100
      + desired_count                      = 3
      + enable_ecs_managed_tags            = false
      + iam_role                           = (known after apply)
      + id                                 = (known after apply)
      + launch_type                        = "FARGATE"
      + name                               = "my-first-service"
      + platform_version                   = (known after apply)
      + scheduling_strategy                = "REPLICA"
      + task_definition                    = (known after apply)

      + load_balancer {
          + container_name   = "my-first-task"
          + container_port   = 3000
          + target_group_arn = (known after apply)
        }

      + network_configuration {
          + assign_public_ip = true
          + security_groups  = (known after apply)
          + subnets          = (known after apply)
        }

      + placement_strategy {
          + field = (known after apply)
          + type  = (known after apply)
        }
    }

  # aws_ecs_task_definition.my_first_task will be created
  + resource "aws_ecs_task_definition" "my_first_task" {
      + arn                      = (known after apply)
      + container_definitions    = (known after apply)
      + cpu                      = "256"
      + execution_role_arn       = (known after apply)
      + family                   = "my-first-task"
      + id                       = (known after apply)
      + memory                   = "512"
      + network_mode             = "awsvpc"
      + requires_compatibilities = [
          + "FARGATE",
        ]
      + revision                 = (known after apply)
    }

  # aws_iam_role.ecsTaskExecutionRole will be created
  + resource "aws_iam_role" "ecsTaskExecutionRole" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "ecs-tasks.amazonaws.com"
                        }
                      + Sid       = ""
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + max_session_duration  = 3600
      + name                  = "ecsTaskExecutionRole"
      + path                  = "/"
      + unique_id             = (known after apply)
    }

  # aws_iam_role_policy_attachment.ecsTaskExecutionRole_policy will be created
  + resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
      + role       = "ecsTaskExecutionRole"
    }

  # aws_lb_listener.listener will be created
  + resource "aws_lb_listener" "listener" {
      + arn               = (known after apply)
      + id                = (known after apply)
      + load_balancer_arn = (known after apply)
      + port              = 80
      + protocol          = "HTTP"
      + ssl_policy        = (known after apply)

      + default_action {
          + order            = (known after apply)
          + target_group_arn = (known after apply)
          + type             = "forward"
        }
    }

  # aws_lb_target_group.target_group will be created
  + resource "aws_lb_target_group" "target_group" {
      + arn                                = (known after apply)
      + arn_suffix                         = (known after apply)
      + deregistration_delay               = 300
      + id                                 = (known after apply)
      + lambda_multi_value_headers_enabled = false
      + load_balancing_algorithm_type      = (known after apply)
      + name                               = "target-group"
      + port                               = 3000
      + protocol                           = "HTTP"
      + proxy_protocol_v2                  = false
      + slow_start                         = 0
      + target_type                        = "ip"
      + vpc_id                             = (known after apply)

      + health_check {
          + enabled             = (known after apply)
          + healthy_threshold   = (known after apply)
          + interval            = (known after apply)
          + matcher             = (known after apply)
          + path                = (known after apply)
          + port                = (known after apply)
          + protocol            = (known after apply)
          + timeout             = (known after apply)
          + unhealthy_threshold = (known after apply)
        }

      + stickiness {
          + cookie_duration = (known after apply)
          + enabled         = (known after apply)
          + type            = (known after apply)
        }
    }

  # aws_security_group.load_balancer_security_group will be created
  + resource "aws_security_group" "load_balancer_security_group" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + vpc_id                 = (known after apply)
    }

  # aws_security_group.service_security_group will be created
  + resource "aws_security_group" "service_security_group" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = []
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = (known after apply)
              + self             = false
              + to_port          = 0
            },
        ]
      + name                   = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + vpc_id                 = (known after apply)
    }

Plan: 15 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_default_subnet.default_subnet_c: Creating...
aws_ecr_repository.my_first_ecr_repo: Creating...
aws_iam_role.ecsTaskExecutionRole: Creating...
aws_default_subnet.default_subnet_b: Creating...
aws_default_subnet.default_subnet_a: Creating...
aws_ecs_cluster.my_cluster: Creating...
aws_default_vpc.default_vpc: Creating...
aws_security_group.load_balancer_security_group: Creating...
aws_default_subnet.default_subnet_b: Creation complete after 2s [id=subnet-3a27e947]
aws_default_subnet.default_subnet_a: Creation complete after 2s [id=subnet-908c1cfb]
aws_default_subnet.default_subnet_c: Creation complete after 2s [id=subnet-3a8dbb76]
aws_iam_role.ecsTaskExecutionRole: Creation complete after 2s [id=ecsTaskExecutionRole]
aws_iam_role_policy_attachment.ecsTaskExecutionRole_policy: Creating...
aws_ecr_repository.my_first_ecr_repo: Creation complete after 3s [id=my-first-ecr-repo]
aws_ecs_task_definition.my_first_task: Creating...
aws_iam_role_policy_attachment.ecsTaskExecutionRole_policy: Creation complete after 2s [id=ecsTaskExecutionRole-20211030014859435100000002]
aws_ecs_task_definition.my_first_task: Creation complete after 2s [id=my-first-task]
aws_security_group.load_balancer_security_group: Creation complete after 9s [id=sg-0768777d477ed794a]
aws_security_group.service_security_group: Creating...
aws_alb.application_load_balancer: Creating...
aws_ecs_cluster.my_cluster: Still creating... [10s elapsed]
aws_default_vpc.default_vpc: Still creating... [10s elapsed]
aws_default_vpc.default_vpc: Creation complete after 12s [id=vpc-6f751d04]
aws_lb_target_group.target_group: Creating...
aws_ecs_cluster.my_cluster: Creation complete after 13s [id=arn:aws:ecs:us-east-2:608290413320:cluster/my-cluster]
aws_lb_target_group.target_group: Creation complete after 6s [id=arn:aws:elasticloadbalancing:us-east-2:608290413320:targetgroup/target-group/33a4c59f293a95e0]
aws_security_group.service_security_group: Creation complete after 9s [id=sg-0d665558dc72b5e62]
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
aws_alb.application_load_balancer: Still creating... [2m20s elapsed]
aws_alb.application_load_balancer: Still creating... [2m30s elapsed]
aws_alb.application_load_balancer: Still creating... [2m40s elapsed]
aws_alb.application_load_balancer: Still creating... [2m50s elapsed]
aws_alb.application_load_balancer: Still creating... [3m0s elapsed]
aws_alb.application_load_balancer: Still creating... [3m10s elapsed]
aws_alb.application_load_balancer: Still creating... [3m20s elapsed]
aws_alb.application_load_balancer: Creation complete after 3m25s [id=arn:aws:elasticloadbalancing:us-east-2:608290413320:loadbalancer/app/test-lb-tf/3897da4049cf2383]
aws_lb_listener.listener: Creating...
aws_lb_listener.listener: Creation complete after 2s [id=arn:aws:elasticloadbalancing:us-east-2:608290413320:listener/app/test-lb-tf/3897da4049cf2383/04d7b746b5216b11]
aws_ecs_service.my_first_service: Creating...
aws_ecs_service.my_first_service: Creation complete after 3s [id=arn:aws:ecs:us-east-2:608290413320:service/my-cluster/my-first-service]

Apply complete! Resources: 15 added, 0 changed, 0 destroyed.
deng@LSOASUS2019:/mnt/c/Users/deng/DTCapstone/terraform/aws$
```
