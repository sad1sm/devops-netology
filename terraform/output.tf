output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "aws_region" {
  value = data.aws_region.current.name
}

output "private_ip" {
  value = aws_network_interface.ubuntu_ni.private_ips
}

output "subnet" {
  value = aws_subnet.ubuntu_subnet.cidr_block
}
