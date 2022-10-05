data "aws_iam_instance_profile" "ecs_profile" {
  name = var.iam_role_name
}

# data "template_file" "container_definitions" {
#   template = file("${path.module}/container_def.json")
#   vars = local.container_inputs
# }

data "template_file" "file" {
  template = file("${path.module}/index.html")
}
data "template_cloudinit_config" "ecs_data" {
  gzip          = false
  base64_encode = false
  #first part of local config file
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y ecs-init
    sudo service docker start
    sudo start ecs
    echo 'ECS_CLUSTER=${var.cluster_name}' >> /etc/ecs/ecs.config
    echo 'ECS_DISABLE_PRIVILEGED=true' >> /etc/ecs/ecs.config
    mkdir /home/ec2-user/html
    EOF
  }
  #second part
  part {
    content_type = "text/cloud-config"
    filename     = "index.html"
    content      = local.cloud_config_config
  }
}