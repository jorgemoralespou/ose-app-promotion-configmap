#!/bin/sh

echo "Deleting the projects ...."
oc delete project/node-app-dev project/node-app-test 