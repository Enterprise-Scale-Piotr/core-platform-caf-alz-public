# Use variables to customize the deployment

variable "root_id" {
  type        = string
  description = "Sets the value used for generating unique resource naming within the module."
  default     = "plzdev"
}

variable "primary_location" {
  type        = string
  description = "Sets the location for \"primary\" resources to be created in."
  default     = "westeurope"
}
/*
variable "subscription_id_management" {
  type        = string
  description = "Subscription ID to use for \"management\" resources."
}
*/
variable "email_security_contact" {
  type        = string
  description = "Set a custom value for the security contact email address."
  default     = "stanley.xie@ottogroup.com"
}

variable "log_retention_in_days" {
  type        = number
  description = "Set a custom value for how many days to store logs in the Log Analytics workspace."
  default     = 30
}

variable "management_resources_tags" {
  type        = map(string)
  description = "Specify tags to add to \"management\" resources."
  default = {
    deployedBy = "plz_management"
  }
}
