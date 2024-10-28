selected_instance_type = "t4g.nano"
image_id               = "ami-06c57dcdd292ed59e" # Amazon Linux 2

ebs_volume_type = "gp3"
ebs_volume_size = 8

key_name = "ec2-ssh-key-motohashitakeshi"

user_data = <<EOF
#! /bin/bash
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
EOF
