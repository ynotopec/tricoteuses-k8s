# Tricoteuses - Kubernetes Deployment

## Architecture

| Service | Description |
|---------|-------------|
| postgres | PostgreSQL 16 - Base de données canutes |
| typesense | Moteur de recherche full-text |
| moulineuse | Serveur MCP Streamable HTTP (port 8000) |
| exploratrice | Interface web SvelteKit (port 3000) |
| registry | Registry Docker privé (optionnel) |

## Déploiement

### 1. Créer le secret

```bash
kubectl create secret generic tricoteuses-secrets \
  --from-literal=POSTGRES_PASSWORD=<password> \
  --from-literal=TYPESENSE_API_KEY=<api_key> \
  --from-literal=OIDC_CLIENT_SECRET=<client_secret> \
  --from-literal=OIDC_SESSION_SECRET=<32-char-secret> \
  --namespace tricoteuses
```

### 2. Déployer

```bash
make deploy
```

### 3. Vérifier

```bash
make status
```

## URLs

- Moulineuse: moulineuse.demo1.ailab.infocepo.com
- Exploratrice: exploratrice.demo1.ailab.infocepo.com
