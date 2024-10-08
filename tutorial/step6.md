### Using Kubernetes Secrets
In this final step of the tutorial, we will learn how to set up and access secrets withinn Kubernetes. Secrets are used by Kubernetes to store sensitive data such as passwords. By using Kubernetes secrets, we can ensure that sensitive information is not exposed to unauthorized users.

Assume we have a database password `mysecretpassword` that we want to store securely. Let's store it using Kubernetes:
```bash
kubectl create secret generic db-password --from-literal=password=mysecretpassword
```
To verify that the secret has been created, run:
```bash
kubectl get secrets
```
Perfect! Now, we must update our deployment to include this secret. Please update the deployment.yaml to include the secret:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: express-app-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: express-app
  template:
    metadata:
      labels:
        app: express-app
    spec:
      containers:
        - name: express-app
          image: express-app:latest
          imagePullPolicy: Never
          ports:
            - containerPort: 3000
          env:
            - name: DB_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: db-password
                  key: password
```

Now, let's apply the changes:
```bash
kubectl apply -f deployment.yaml
``` 

The last step is to rebuild the application and see the new functionality in action. Run:
```bash
eval $(minikube docker-env)
docker build -t express-app:latest .
```

In order to test that our application is able to access the secret, we will now perform a not-so-secure operation. We will print the password when users access the webpage, solely to demonstrate that it works. The application contains another endpoint, `/db_pass`, which will return the password:
```bash
curl $(minikube service express-app-deployment --url)/db_pass
```

Did you see the password? If so, congratulations! You have successfully set up and accessed secrets within Kubernetes. And with that, you have completed the tutorial. Great job! 🎉