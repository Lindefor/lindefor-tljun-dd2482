### Using Kubernetes Secrets
In this final step of the tutorial, we will learn how to set up and access secrets withinn Kubernetes. Secrets are used by Kubernetes to store sensitive data such as passwords. By using Kubernetes secrets, we can ensure that sensitive information is not exposed to unauthorized users.

Assume we have a database password `mysecretpassword` that we want to store securely. Let's store it using Kubernetes:
```bash
kubectl create secret generic db-password --from-literal=password=mysecretpassword -n dev
```
To verify that the secret has been created, run:
```bash
kubectl get secrets -n dev
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

In order to test that our application is able to access the secret, we will now perform a not-so-secure operation. We will print the password when users access the webpage, solely to demonstrate that it works. Please update the `app.mjs` file message to the following :
```javascript
app.get('/', (req, res) => {
  res.send(`Hello World! The database password is: ${process.env.DB_PASSWORD}`);
});
```

The last step is to rebuild the application and see the new functionality in action. Run:
```bash
eval $(minikube docker-env)
docker build -t express-app:latest .
```

Now, let's test the application by running:
```bash
curl $(minikube service express-app-deployment --url)
```

Now curl the /db_pass endpoint to see the password:
```bash
curl $(minikube service express-app-deployment --url)/db_pass
```

Did you see the password? If so, congratulations! You have successfully set up and accessed secrets within Kubernetes. And with that, you have completed the tutorial. Great job! 🎉