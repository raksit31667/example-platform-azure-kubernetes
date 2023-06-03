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

variable "region_codes" {
  type = set(string)
}

variable "aca_environment_ids" {
  type = map(any)
}

variable "aca_user_identity_ids" {
  type = map(any)
}
