data "tfe_organization" "org" {
  name = var.organization_name
}
resource "tfe_workspace" "workspace" {
  agent_pool_id       = var.agent_pool_id
  allow_destroy_plan  = var.allow_destroy_plan
  assessments_enabled = var.assessments_enabled
  auto_apply          = var.auto_apply
  description         = var.description
  execution_mode      = var.execution_mode
  name                = var.name
  organization        = data.tfe_organization.org.name
  project_id          = var.project_id
  tag_names           = var.tags

  dynamic "vcs_repo" {
    for_each = var.vcs_repo != null ? [1] : []

    content {
      identifier                 = var.vcs_repo.identifier
      github_app_installation_id = var.vcs_repo.github_app_installation_id
    }
  }
}


resource "tfe_variable" "var" {
  for_each = { for v in var.variables : v.key => v }

  category     = each.value.category
  description  = each.value.description
  hcl          = each.value.hcl
  key          = each.value.key
  sensitive    = each.value.sensitive
  value        = each.value.value
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_workspace_variable_set" "varset" {
  for_each = toset(var.variable_set_ids)

  variable_set_id = each.key
  workspace_id    = tfe_workspace.workspace.id
}

resource "tfe_run_trigger" "rt" {
  for_each = toset(var.run_trigger_workspace_ids)

  sourceable_id = each.key
  workspace_id  = tfe_workspace.workspace.id
}