resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name 
  
  provisioner "local-exec" {
    when    = destroy
   # command = "${path.module}/destroy.sh"
     command = "AWS_ECS_CONTAINER_INSTANCE_ARN=$(aws ecs list-container-instances --cluster ${self.name} --query 'containerInstanceArns' --output text) && aws ecs deregister-container-instance --cluster ${self.name} --container-instance $AWS_ECS_CONTAINER_INSTANCE_ARN --force"
}

}
resource "aws_cloudwatch_log_group" "log_group" {
  name = "${aws_ecs_cluster.cluster.name}-logs"    
}


output "ecs_cluster_output" {
    value = aws_ecs_cluster.cluster
  }
