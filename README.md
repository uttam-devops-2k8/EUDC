# GSO Tech Terraform Templates

## Terraform

A basic Terraform template is included, which implements a basic version of the `gso-tech-terraform-modules` repository.

The following arguments may be used inside the `source` variable to target specific tags or revision:

- `ref=feature/locationupdate`
- `ref=refs/tags/0.77.0`

Using the above examples, the `source` field would be constructed in this manner:

`source = "git::git@github.com:RoyalAholdDelhaize/gso-tech-terraform-modules.git//modules/gso-tech?ref=feature/locationupdate"`

or

`source = "git::git@github.com:RoyalAholdDelhaize/gso-tech-terraform-modules.git//modules/gso-tech?ref=refs/tags/0.77.0"`

## GitHub Workflows

The [.github](./.github) folder contains the GitHub Actions for planning and applying Terraform configuration. These refer to the templates inside [RoyalAholdDelhaize/gso-tech-workflows/.github/workflows/](https://github.com/RoyalAholdDelhaize/gso-tech-workflows/.github/workflows/) to function.

These templates cannot run without requesting a GitHub Runner. Please follow the instructions on [Confluence - GitHub: Configure GitHub Runners](https://confluence-aholddelhaize.atlassian.net/wiki/spaces/GC/pages/148620482599/GitHub#Configure-GitHub-Runners) to add your repository to the AH GitHub Runners.

## Configuration

To create a Terraform deployment for a specific environment, please create out a yaml file named `ENV-NAME-HERE.yml` inside the [environments](./environments) folder, named according to a specific environment (e.g. `nonprd.yml`, `prd.yml`). Possible content of the yaml configuration:

**YAML Reference:**

```yaml
common:
  location: "westeurope"
  environment: ""
  service_principal_application_id: ""
  subscription_id: ""
  tenant_id: "a6b169f1-592b-4329-8f33-8db8903003c7"

terraform:
  state:
    resource_group_name: ""
    storage_account_name: ""

resource_group:
  name: ""

resourceTags:
  ApplicationId: ""
  ApplicationName: ""
  ApplicationOwner: "azure-al-gsocf2"
  AutoShutdownSchedule: ""
  FunctionalEnvironment: ""
  Live: "no"
  CloudSupportParty: "TCS GSO Cloud Operations"
  ResourcePurpose: ""
  SCFClassification: "Standard"
  SCFVersion: "2.0"
  SMFVersion: "1.0"
  DefaultAssignmentGroup: ""

vmTags:
  AutomaticBackup: "enabled"

vnet:
  name: ""
  resource_group_name: ""
  subnets:
    subnet:
      name: ""
      address_prefix: ""
      route_table_name: ""
      route_table_rg: ""
      service_endpoints:
        - "Microsoft.Storage"
        - "Microsoft.KeyVault"
        - "Microsoft.AzureActiveDirectory"
        - "Microsoft.Sql"
      nsg:
        inbound_rules:
          - name: "Allow-Bastion"
            access: "Allow"
            priority: 100
            protocol: "Tcp"
            destination_port_ranges:
              - 22
            source_address_prefix: ""
            destination_address_prefix: "*"
          - name: "Allow-PrivateAgent-Gso"
            access: "Allow"
            priority: 110
            protocol: "*"
            destination_port_ranges:
              - 22
              - 443
              - 5985
              - 5986
            source_address_prefix: "10.72.111.144/28"
            destination_address_prefix: "*"
          - name: "Allow-WindowsDC-Any"
            access: "Allow"
            priority: 120
            protocol: "Tcp"
            destination_port_ranges:
              - 53
              - 88
              - 123
              - 135
              - 389
              - 445
              - 464
              - 636
              - 3268
              - 3269
              - 5722
              - 9389
              - "49152-65535"
            source_address_prefixes:
              - "10.232.1.0/28"
              - "10.236.1.0/28"
            destination_address_prefix: "*"
          - name: "Allow-ControlM-ISDIACCSubnet"
            access: "Allow"
            priority: 140
            protocol: "Tcp"
            destination_port_ranges:
              - 7047
            source_address_prefixes:
              - "10.72.70.240/28"
              - "10.73.70.240/28"
            destination_address_prefix: "*"

shared:
  keyvault_name: ""
  keyvault_resource_group_name: ""
  storage_account_name: ""
  storage_account_resource_group_name: ""

central:
  keyvault_name: "kv-gsoservices-prd-01"
  keyvault_resource_group_name: "rg-secrets-prd-weeu-01"
  subscription_id: "cdfcf51c-563d-4bee-a7f5-184bf9d4dcba"

virtual_machines:
  virtual_machine:
    name: ""
    sku: "Standard_D4s_v5"
    subnet_name: ""
    os_storage_account_type: "Premium_ZRS"
    os_caching: "ReadWrite"
    os_disk_size_gb: 127
    timezone: "Europe/Amsterdam"
    availability_zone: "1"
    os: "linux"
    source_image:
      image: "rhel-8.4-cis"
    access_ad_groups:
      - ad_group: "GSP_ADM_TCS_GSOCloudSupport"
        linux_ldap_path: "GSP_ADM_TCS_GSOCloudSupport,ou=TCS,ou=Groups,dc=Emea,dc=Royalahold,dc=net"
        windows_local_group: ""
      - ad_group: "GSP_ADM_GSO_CloudFoundation"
        linux_ldap_path: "GSP_ADM_GSO_CloudFoundation,ou=TCS,ou=Groups,dc=Emea,dc=Royalahold,dc=net"
        windows_local_group: ""
    data_disks:
      - disk_size_gb: 127
        caching: "None"
        storage_account_type: "Premium_ZRS"

keyvaults:
  - name: ""

role_assignments:
  - scope: "/subscriptions/9adb5f05-0ac4-424d-a3ae-610cf456b207/resourceGroups/rg-gso-shared-prd-weeu/providers/Microsoft.KeyVault/vaults/kvgsoservices01prdweeu"
    role_definition_name: "Key Vault Administrator"
    principal_name: spn-gsotech-prd-gsoservices-01-gh
  - scope: "/subscriptions/9adb5f05-0ac4-424d-a3ae-610cf456b207/resourceGroups/rg-gso-shared-prd-weeu"
    role_definition_name: "Reader"
    principal_name: CLD-AlEu-AHNL-Rol-CloudNetworkTeam
  - scope: resource_group
    role_definition_name: "Reader"
    principal_name: CLD-AlEu-AHNL-Rol-CloudNetworkTeam
  - scope: resource_group
    role_definition_name: "Reader"
    principal_name: cld-aleu-gsotech-res-read-rg-gso-biqs-prd-weeu
  - scope: keyvaults.kvbiqsprdweeu
    role_definition_name: "Key Vault Secrets User"
    principal_name: cld-aleu-gsotech-res-kvsu-kvbiqsprdweeu
```
