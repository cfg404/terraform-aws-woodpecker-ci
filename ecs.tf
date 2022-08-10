# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster#argument-reference
resource "aws_ecs_cluster" "this" {

  name = var.name

  dynamic "configuration" {
    for_each = try([var.cluster_configuration], [])

    content {
      dynamic "execute_command_configuration" {
        for_each = try([configuration.value.execute_command_configuration], [{}])

        content {
          kms_key_id = try(execute_command_configuration.value.kms_key_id, null)
          logging    = try(execute_command_configuration.value.logging, "DEFAULT")

          dynamic "log_configuration" {
            for_each = try([execute_command_configuration.value.log_configuration], [])

            content {
              cloud_watch_encryption_enabled = try(log_configuration.value.cloud_watch_encryption_enabled, null)
              cloud_watch_log_group_name     = try(log_configuration.value.cloud_watch_log_group_name, null)
              s3_bucket_name                 = try(log_configuration.value.s3_bucket_name, null)
              s3_bucket_encryption_enabled   = try(log_configuration.value.s3_bucket_encryption_enabled, null)
              s3_key_prefix                  = try(log_configuration.value.s3_key_prefix, null)
            }
          }
        }
      }
    }
  }

  dynamic "setting" {
    for_each = var.cluster_settings != null ? var.cluster_settings : {}

    content {
      name  = setting.value.name
      value = setting.value.value
    }
  }

  tags = var.tags != {} ? var.tags : {}
}
