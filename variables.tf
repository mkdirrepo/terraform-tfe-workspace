variable "agent_pool_id" {
  default     = null
  type        = string
}

variable "allow_destroy_plan" {
  default     = false
  type        = bool
}

variable "assessments_enabled" {
  default     = false
  type        = bool
}

variable "auto_apply" {
  default     = false
  type        = bool
}

variable "description" {
  type        = string
}

variable "execution_mode" {
  default     = "remote"
  type        = string
}

variable "name" {
  type        = string
}

variable "organization_name" {
  type        = string
}

variable "project_id" {
  type        = string
}

variable "run_trigger_workspace_ids" {
  default     = []
  type        = list(string)
}

variable "tags" {
  default     = []
  type        = list(string)
}

variable "variable_set_ids" {
  default     = []
  type        = list(string)
}

variable "variables" {
  default     = []
  type = list(object({
    category    = string
    description = optional(string)
    hcl         = optional(bool)
    key         = string
    sensitive   = optional(bool)
    value       = string
  }))
}

variable "vcs_repo" {
  default     = null
  type = object({
    github_app_installation_id = string
    identifier                 = string
  })
}