resource "aws_instance" "name" {
  count                  = var.instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids
  subnet_id              = var.subnet_ids[count.index % length(var.subnet_ids)]

  tags = {
    Name        = "${var.environment}-${var.project_name}-${count.index + 1}"
    Environment = var.environment
  }
}
