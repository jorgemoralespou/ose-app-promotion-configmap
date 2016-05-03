#!/bin/sh

echo "Deleting the projects ...."
oc login 10.2.2.2:8443 -u admin -p admin
oc delete project/node-app-dev project/node-app-test 
