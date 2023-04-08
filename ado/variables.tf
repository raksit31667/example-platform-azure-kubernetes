variable "ado_pat_secret" {
  type      = string
  sensitive = true
}

variable "resource_group_name" {
  type = string
}

variable "acr_name" {
  type = string
}

variable "aca_environment_id" {
  type = string
}

variable "aca_user_identity_id" {
  type = string
}
