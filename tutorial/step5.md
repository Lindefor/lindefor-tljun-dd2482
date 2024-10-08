### Implementing RBAC in Kubernetes

We have now got Minikube running with Kubernetes and successfully scaled up our application. Our next goal is to set up our developer environment for different roles in our team, and we can do this using RBAC. To set up Role-Based Access Control (RBAC) in Kubernetes, we’ll create roles with specific permissions for different team members. RBAC allows you to define fine-grained access control over resources within the cluster, ensuring each role has only the permissions necessary for their specific responsibilities. This is especially useful in a team environment where different roles (e.g., developer, admin, QA) may need different levels of access.

It’s good practice to create a dedicated namespace for your application’s development environment:

```bash
kubectl create namespace dev
```

This isolates resources and permissions for the development environment, which is helpful when applying RBAC.
Step 3: Define Roles for Different Team Members

For this tutorial, let’s define two roles within the dev namespace:

Developer Role: This role has permissions to manage pods, services, and deployments within the dev namespace.
Viewer Role: This role has read-only permissions, allowing team members to view resources but not make changes.

Create a YAML file named developer-role.yaml:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: dev
  name: developer
rules:
- apiGroups: ["", "apps", "extensions"]
  resources: ["pods", "services", "deployments"]
  verbs: ["get", "list", "watch", "create", "update", "delete"]
```

Create another YAML file named viewer-role.yaml:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: dev
  name: viewer
rules:
- apiGroups: ["", "apps", "extensions"]
  resources: ["pods", "services", "deployments"]
  verbs: ["get", "list", "watch"]
```

Apply the roles to the dev namespace:

```bash
kubectl apply -f developer-role.yaml
kubectl apply -f viewer-role.yaml
```

Now that we have defined the roles, let’s assign these roles to specific service accounts.
Let's start with creating these service accounts.

```bash
kubectl create serviceaccount dev-user -n dev
kubectl create serviceaccount view-user -n dev
```

These accounts can be used in your organization to apply to the people who need specific access. Also remember to apply the principle of least privilege, which says that no one person should get more privilige than they need to perform their duty.

Lets create these role bindings.
Create a YAML file named developer-binding.yaml:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: developer-binding
  namespace: dev
subjects:
- kind: ServiceAccount
  name: dev-user       
  namespace: dev
roleRef:
  kind: Role
  name: developer
  apiGroup: rbac.authorization.k8s.io
```

Similarly, create a YAML file named viewer-binding.yaml:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: viewer-binding
  namespace: dev
subjects:
- kind: ServiceAccount
  name: view-user  
  namespace: dev
roleRef:
  kind: Role
  name: viewer
  apiGroup: rbac.authorization.k8s.io
```

Assign these roles to users in the dev namespace by applying the RoleBindings:

```bash
kubectl apply -f developer-binding.yaml
kubectl apply -f viewer-binding.yaml
```

We have now created a viewer role for view-user and a developer role for dev-user! If we would log in as these users we could now see that dev can attempt to create, update, or delete resources within the dev namespace, while view-user can only view resources but not make changes.

Let's verify this with these commands:

```bash
#Verify dev-user
kubectl auth can-i create pods --namespace=dev --as=dev-user
kubectl auth can-i update deployments --namespace=dev --as=dev-user
kubectl auth can-i delete services --namespace=dev --as=dev-user
```

```bash
#Verify view-user
kubectl auth can-i get pods --namespace=dev --as=view-user
kubectl auth can-i list services --namespace=dev --as=view-user
kubectl auth can-i delete deployments --namespace=dev --as=view-user
```

If these run correctly then we have successfully set up role bindings in our Kubernetes environment! Good job!