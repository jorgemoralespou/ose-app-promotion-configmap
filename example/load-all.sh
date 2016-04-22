#!/bin/sh

echo "Creating the projects...."
oc adm new-project node-app-dev
echo "node-app-dev project created for developers"
oc adm new-project node-app-test
echo "node-app-test project created for testers"

echo "Granting puller rights for the deployer serviceaccount in node-app-test project"

# To pull the image
#oc policy add-role-to-user system:image-puller system:serviceaccount:node-app-test:deployer -n node-app-dev
# TODO: Why the below and not the above. Also, those credentials seem to wide.
oc policy add-role-to-user edit system:serviceaccount:node-app-test:default -n node-app-dev

echo "Creating the deployment configuration for our applications"
echo "Creating configuration....."
oc create -f configmap-dev.json -n node-app-dev
echo "Configuration created for project node-app-dev"
oc create -f configmap-test.json -n node-app-test
echo "Configuration created for project node-app-test"

echo "Creating configuration....."
oc create -f node-app-example-dev.json -n node-app-dev
echo "Deployment created for project node-app-dev"
oc create -f node-app-example-test.json -n node-app-test
echo "Deployment created for project node-app-test"

echo "Building the app as developer"
oc start-build node-app -n node-app-dev --from-dir=.. --follow

echo ""
echo ""
echo "If you want to promote the application, you can:"
echo ""
echo "   oc tag node-app-dev/node-app:latest node-app-test/node-app:test   "
echo ""
echo ""
