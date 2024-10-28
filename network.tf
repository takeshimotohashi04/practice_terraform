#----------------------------------------
# VPCの作成
#----------------------------------------
resource "aws_vpc" "primary" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}
#----------------------------------------
# パブリックサブネットの作成
#----------------------------------------
resource "aws_subnet" "primary" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "primary" {
  vpc_id = aws_vpc.primary.id
}

#----------------------------------------
# ルートテーブルの作成
#----------------------------------------
resource "aws_route_table" "primary" {
  vpc_id = aws_vpc.primary.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primary.id
  }
}

# サブネットにルートテーブルを紐づけ
resource "aws_route_table_association" "primary" {
  subnet_id      = aws_subnet.primary.id
  route_table_id = aws_route_table.primary.id
}

#----------------------------------------
# セキュリティグループの作成
#----------------------------------------
resource "aws_security_group" "primary" {
  name   = "primary"
  vpc_id = aws_vpc.primary.id
  ingress {
    description = "HTTP from Office"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["221.188.18.250/32"]
  }
  ingress {
    description = "HTTP from Office"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["221.188.18.250/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}