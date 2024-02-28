logical_product_service = "fwplcyrcoll"
logical_product_family  = "launch"
class_env               = "gotest"
instance_env            = 0
instance_resource       = 0
location                = "eastus2"
//variables for firewall module
logs_destinations_ids = []
subnet_cidr           = "10.0.1.0/24"
//variables for network module
address_space   = ["10.0.0.0/16"]
subnet_prefixes = []
use_for_each    = true
//variables for fw policy rule collection module
priority = 200
# application_rule_collection = [{
#   name     = "App-Coll01"
#   action   = "Allow"
#   priority = 200
#   rule = [{
#     name        = "Allow-Google"
#     description = "Allow Google"
#     protocols = [{
#       port = 8080
#       type = "Http"
#       },
#       {
#         port = 443
#         type = "Https"
#     }]
#     source_addresses  = ["10.0.2.0/24"]
#     destination_fqdns = ["www.google.com"]
#   }]
# }]
# network_rule_collection = [{
#   name     = "Net-Coll01"
#   action   = "Allow"
#   priority = 300
#   rule = [{
#     name                  = "Allow-DNS"
#     description           = "Allow All"
#     protocols             = ["UDP"]
#     source_addresses      = ["10.0.2.0/24"]
#     destination_addresses = ["209.244.0.3", "209.244.0.4"]
#     destination_ports     = ["53"]
#   }]
# }]
