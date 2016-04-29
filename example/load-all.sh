#!/bin/sh

# You need 2 users (dev and test)


echo "Creating the Development project with user dev ...."
oc login 10.2.2.2:8443 -u dev -p dev
oc new-project node-app-dev
oc create -f configmap-dev.json
oc create -f node-app-deployment.json
oc create -f node-app-build.json


echo "Granting puller rights for the deployer serviceaccount in node-app-test project"
# TODO: Why the below and not the above. Also, those credentials seem to wide.
# This is for the serviceaccount to be able to get the image
oc policy add-role-to-user edit system:serviceaccount:node-app-test:default


oc login 10.2.2.2:8443 -u test -p test
oc new-project node-app-test
oc create -f configmap-test.json
oc create -f node-app-deployment.json
# This is for the user dev to be able to modify(tag) an ImageStream
oc policy add-role-to-user edit dev

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
echo "   oc tag node-app-dev/node-app:latest node-app-test/node-app:test   "
echo ""
echo ""
