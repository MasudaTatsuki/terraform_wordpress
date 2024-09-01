output "security_group_app_id" {
    description = "value"
    value = aws_security_group.app.id
}

output "security_group_db_id" {
    description = "value"
    value = aws_security_group.db.id
}