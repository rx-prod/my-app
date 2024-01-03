# Bootstrap ArgoCD

## local install
- helm
- docker desktop with kubernetes
- terraform

## helm

- `helm repo add argo https://argoproj.github.io/argo-helm`
- `helm repo update`
- `helm search repo argo-cd`
- `helm list -A`

# terraform
- `terraform apply`
- `kubectl get pods -n argocd`

## get admin pw for argocd (optional)
- `kubectl get secrets argocd-initial-admin-secret -o yaml -n argocd`
- `[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("xxx=="))`

# finalize argocd install and test login
- `kubectl port-forward svc/argocd-server -n argocd 8080:80`
- open `http://localhost:8080/` -> username: `admin` / pw: value from `argocd-initial-admin-secret`

## docker
- `docker login`
- `docker pull nginx:1.23.3`
- `docker tag nginx:1.23.3 samikoskivaara/nginx:v0.1.0`
- `docker push samikoskivaara/nginx:v0.1.0`

![image](https://github.com/rx-prod/my-app/assets/10957012/930cc97a-11de-4893-9eb6-562729392dca)
