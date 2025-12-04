data "aap_job_template" "deploy_webserver" {
  name              = "DEPLOY_WEBSERVER_SRW"
  organization_name = var.organization_name
}

data "aap_job_template" "deploy_website" {
  name              = "DEPLOY_WEBSITE_SRW"
  organization_name = var.organization_name
}

resource "aap_job" "deploy_webserver_job" {
  job_template_id = data.aap_job_template.deploy_webserver.id
  inventory_id    = aap_inventory.srw_inventory.id
  wait_for_completion = true
  wait_for_completion_timeout_seconds = 180

  depends_on = [
    aap_host.test_host,
    aap_group.test_group
  ]
}

resource "aap_job" "deploy_website_job" {
  job_template_id = data.aap_job_template.deploy_website.id
  inventory_id    = aap_inventory.srw_inventory.id
  wait_for_completion = true
  wait_for_completion_timeout_seconds = 180

  depends_on = [
    aap_job.deploy_webserver_job
  ]
}
