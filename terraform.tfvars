selected_instance_type = "t4g.nano"
image_id               = "ami-06c57dcdd292ed59e" # Amazon Linux 2

root_volume_type = "gp3"
root_volume_size = 8

ebs_volumes = [
  {
    device_name           = "/dev/sdb"
    volume_type           = "gp2"
    volume_size           = 20
    delete_on_termination = true
  },
  {
    device_name           = "/dev/sdc"
    volume_type           = "gp2"
    volume_size           = 50
    delete_on_termination = false
  }
]

key_name = "ec2-ssh-key-motohashitakeshi"

user_data = <<EOF
#! /bin/bash
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
EOF



ingress_rules = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["14.8.1.130/32"]
  },
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]