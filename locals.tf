locals {
  idle_timeout                     = var.loadbalancer_type == "application" ? var.idle_timeout : null
  security_groups                  = var.loadbalancer_type == "application" ? var.security_groups : null
  drop_invalid_header_fields       = var.loadbalancer_type == "application" ? var.drop_invalid_header_fields : null
  enable_cross_zone_load_balancing = var.loadbalancer_type == "network" ? var.enable_cross_zone_load_balancing : null
}