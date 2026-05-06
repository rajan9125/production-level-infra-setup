variable "env" {
    type = string
    default = "dev"
}

variable "location" {
    type = string
}

variable "location_short" {
    type = string
}

variable "tags" {
    type = object({
      team = string
      legal-unit = string
      level = string
    })
}
variable "account_replication_type" {
    type = string
}

variable "account_tier" {
  type = string
}