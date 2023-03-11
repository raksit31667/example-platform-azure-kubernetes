## Tasking

- [x] az ad sp create-for-rbac --role="Owner" --scopes="/subscriptions/<SUBSCRIPTION_ID>" --name="example-platform-azure-kubernetes"
- [x] In Azure AD, add an API permission `Application.ReadWrite.All` from Microsoft Graph
- [x] New Azure service connection -> Azure Resource Manager using service principal (manual)
- [x] Create a new resource group, with storage account
- [x] Create ACR where AKS will pull images from
- [x] Create KeyVault to store AKS credentials
- [x] Create Azure VNet with AKS and Application gateway Subnet
- [x] Create NAT gateway for AKS associated with AKS subnet and public IP
- [x] Create Application gateway for AKS associated with Application gateway subnet and public IP
- [ ] Create DNS with name `raksit31667.me` and A record with Application gateway public IP
