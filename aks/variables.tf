variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "resource_group_id" {
  type = string
}

variable "aks_name" {
  type = string
}

variable "kubenetes_version" {
  type    = string
  default = "1.24.6"
}

variable "acr_id" {
  type = string
}
