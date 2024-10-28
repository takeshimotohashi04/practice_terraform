#----------------------------------------
# EC2インスタンスの作成
#----------------------------------------
resource "aws_instance" "primary" {
  ami                    = var.image_id
  instance_type          = var.selected_instance_type
  subnet_id              = aws_subnet.primary.id
  vpc_security_group_ids = [aws_security_group.primary.id]
  key_name               = var.key_name
  root_block_device {
    volume_type           = var.ebs_volume_type
    volume_size           = var.ebs_volume_size
    delete_on_termination = true
  }
  user_data = var.user_data
}