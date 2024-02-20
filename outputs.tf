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

output "firewall_policy_rule_collection_group_name" {
  value       = var.name
  description = "value of the Azure Firewall policy rule collection group name"
}

output "firewall_policy_rule_collection_group_id" {
  value       = azurerm_firewall_policy_rule_collection_group.policy_rule_collection_group.id
  description = "The ID of the Firewall Policy Rule Collection Group."
}
