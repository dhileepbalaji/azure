locals {
    resource_group_name = var.resource_group_name
    location            = var.location
    if_extended_auditing_policy_enabled = var.enable_auditing_policy ? [{}] : []

}
