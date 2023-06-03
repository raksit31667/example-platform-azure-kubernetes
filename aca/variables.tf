variable "resource_groups" {
  type = list(object({
    location            = string
    resource_group_name = string
    region_code         = string
  }))
}

variable "acr_id" {
  type = string
}
