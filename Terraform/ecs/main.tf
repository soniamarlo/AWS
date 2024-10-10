resource "aws_ecs_cluster" "nginx_cluster-sonia" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "nginx_task-sonia" {
  family                   = "nginx-task"
  container_definitions    = jsonencode([{
    name      = "nginx"
    image     = "nginx:latest"
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role-sonia.arn
}

resource "aws_ecs_service" "nginx_service-sonia" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.nginx_cluster-sonia.id
  task_definition = aws_ecs_task_definition.nginx_task-sonia.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = data.aws_subnets.default.ids   
    security_groups = ["sg-0700c3f20bebd1fa9"]
    assign_public_ip = true       
  }

  load_balancer {
    target_group_arn = "arn:aws:elasticloadbalancing:eu-west-1:921108067704:targetgroup/nginx-alb-dev-sonia-tg/b0ab9fc4b76af9fe"     
    container_name   = "nginx"
    container_port   = 80
  }
}

resource "aws_iam_role" "ecs_task_execution_role-sonia" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy-sonia" {
  role       = aws_iam_role.ecs_task_execution_role-sonia.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
