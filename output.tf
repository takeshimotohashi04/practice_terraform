# 作成したEC2のパブリックIPアドレスを出力
output "web_global_ips" {
  description = "Public IP of the web instance"
  value       = aws_instance.primary.*.public_ip
}