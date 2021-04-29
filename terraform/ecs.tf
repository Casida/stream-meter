resource "aws_ecs_cluster" "smeter" {
  name = "smeter"
}

resource "aws_ecs_task_definition" "smeter-deploy" {
  family                   = "smeter-deploy"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "smeter-deploy",
      "image": "${aws_ecr_repository.stream-meter.repository_url}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 8080,
          "hostPort": 8080
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRole.arn}"
}

resource "aws_ecs_service" "smeter_service" {
  name            = "smeter-service"
  cluster         = "${aws_ecs_cluster.smeter.id}"
  task_definition = "${aws_ecs_task_definition.smeter-deploy.arn}"
  launch_type     = "FARGATE"
  desired_count   = 3

  load_balancer {
    target_group_arn = "${aws_lb_target_group.target_group.arn}"
    container_name   = "${aws_ecs_task_definition.smeter-deploy.family}"
    container_port   = 8080
  }

  network_configuration {
    subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}", "${aws_default_subnet.default_subnet_c.id}"]
    assign_public_ip = true
    security_groups  = ["${aws_security_group.service_security_group.id}"]
  }
}