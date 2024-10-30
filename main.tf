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
    volume_type           = var.root_volume_type
    volume_size           = var.root_volume_size
    delete_on_termination = true
  }
  user_data = jsonencode(var.user_data)

  dynamic "ebs_block_device" {
    for_each = var.ebs_volumes
    content {
      device_name           = ebs_block_device.value["device_name"]
      volume_type           = ebs_block_device.value["volume_type"]
      volume_size           = ebs_block_device.value["volume_size"]
      delete_on_termination = ebs_block_device.value["delete_on_termination"]
    }
  }
}


