package common

import (
	"context"
	"testing"

	internalNetwork "github.com/Azure/azure-sdk-for-go/profiles/latest/network/mgmt/network"
	"github.com/Azure/go-autorest/autorest"
	"github.com/Azure/go-autorest/autorest/adal"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/nexient-llc/lcaf-component-terratest-common/lib/azure/configure"
	"github.com/nexient-llc/lcaf-component-terratest-common/lib/azure/login"
	"github.com/nexient-llc/lcaf-component-terratest-common/types"
	"github.com/stretchr/testify/assert"
)

const terraformDir string = "../../examples/fw_policy_rule_coll_grp"
const varFile string = "test.tfvars"

func TestFirewall(t *testing.T, ctx types.TestContext) {

	envVarMap := login.GetEnvironmentVariables()
	clientID := envVarMap["clientID"]
	clientSecret := envVarMap["clientSecret"]
	tenantID := envVarMap["tenantID"]
	subscriptionID := envVarMap["subscriptionID"]

	spt, err := login.GetServicePrincipalToken(clientID, clientSecret, tenantID)
	if err != nil {
		t.Fatalf("Error getting Service Principal Token: %v", err)
	}

	firewallPolicyRuleCollectionGroupsClient := GetFirewallPolicyRuleCollectionGroupsClient(spt, subscriptionID)

	terraformOptions := configure.ConfigureTerraform(terraformDir, []string{terraformDir + "/" + varFile})

	firewallIds := terraform.OutputMap(t, ctx.TerratestTerraformOptions(), "firewall_ids")
	for range firewallIds {
		t.Run("doesFwPolicyRuleCollGrpExist", func(t *testing.T) {
			resourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")
			policyName := terraform.Output(t, terraformOptions, "policy_name")
			policyRuleCollectionGroupName := terraform.Output(t, terraformOptions, "policy_rule_collection_group_name")

			prcg, err := firewallPolicyRuleCollectionGroupsClient.Get(context.Background(), resourceGroupName, policyName, policyRuleCollectionGroupName)
			if err != nil {
				t.Fatalf("Error getting policy rule collection group: %v", err)
			}

			assert.Equal(t, policyRuleCollectionGroupName, *prcg.Name)
		})
	}
}

func GetFirewallPolicyRuleCollectionGroupsClient(spt *adal.ServicePrincipalToken, subscriptionID string) internalNetwork.FirewallPolicyRuleCollectionGroupsClient {
	firewallPolicyRuleCollectionGroupsClient := internalNetwork.NewFirewallPolicyRuleCollectionGroupsClient(subscriptionID)
	firewallPolicyRuleCollectionGroupsClient.Authorizer = autorest.NewBearerAuthorizer(spt)
	return firewallPolicyRuleCollectionGroupsClient
}
