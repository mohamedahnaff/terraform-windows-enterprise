resource "aws_secretsmanager_secret" "windows_administrator" {
  name = "${var.project_name}/${var.environment}/windows/local-administrator"

  description = "Reserved secret container for governed Windows administrator credentials"

  recovery_window_in_days = var.secret_recovery_window_days

  tags = {
    Name       = "${local.name_prefix}-windows-local-administrator"
    SecretType = "WindowsCredential"
  }

  lifecycle {
    prevent_destroy = true
  }
}
