### Tutorial Overview
This tutorial provides a guide to building, containerizing, and deploying a Node.js application using Docker and Kubernetes on a single local system. You will start by inspecting a small Node.js application in order to get familiar with the setup. You will then learn how to create a Dockerfile to containerize the application and run it locally to verify functionality. The tutorial continues with setting up a local Kubernetes cluster using Minikube. You will deploy the Docker container to Kubernetes, expose it via a Service, and scale the application by increasing the number of replicas. Moving on to more advanced features, the tutorial will demonstrate how to implement role-based access control (RBAC) within the Kubernetes environment. This is to show how you can manage permissions and ensure that different users and services have the appropriate level of access to resources. The tutorial will contain how to set up RBAC policies, create roles and role bindings, and assign them to users and service accounts. The tutorial will also use the Kubernetes secrets functionality.

![Alt text](../tutorial/assets/images/flowchart.png "Flowchart")

### Before we get started
There is a lot to install in order to get this tutorial up and running. Please do not proceed until the automatic installation has completed, you will know when it is done when you the terminal is cleared and all you see is :

ubuntu $ 