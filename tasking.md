## Tasking

- [x] az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>" --name="example-platform-azure-kubernetes"
- [x] In Azure AD, add an API permission `Application.ReadWrite.All` from Microsoft Graph
- [x] New Azure service connection -> Azure Resource Manager using service principal (manual)
- [x] Create a new resource group, with storage account
- [x] Create ACR where AKS will pull images from
- [ ] Create KeyVault to store AKS credentials
