variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "project_name_prefix" {
  type        = string
  default     = "tsgweb"
  description = "Short 6-letter name for the project."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable scfile{
    type = string
    default = "config.bash"
}