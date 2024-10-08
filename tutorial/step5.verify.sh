#!/bin/bash

NAMESPACE="dev"
DEV_USER="system:serviceaccount:$NAMESPACE:dev-user"
VIEW_USER="system:serviceaccount:$NAMESPACE:view-user"
EXIT_STATUS=0

echo "Verifying RBAC for dev-user (developer role):"
echo "---------------------------------------------"

echo "Checking if dev-user can create pods..."
if ! kubectl auth can-i create pods --namespace=$NAMESPACE --as=$DEV_USER | grep -q 'yes'; then
    echo "ERROR: dev-user should be able to create pods but cannot."
    EXIT_STATUS=1
fi

echo "Checking if dev-user can update deployments..."
if ! kubectl auth can-i update deployments --namespace=$NAMESPACE --as=$DEV_USER | grep -q 'yes'; then
    echo "ERROR: dev-user should be able to update deployments but cannot."
    EXIT_STATUS=1
fi

echo "Checking if dev-user can delete services..."
if ! kubectl auth can-i delete services --namespace=$NAMESPACE --as=$DEV_USER | grep -q 'yes'; then
    echo "ERROR: dev-user should be able to delete services but cannot."
    EXIT_STATUS=1
fi

echo ""
echo "Verifying RBAC for view-user (viewer role):"
echo "-------------------------------------------"

echo "Checking if view-user can get pods..."
if ! kubectl auth can-i get pods --namespace=$NAMESPACE --as=$VIEW_USER | grep -q 'yes'; then
    echo "ERROR: view-user should be able to get pods but cannot."
    EXIT_STATUS=1
fi

echo "Checking if view-user can list services..."
if ! kubectl auth can-i list services --namespace=$NAMESPACE --as=$VIEW_USER | grep -q 'yes'; then
    echo "ERROR: view-user should be able to list services but cannot."
    EXIT_STATUS=1
fi

echo "Checking if view-user cannot delete deployments..."
if kubectl auth can-i delete deployments --namespace=$NAMESPACE --as=$VIEW_USER | grep -q 'yes'; then
    echo "ERROR: view-user should not be able to delete deployments but can."
    EXIT_STATUS=1
fi

if [ $EXIT_STATUS -eq 0 ]; then
    echo "All RBAC permissions are correctly set!"
else
    echo "There are errors in the RBAC configuration."
    exit 1
fi
