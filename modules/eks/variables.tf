variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "web_subnet_ids" {
  description = "Web subnet IDs"
  type        = list(string)
}

variable "app_subnet_ids" {
  description = "App subnet IDs"
  type        = list(string)
}

variable "desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "min_capacity" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 3
}

variable "instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t2.small"
}
