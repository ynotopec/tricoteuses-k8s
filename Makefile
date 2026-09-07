NAMESPACE := tricoteuses
CLUSTER := demo1

.PHONY: deploy destroy status

deploy:
	@echo "Deploying tricoteuses stack to namespace $(NAMESPACE)..."
	@kubectl apply -f k8s/00-namespace.yaml
	@kubectl apply -f k8s/01-secrets.yaml --namespace $(NAMESPACE)
	@kubectl apply -f k8s/02-config.yaml --namespace $(NAMESPACE)
	@kubectl apply -f k8s/03-postgres.yaml --namespace $(NAMESPACE)
	@kubectl apply -f k8s/04-typesense.yaml --namespace $(NAMESPACE)
	@kubectl apply -f k8s/05-moulineuse.yaml --namespace $(NAMESPACE)
	@kubectl apply -f k8s/06-exploratrice.yaml --namespace $(NAMESPACE)
	@kubectl apply -f k8s/07-ingress-moulineuse.yaml --namespace $(NAMESPACE)
	@kubectl apply -f k8s/08-ingress-exploratrice.yaml --namespace $(NAMESPACE)
	@echo "Deployment complete. Status:"
	@kubectl -n $(NAMESPACE) get pods

status:
	@kubectl -n $(NAMESPACE) get pods
	@kubectl -n $(NAMESPACE) get ingress

destroy:
	@kubectl delete -f k8s/08-ingress-exploratrice.yaml --namespace $(NAMESPACE)
	@kubectl delete -f k8s/07-ingress-moulineuse.yaml --namespace $(NAMESPACE)
	@kubectl delete -f k8s/06-exploratrice.yaml --namespace $(NAMESPACE)
	@kubectl delete -f k8s/05-moulineuse.yaml --namespace $(NAMESPACE)
	@kubectl delete -f k8s/04-typesense.yaml --namespace $(NAMESPACE)
	@kubectl delete -f k8s/03-postgres.yaml --namespace $(NAMESPACE)
	@kubectl delete -f k8s/02-config.yaml --namespace $(NAMESPACE)
	@kubectl delete -f k8s/01-secrets.yaml --namespace $(NAMESPACE)
	@kubectl delete namespace $(NAMESPACE) --ignore-not-found=true

init-secrets:
	@echo "Creating secrets for namespace $(NAMESPACE)..."
	@echo "Replace PASSWORD, API_KEY, CLIENT_SECRET, SESSION_SECRET placeholders with real values:"
	@echo ""
	@echo "  kubectl create secret generic tricoteuses-secrets \\"
	@echo "    --from-literal=POSTGRES_PASSWORD=your_password \\"
	@echo "    --from-literal=TYPESENSE_API_KEY=your_api_key \\"
	@echo "    --from-literal=OIDC_CLIENT_SECRET=your_client_secret \\"
	@echo "    --from-literal=OIDC_SESSION_SECRET=your_session_secret \\"
	@echo "    --namespace $(NAMESPACE)"
