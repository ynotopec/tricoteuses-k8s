# Secrets - Documentation

## Ne JAMAIS commité de vrais secrets

Les secrets doivent être créés manuellement via kubectl :

```bash
# PostgreSQL & Typesense
kubectl create secret generic tricoteuses-secrets \
  --namespace tricoteuses \
  --from-literal=POSTGRES_PASSWORD='<mot-de-postgres>' \
  --from-literal=TYPESENSE_API_KEY='<cle-api-typesense>' \
  --from-literal=OIDC_CLIENT_SECRET='<secret-oidc-client>' \
  --from-literal=OIDC_SESSION_SECRET='<secret-session-32-cars>'

# Optionnel: Grist si utilisé
kubectl create secret generic tricoteuses-secrets \
  --namespace tricoteuses \
  --from-literal=GRIST_API_KEY='<cle-api-grist>' \
  --from-literal=GRIST_DOC_ID='<id-document-grist>' \
  --dry-run=client -o yaml >> tricoteuses-secrets.yaml
```

## Vérification

```bash
kubectl get secret tricoteuses-secrets -n tricoteuses -o jsonpath='{.data}' | python3 -m json.tool
```

## Rotation

```bash
kubectl create secret generic tricoteuses-secrets \
  --namespace tricoteuses \
  --from-literal=POSTGRES_PASSWORD='<new-password>' \
  --from-literal=TYPESENSE_API_KEY='<new-api-key>' \
  --from-literal=OIDC_CLIENT_SECRET='<new-client-secret>' \
  --from-literal=OIDC_SESSION_SECRET='<new-session-secret>'
```
