// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

resource "azurerm_firewall_policy_rule_collection_group" "policy_rule_collection_group" {
  name               = var.name
  firewall_policy_id = var.firewall_policy_id
  priority           = var.priority

  dynamic "application_rule_collection" {
    for_each = var.application_rule_collection != null ? var.application_rule_collection : []
    content {
      name     = application_rule_collection.value.name
      action   = application_rule_collection.value.action
      priority = application_rule_collection.value.priority

      dynamic "rule" {
        for_each = application_rule_collection.value.rule != null ? application_rule_collection.value.rule : []
        content {
          name        = rule.value.name
          description = rule.value.description

          dynamic "protocols" {
            for_each = rule.value.protocols != null ? rule.value.protocols : []
            content {
              type = protocols.value.type
              port = protocols.value.port
            }
          }

          source_addresses      = rule.value.source_addresses
          source_ip_groups      = rule.value.source_ip_groups
          destination_addresses = rule.value.destination_addresses
          destination_urls      = rule.value.destination_urls
          destination_fqdns     = rule.value.destination_fqdns
          destination_fqdn_tags = rule.value.destination_fqdn_tags
          terminate_tls         = rule.value.terminate_tls
          web_categories        = rule.value.web_categories
        }
      }
    }
  }

  dynamic "network_rule_collection" {
    for_each = var.network_rule_collection != null ? var.network_rule_collection : []
    content {
      name     = network_rule_collection.value.name
      action   = network_rule_collection.value.action
      priority = network_rule_collection.value.priority

      dynamic "rule" {
        for_each = network_rule_collection.value.rule != null ? network_rule_collection.value.rule : []
        content {
          name                  = rule.value.name
          description           = rule.value.description
          protocols             = rule.value.protocols
          destination_ports     = rule.value.destination_ports
          source_addresses      = rule.value.source_addresses
          source_ip_groups      = rule.value.source_ip_groups
          destination_addresses = rule.value.destination_addresses
          destination_fqdns     = rule.value.destination_fqdns
        }
      }
    }
  }

  dynamic "nat_rule_collection" {
    for_each = var.nat_rule_collection != null ? var.nat_rule_collection : []
    content {
      name     = nat_rule_collection.value.name
      action   = nat_rule_collection.value.action
      priority = nat_rule_collection.value.priority

      dynamic "rule" {
        for_each = nat_rule_collection.value.rule != null ? nat_rule_collection.value.rule : []
        content {
          name                = rule.value.name
          description         = rule.value.description
          protocols           = rule.value.protocols
          source_addresses    = rule.value.source_addresses
          source_ip_groups    = rule.value.source_ip_groups
          destination_address = rule.value.destination_address
          destination_ports   = rule.value.destination_ports
          translated_address  = rule.value.translated_address
          translated_port     = rule.value.translated_port
          translated_fqdn     = rule.value.translated_fqdn
        }
      }
    }
  }

}
