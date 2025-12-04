resource "aap_inventory" "test_inventory" {
  name         = "TF_TEST_SRW"
  description  = "A new inventory for testing"
  organization = 2
}

resource "aap_group" "test_group" {
  inventory_id = aap_inventory.test_inventory.id
  name         = "var.tags.Role"
}

resource "aap_host" "test_host" {
  for_each = [aws_instance.web_server]
  inventory_id = aap_inventory.test_inventory.id
  name         = "each.value.tags.Name"
  variables = jsonencode(
    {
      "ansible_host" : "each.value.public_ip"
    }
  )
  groups = [aap_group.test_group.id]
}
