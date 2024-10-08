### Deploying with Kubernetes

In this step we want to set up the environment to scale our application. 
We will use Minikube to create a local Kubernetes cluster, which allows us to test Kubernetes deployments in our development environment. Kubernetes is widely used for container orchestration, and it makes it easier to scale, manage, and deploy applications. These steps demonstrate how to deploy and expose a simple Node.js application using Minikube, simulating a real production environment.

Before we do anything we need to remove our Docker build so that it is not hogging our resources:
```bash
docker stop express-app
docker rm express-app
```
Minikube is already started but let us check our Kubernetes cluster info to verify that it is running. Run
```bash
kubectl cluster-info
```
If CoreDNS and Kubernetes control plane is running then we are good. Otherwise run
````bash
minikube start
````
Minikube simulates a cloud environment, which allows us to explore Kubernetes features like deployment and scaling without needing a remote cluster.

We now want to build and tag our already made docker image. Run:
```bash
eval $(minikube docker-env) #To connect minikube to the docker environment
docker build -t express-app:latest . #To build our docker image
```

We have now configured Docker to use Minikube's Docker daemon, which means the Docker image is built within Minikube. This avoids the need to push the image to a remote repository.

Finally we need to configure our Kubernetes yaml file to specify how the application should be run. Fill the deployment.yaml file with the following content:

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
```

The key feature is the replicas field, which determines how many instances of the application to run. Initially, we set this to 1, but we will be scale this up to run multiple replicas to simulate how high availability and load balancing is done.

Let's apply these configurations.
Run:
````bash
kubectl apply -f deployment.yaml
kubectl wait --for=condition=available --timeout=60s deployment/express-app-deployment
kubectl get deployments
kubectl get pods
````
We deploy the application to Kubernetes, and the verification commands confirm that both the deployment and pods (running instances of your container) are up and running.

Let's now expose the port.
```bash
kubectl expose deployment express-app-deployment --type=NodePort --port=3000 --target-port=3000
```
This open a specific port on all nodes to handle traffic, so that we now can access the simultaneous Docker applications running locally on Minikube.

Finally, lets fetch our service url and curl the application to make sure it works.
```bash
minikube service express-app-deployment --url
curl $(minikube service express-app-deployment --url)
```

We have now completed step 3 and can move on to scaling up our application! 

