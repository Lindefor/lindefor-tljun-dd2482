In this step, we will learn how to scale our application in Kubernetes using Minikube. Scaling is important for ensuring your application can handle increased traffic by running multiple instances or replicas of it. We use the kubectl scale command to increase the number of replicas for our deployment from one to three. This allows Kubernetes to create additional pods, effectively increasing our application's capacity.

Once scaled, we verify that the desired number of pods is running by checking the status with kubectl get deployments and kubectl get pods. Running multiple instances of the application also enables Kubernetes' built-in load balancing, which helps distribute incoming requests across all available pods. 

Let's begin.

To scale the application in Kubernetes using Minikube, you can increase the number of replicas by running:

````
kubectl scale deployment express-app-deployment --replicas=3
````

This command tells Kubernetes to run three instances of the express-app-deployment. You can verify the scaling by running:

````
kubectl get deployments
kubectl get pods
````

You should see three pods listed, indicating that Kubernetes has created additional instances of your application to meet the new replica count.

To observe the load balancing behavior, use:

````
curl $(minikube service express-app-deployment --url)
````

Run this command multiple times to see different pods handling the requests, which demonstrates Kubernetes' built-in load balancing for evenly distributing incoming traffic across all available pods. This scaling ability allows you to easily manage increased traffic, ensuring that your application remains responsive and performant.

You have now scaled up your application and completed step 4! Good job!
