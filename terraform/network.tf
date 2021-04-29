resource "aws_default_vpc" "default_vpc" {
}

resource "aws_default_subnet" "default_subnet_a" {
  availability_zone = "us-east-2a"
}

resource "aws_default_subnet" "default_subnet_b" {
  availability_zone = "us-east-2b"
}

resource "aws_default_subnet" "default_subnet_c" {
  availability_zone = "us-east-2c"
}

resource "aws_ecs_service" "stream-meter-svc" {
  name            = "stream-meter-svc"
  cluster         = "${aws_ecs_cluster.smeter.id}"
  task_definition = "${aws_ecs_task_definition.smeter-deploy.arn}"
  launch_type     = "FARGATE"
  desired_count   = 3

  network_configuration {
    subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}", "${aws_default_subnet.default_subnet_c.id}"]
    assign_public_ip = true
  }
}
