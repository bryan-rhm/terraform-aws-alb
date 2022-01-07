# ------------------------------------------------------------------------
# Amazon Application Load Balancer variables
# ------------------------------------------------------------------------
variable "name" {
  type        = string
  description = "Name of the load balancer"
}

variable "internal_alb" {
  type        = bool
  default     = false
  description = "Defines if the ALB will be internal or external. If internal, it can only use ipv4 as the ip_address_type."
}

variable "loadbalancer_type" {
  type        = string
  default     = "application"
  description = "Defines the type of loadbalancer"
}

variable "enable_deletion_protection" {
  type        = bool
  default     = false
  description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer."
}


variable "drop_invalid_header_fields" {
  type        = bool
  default     = true
  description = "Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false)."
}

variable "enable_cross_zone_load_balancing" {
  type        = bool
  default     = false
  description = "If true, cross-zone load balancing of the load balancer will be enabled. This is a network load balancer feature."
}

variable "security_groups" {
  type        = list(string)
  default     = []
  description = "List of ids for all the security groups that will be assigned to the ALB."
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of ids for all the subnets that will be attached to the ALB. At least two subnets in two different AZs must be specified."
}

variable "idle_timeout" {
  type        = number
  default     = 60
  description = "Sets the time in seconds that the connection is allowed to be idle for the ALB."
}

variable "access_logs_bucket_name" {
  type        = string
  default     = null
  description = "The S3 bucket name to store the logs in."
}

variable "access_logs_prefix" {
  type        = string
  default     = null
  description = "The S3 bucket prefix. Logs are stored in the root if not configured."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "A map of tags to assign to the ALB. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
}

variable "ssl_policy" {
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
  description = "Name of the SSL Policy for the HTTPS listener."
}

variable "ssl_certificate_arn" {
  type        = string
  default     = null 
  description = "ARN of the default SSL server certificate."
}
