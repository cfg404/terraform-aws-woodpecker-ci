variable "name" {
  default     = "woodpecker-ci"
  type        = string
  description = "The name used for the ECS cluster as well for the ECS task definition"
}

variable "cluster_configuration" {
  default     = [{}]
  type        = list(map(any))
  description = "A list of maps containing data used for logging configuration"
}

variable "cluster_settings" {
  default     = {}
  type        = map(any)
  description = "A map containing data used for the ECS cluster configuration"
}

variable "tags" {
  default     = {}
  type        = map(any)
  description = "A map containing all the tags that will be applied to the ECS cluster"
}
