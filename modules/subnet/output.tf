output "public_subnet_a_id" {
    description = "value"
    value = aws_subnet.public-a.id
}

output "public_subnet_c_id" {
    description = "value"
    value = aws_subnet.public-c.id
}

output "db_subnet_group_name" {
    description = "value"
    value = aws_db_subnet_group.db-subnet.name
}