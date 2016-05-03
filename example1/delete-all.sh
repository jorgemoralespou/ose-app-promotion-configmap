#!/bin/sh

echo "Deleting the projects ...."
oc login 10.2.2.2:8443 -u example -p password
oc delete project/configmap-example
