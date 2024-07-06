resource "aws_launch_template" "ionginx-launch-template" {
    name = var.launch_template_name
    image_id = data.aws_ami.amzlinux2.id
    instance_type = var.instance_type

    vpc_security_group_ids = [aws_security_group.no_access.id]
   
    tag_specifications {
      resource_type = "instance"
      tags = {
        Name = var.instance_name
      }
    }

    user_data = filebase64("${path.module}/nginx.sh")


}

resource "aws_autoscaling_group" "ionginx-autoscaling-group" {
  desired_capacity = 2
  min_size = 2
  max_size = 4
  vpc_zone_identifier = var.vpc_subnet_ids
  launch_template {
    id = aws_launch_template.ionginx-launch-template.id
    version = aws_launch_template.ionginx-launch-template.latest_version
  }
}