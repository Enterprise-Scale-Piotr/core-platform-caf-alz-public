# Output a copy of configure_connectivity_resources for use
# by the core module instance

output "configuration" {
  description = "Configuration settings for the \"connectivity\" resources."
  value       = local.configure_connectivity_resources
}

output "subscription_id_connectivity" {
  description = "Subscription ID for the \"connectivity\" resources."
  value       = data.terraform_remote_state.vending.outputs.subscription_id_connectivity
}
