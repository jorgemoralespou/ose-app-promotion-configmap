#!/bin/sh

# You need 2 users (dev and test)

oc login 10.2.2.2:8443 -u dev -p dev
oc new-project node-app-dev
oc create -f configmap-dev.json
oc create -f node-app-deployment.json
oc create -f node-app-build.json

oc login 10.2.2.2:8443 -u test -p test
oc new-project node-app-test
oc create -f configmap-test.json
oc create -f node-app-deployment.json


oc login 10.2.2.2:8443 -u admin -p admin
oc create -f roles.json
oc adm policy add-role-to-user image-tagger dev -n demo-app-test 
oc adm policy add-role-to-user image-puller system:serviceaccount:node-app-test:deployer -n demo-app-dev


# Login in back as developer
oc login 10.2.2.2:8443 -u dev -p dev
echo ""
echo ""
echo "You're now user: dev"

echo ""
echo "Building the app as developer:"
echo ""
echo "  oc start-build node-app -n node-app-dev --from-dir=.. --follow  "
echo ""
echo ""
echo ""
echo "If you want to promote the application, you can:"
echo ""
echo "   oc tag node-app-dev/node-app:latest node-app-test/node-app:latest   "
echo ""
echo ""
